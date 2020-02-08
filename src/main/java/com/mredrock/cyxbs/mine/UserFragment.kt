package com.mredrock.cyxbs.mine


import android.annotation.SuppressLint
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.lifecycle.Observer
import com.afollestad.materialdialogs.MaterialDialog
import com.alibaba.android.arouter.facade.annotation.Route
import com.alibaba.android.arouter.launcher.ARouter
import com.mredrock.cyxbs.common.BaseApp
import com.mredrock.cyxbs.common.config.*
import com.mredrock.cyxbs.common.event.AskLoginEvent
import com.mredrock.cyxbs.common.event.LoginStateChangeEvent
import com.mredrock.cyxbs.common.ui.BaseViewModelFragment
import com.mredrock.cyxbs.common.utils.extensions.editor
import com.mredrock.cyxbs.common.utils.extensions.loadAvatar
import com.mredrock.cyxbs.mine.page.about.AboutActivity
import com.mredrock.cyxbs.mine.page.answer.AnswerActivity
import com.mredrock.cyxbs.mine.page.ask.AskActivity
import com.mredrock.cyxbs.mine.page.comment.CommentActivity
import com.mredrock.cyxbs.mine.page.edit.EditInfoActivity
import com.mredrock.cyxbs.mine.page.sign.DailySignActivity
import com.mredrock.cyxbs.mine.util.user
import kotlinx.android.synthetic.main.mine_fragment_main.*
import org.greenrobot.eventbus.EventBus
import org.jetbrains.anko.support.v4.defaultSharedPreferences
import org.jetbrains.anko.support.v4.startActivity
import org.jetbrains.anko.support.v4.toast
import org.jetbrains.anko.textColor

/**
 * Created by zzzia on 2018/8/14.
 * 我的 主界面Fragment
 */
@Route(path = MINE_ENTRY)
class UserFragment : BaseViewModelFragment<UserViewModel>() {
    override val viewModelClass: Class<UserViewModel>
        get() = UserViewModel::class.java

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        addObserver()
        //加载资料
        viewModel.getUserInfo()
        user?.let { viewModel.getScoreStatus(it) }
        viewModel.getQANumber()

        //功能按钮
        mine_main_btn_sign.setOnClickListener { checkLoginBeforeAction("签到") { startActivity<DailySignActivity>() } }
        mine_main_tv_sign.setOnClickListener { checkLoginBeforeAction("签到") { startActivity<DailySignActivity>() } }
        mine_main_question_number.setOnClickListener { checkLoginBeforeAction("提问") { startActivity<AskActivity>() } }
        mine_main_tv_question.setOnClickListener { checkLoginBeforeAction("提问") { startActivity<AskActivity>() } }
        mine_main_answer_number.setOnClickListener { checkLoginBeforeAction("回答") { startActivity<AnswerActivity>() } }
        mine_main_tv_question.setOnClickListener { checkLoginBeforeAction("回答") { startActivity<AnswerActivity>() } }
        mine_main_reply_comment_number.setOnClickListener { checkLoginBeforeAction("评论回复") { startActivity<CommentActivity>() } }
        mine_main_tv_reply_comment.setOnClickListener { checkLoginBeforeAction("评论回复") { startActivity<CommentActivity>() } }
        mine_main_cl_info_edit.setOnClickListener { checkLoginBeforeAction("资料") { startActivity<EditInfoActivity>() } }

        mine_main_tv_about.setOnClickListener { startActivity<AboutActivity>() }
        mine_main_btn_exit.setOnClickListener { onExitClick() }
        mine_main_tv_feedback.setOnClickListener { onFeedBackClick() }
        mine_main_tv_custom_widget.setOnClickListener { onSetWidgetClick() }
        mine_main_tv_redrock.setOnClickListener { clickAboutUsWebsite() }
    }

    @SuppressLint("SetTextI18n")
    private fun addObserver() {
        viewModel.mUser.observe(this, Observer {
            refreshLayout()
        })
        viewModel.status.observe(this, Observer {
            mine_main_tv_sign.text = "已连续签到${it.serialDays}天 "
            if (it.isChecked) {
                mine_main_btn_sign.apply {
                    background = ResourcesCompat.getDrawable(resources, R.drawable.mine_bg_round_corner_grey, null)
                    text = "已签到"
                    textColor = ContextCompat.getColor(context, R.color.greyButtonText)
                }
            } else {
                mine_main_btn_sign.apply {
                    text = "签到"
                    background = ResourcesCompat.getDrawable(resources, R.drawable.mine_bg_round_corner_blue_gradient, null)
                    textColor = ContextCompat.getColor(context, R.color.mine_white)
                }
            }
        })
        viewModel.qaNumber.observe(this, Observer {
            mine_main_question_number.text = it.askPostedNumber.toString()
            mine_main_answer_number.text = it.answerPostedNumber.toString()
            mine_main_reply_comment_number.text = it.commentNumber.toString()
            mine_main_praise_number.text = it.praiseNumber.toString()
        })
    }

    private fun checkLoginBeforeAction(msg: String, action: () -> Unit) {
        if (BaseApp.isLogin) {
            action.invoke()
        } else {
            EventBus.getDefault().post(AskLoginEvent("请先登陆才能查看${msg}哦~"))
        }
    }

    override fun onResume() {
        super.onResume()
        refreshLayout()
        viewModel.getScoreStatus(user ?: return)
        viewModel.getQANumber()
    }

    //刷新界面
    private fun refreshLayout() {
        if (BaseApp.isLogin) {
            context?.loadAvatar(user?.photoThumbnailSrc, mine_main_avatar)
            mine_main_username.text = if (user?.nickname.isNullOrBlank()) getString(R.string.mine_user_empty_username) else user?.nickname
            mine_main_introduce.text = if (user?.introduction.isNullOrBlank()) getString(R.string.mine_user_empty_introduce) else user?.introduction
            mine_main_btn_exit.visibility = View.VISIBLE
        } else {
            mine_main_username.setText(R.string.mine_user_empty_username)
            mine_main_avatar.setImageResource(R.drawable.mine_default_avatar)
            mine_main_introduce.setText(R.string.mine_user_empty_introduce)
            mine_main_btn_exit.visibility = View.GONE
        }
    }

    override fun onLoginStateChangeEvent(event: LoginStateChangeEvent) {
        super.onLoginStateChangeEvent(event)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? =
            inflater.inflate(R.layout.mine_fragment_main, container, false)


    private fun onFeedBackClick() {
        if (!joinQQGroup("DXvamN9Ox1Kthaab1N_0w7s5N3aUYVIf")) {
            val clipboard = activity?.getSystemService(AppCompatActivity.CLIPBOARD_SERVICE) as ClipboardManager
            val data = ClipData.newPlainText("QQ Group", "570919844")
            clipboard.primaryClip = data
            toast("抱歉，由于您未安装手机QQ或版本不支持，无法跳转至掌邮bug反馈群。" + "已将群号复制至您的手机剪贴板，请您手动添加")
        }
    }


    /****************
     *
     * 发起添加群流程。群号：掌上重邮反馈群(570919844) 的 key 为： DXvamN9Ox1Kthaab1N_0w7s5N3aUYVIf
     * 调用 joinQQGroup(DXvamN9Ox1Kthaab1N_0w7s5N3aUYVIf) 即可发起手Q客户端申请加群 掌上重邮反馈群(570919844)
     *
     * @param key 由官网生成的key
     * @return 返回true表示呼起手Q成功，返回fals表示呼起失败
     */
    private fun joinQQGroup(key: String): Boolean {
        val intent = Intent()
        intent.data = Uri.parse("mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3D$key")
        // 此Flag可根据具体产品需要自定义，如设置，则在加群界面按返回，返回手Q主界面，不设置，按返回会返回到呼起产品界面    //intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        return try {
            startActivity(intent)
            true
        } catch (e: Exception) {
            // 未安装手Q或安装的版本不支持
            false
        }
    }


    private fun onSetWidgetClick() {
        ARouter.getInstance().build(WIDGET_SETTING).navigation()
    }


    private fun onExitClick() {
        MaterialDialog.Builder(context ?: return)
                .title("退出登录?")
                .content("是否退出当前账号?")
                .positiveText("退出")
                .negativeText("取消")
                .onPositive { _, _ ->
                    cleanAppWidgetCache()
                    //清除BaseApp.user和viewModel的user，必须要在LoginStateChangeEvent之前
                    viewModel.clearUser()

                    EventBus.getDefault().post(LoginStateChangeEvent(false))
                    //清空activity栈
                    val flag = Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK
                    ARouter.getInstance().build("/main/login").withFlags(flag.toInt()).navigation()
                }
                .show()
    }

    private fun cleanAppWidgetCache() {
        defaultSharedPreferences.editor {
            putString(WIDGET_COURSE, "")
            putBoolean(SP_WIDGET_NEED_FRESH, true)
        }
    }

    private fun clickAboutUsWebsite() {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(ABOUT_US_WEBSITE))
        startActivity(intent)
    }
}
