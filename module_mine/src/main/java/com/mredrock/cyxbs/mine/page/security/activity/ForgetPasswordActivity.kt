package com.mredrock.cyxbs.mine.page.security.activity

import android.os.Bundle
import android.view.View
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.account.IAccountService
import com.mredrock.cyxbs.common.config.MINE_FORGET_PASSWORD
import com.mredrock.cyxbs.common.service.ServiceManager
import com.mredrock.cyxbs.common.ui.BaseViewModelActivity
import com.mredrock.cyxbs.mine.R
import com.mredrock.cyxbs.mine.page.security.viewmodel.ForgetPasswordViewModel
import com.mredrock.cyxbs.mine.util.ui.ChooseFindTypeDialog
import com.mredrock.cyxbs.mine.util.ui.DefaultPasswordHintDialog
import kotlinx.android.synthetic.main.mine_activity_forget_password.*

/**
 * Author: SpreadWater
 * Time: 2020-10-29 15:06
 * describe: 在登陆界面点击忘记密码跳转到的界面
 */
@Route(path = MINE_FORGET_PASSWORD)
class ForgetPasswordActivity : BaseViewModelActivity<ForgetPasswordViewModel>() {
    override val isFragmentActivity = false
    private var stuNumber = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mine_activity_forget_password)
        common_toolbar.apply {
            setBackgroundColor(ContextCompat.getColor(this@ForgetPasswordActivity, R.color.common_white_background))
            initWithSplitLine("忘记密码",
                    false,
                    R.drawable.mine_ic_arrow_left,
                    View.OnClickListener {
                        finishAfterTransition()
                    })
            setTitleLocationAtLeft(true)
        }
        viewModel.defaultPassword.observe(this, Observer {
            if (it){
                //展示为默认密码的dialog
                DefaultPasswordHintDialog.show(this, this)
            }else{
                viewModel.checkBinding(stu_num = ServiceManager.getService(IAccountService::class.java).getUserService().getStuNum())
                //展示不同的找回密码方式的dialog
                ChooseFindTypeDialog.showDialog(this, viewModel.bindingEmail.value!!, viewModel.bindingPasswordProtect.value!!,this, true, stuNumber)
            }
        })
        mine_security_bt_forget_password_confirm.setOnClickListener {
            stuNumber = mine_security_et_foreget_password.text.toString()
            viewModel.checkDefaultPassword(stuNumber)
        }
    }
}