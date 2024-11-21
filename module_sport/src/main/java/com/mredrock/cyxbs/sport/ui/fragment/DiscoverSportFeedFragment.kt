package com.mredrock.cyxbs.sport.ui.fragment

import android.content.Intent
import android.graphics.Typeface
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.FrameLayout
import android.widget.TextView
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.customview.customView
import com.afollestad.materialdialogs.customview.getCustomView
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.config.route.DISCOVER_SPORT_FEED
import com.mredrock.cyxbs.lib.base.ui.BaseBindFragment
import com.mredrock.cyxbs.lib.utils.extensions.gone
import com.mredrock.cyxbs.lib.utils.extensions.setOnSingleClickListener
import com.mredrock.cyxbs.lib.utils.extensions.visible
import com.mredrock.cyxbs.lib.utils.service.impl
import com.mredrock.cyxbs.sport.R
import com.mredrock.cyxbs.sport.databinding.SportFragmentDiscoverFeedBinding
import com.mredrock.cyxbs.sport.model.SportDetailBean
import com.mredrock.cyxbs.sport.model.SportDetailRepository
import com.mredrock.cyxbs.sport.model.SportNoticeRepository
import com.mredrock.cyxbs.sport.ui.activity.SportDetailActivity

/**
 * @author : why
 * @time   : 2022/8/12 17:11
 * @bless  : God bless my code
 * @description: 首页展示体育打卡数据的fragment
 */
@Route(path = DISCOVER_SPORT_FEED)
class DiscoverSportFeedFragment :
    BaseBindFragment<SportFragmentDiscoverFeedBinding>() {

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {

        val feedDialogCustomView = LayoutInflater.from(requireContext())
            .inflate(R.layout.sport_dialog_feed, FrameLayout(requireContext()), false).apply {
                //体育打卡信息说明改成后端下发
                SportNoticeRepository.noticeData.observe { result ->
                    result.onSuccess {
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_title1).text =
                            it[0].title
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_content1).text =
                            it[0].content
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_title2).text =
                            it[1].title
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_content2).text =
                            it[1].content
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_title3).text =
                            it[2].title
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_content3).text =
                            it[2].content
                    }.onFailure {
                        findViewById<TextView>(R.id.sport_tv_feed_dialog_title1).apply {
                            text ="数据加载失败，正在努力修复中~"
                            gravity = Gravity.CENTER_HORIZONTAL
                            typeface = Typeface.defaultFromStyle(Typeface.NORMAL)
                        }
                    }
                }
            }

        binding.sportIvFeedTips.setOnSingleClickListener {
            MaterialDialog(requireActivity()).show {
                customView(view=feedDialogCustomView)
                getCustomView().apply {
                    findViewById<Button>(R.id.sport_btn_feed_dialog_confirm).setOnSingleClickListener {
                        dismiss()
                    }
                }
                cornerRadius(16f)
            }
        }
        //进入首页后对登录和绑定状态进行判断
        if (!IAccountService::class.impl.getVerifyService().isLogin()) {
            notLogin()
        } else {
            SportDetailRepository.sportData.observe {
                it.onSuccess {
                    showData(it)
                }.onFailure {
                    showError()
                }
            }
        }
    }

    /**
     * 加载数据
     */
    private fun showData(beam: SportDetailBean) {
        binding.run {
            //隐藏提示
            sportTvFeedHint.gone()
            //显示数据
            sportTvFeedRunNeed.visible()
            sportTvFeedRunTimes.visible()
            sportTvFeedOtherNeed.visible()
            sportTvFeedOtherTimes.visible()
            sportTvFeedAward.visible()
            sportTvFeedAwardTimes.visible()
            sportTvFeedRunNeedHint.visible()
            sportTvFeedOtherNeedHint.visible()
            sportTvFeedAwardHint.visible()
            //跑步剩余次数 = 所需跑步次数 - 已跑步次数， 剩余次数需要 >= 0
            sportTvFeedRunNeed.text =
                if (beam.runTotal - beam.runDone >= 0) (beam.runTotal - beam.runDone).toString() else "0"
            //其他 剩余次数
            val other = if (beam.runTotal - beam.runDone > 0) {
                //剩余跑步次数大于零时，其他次数 = 所需其他次数 - 已打卡次数
                beam.otherTotal - beam.otherDone
            } else {
                //剩余跑步次数 <= 0 时，其他次数 = 所需总次数 - 已打卡其他次数 - 已跑步次数
                (beam.runTotal + beam.otherTotal) - beam.otherDone - beam.runDone
            }
            //其他剩余次数必须 >= 0
            sportTvFeedOtherNeed.text = if (other >= 0) other.toString() else "0"
            //奖励次数
            sportTvFeedAward.text = beam.award.toString()
            //设置点击跳转进详情页
            sportClFeed.setOnSingleClickListener {
                startActivity(Intent(requireContext(), SportDetailActivity::class.java))
            }
        }
    }

    /**
     * 用于未登录时（游客模式）加载提示
     */
    private fun notLogin() {
        //游客模式则不显示数据，显示需要先登录
        binding.run {
            //隐藏用于显示数据的控件
            sportTvFeedRunNeed.gone()
            sportTvFeedRunTimes.gone()
            sportTvFeedOtherNeed.gone()
            sportTvFeedOtherTimes.gone()
            sportTvFeedAward.gone()
            sportTvFeedAwardTimes.gone()
            sportTvFeedRunNeedHint.gone()
            sportTvFeedOtherNeedHint.gone()
            sportTvFeedAwardHint.gone()
            sportTvFeedHint.text = "登录后才能查看体育打卡哦"
            sportTvFeedHint.visible()
        }
    }

    /**
     * 展示错误提示
     */
    private fun showError() {
        binding.run {
            //隐藏用于显示数据的控件
            sportTvFeedRunNeed.gone()
            sportTvFeedRunTimes.gone()
            sportTvFeedOtherNeed.gone()
            sportTvFeedOtherTimes.gone()
            sportTvFeedAward.gone()
            sportTvFeedAwardTimes.gone()
            sportTvFeedRunNeedHint.gone()
            sportTvFeedOtherNeedHint.gone()
            sportTvFeedAwardHint.gone()
            sportTvFeedHint.text = "当前数据错误，正在努力修复中"
            sportTvFeedHint.visible()
        }
    }
}