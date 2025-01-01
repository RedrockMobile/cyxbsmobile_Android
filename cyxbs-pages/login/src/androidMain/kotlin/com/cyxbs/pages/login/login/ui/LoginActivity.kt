package com.cyxbs.pages.login.login.ui

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.core.content.edit
import com.cyxbs.components.account.api.IAccountService
import com.cyxbs.components.base.BaseApp
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.config.route.MINE_FORGET_PASSWORD
import com.cyxbs.components.config.sp.SP_PRIVACY_AGREED
import com.cyxbs.components.config.sp.defaultSp
import com.cyxbs.components.utils.extensions.appContext
import com.cyxbs.components.utils.service.impl
import com.cyxbs.components.utils.service.startActivity
import com.cyxbs.functions.update.api.IAppUpdateService
import com.cyxbs.pages.login.api.ILegalNoticeService
import com.cyxbs.pages.login.ui.LoginCompose
import com.cyxbs.pages.login.ui.UserAgreementDialog
import com.cyxbs.pages.login.viewmodel.LoginViewModel

/**
 * 登录界面
 *
 * 目前登录界面使用了多平台的 compose
 * 数据流方向: LoginCompose -> LoginViewModel -> LoginActivity
 * 由于 CommonLoginViewModel 抽了一层多平台通用逻辑后，LoginActivity 更多的逻辑是处理跳转，所以感觉有点代码有点少
 * 但如果后续是全界面上 Compose 的话，那个时候跳转就放到 Compose 层，目前因为跳转需要强耦合 activity，所以变成了这样
 *
 */
class LoginActivity : BaseActivity() {
  companion object {
    fun start(intent: (Intent.() -> Unit)? = null) {
      startInternal(false, null, intent)
    }

    fun start(
      successActivity: Class<out Activity>,
      intent: (Intent.() -> Unit)? = null
    ) {
      startInternal(false, successActivity, intent)
    }

    fun startReboot(intent: (Intent.() -> Unit)?) {
      startInternal(true, null, intent)
    }

    private fun startInternal(
      isReboot: Boolean,
      successActivity: Class<out Activity>?,
      intent: (Intent.() -> Unit)?
    ) {
      appContext.startActivity(
        Intent(appContext, LoginActivity::class.java)
          .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) // 因为使用 appContext，所以需要加
          .putExtra(LoginActivity::mIsReboot.name, isReboot)
          .apply {
            if (successActivity != null) {
              putExtra(
                LoginActivity::mSuccessIntent.name,
                Intent(appContext, successActivity)
                  .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) // 因为使用 appContext，所以需要加
              )
            }
            if (isReboot) {
              addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK) // 清空 Activity 栈
            }
            intent?.invoke(this)
          }
      )
    }
  }

  private val mIsReboot by intent<Boolean>()
  private val mSuccessIntent by intentNullable<Intent?>()

  private val mViewModel by viewModels<LoginViewModel>()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContent { LoginCompose() }
    initView()
    initObserveEvent()
    initUpdate()
  }

  private fun initView() {
    if (!mViewModel.isCheckUserArgument.value && !mIsActivityRebuilt) {
      // 显示用户协议 dialog
      showUserAgreement()
    }
  }

  private fun initObserveEvent() {
    mViewModel.event.collectLaunch {
      when (it) {
        LoginViewModel.Event.ClickForgetPassword -> onClickForgetPasswordEvent()
        LoginViewModel.Event.ClickPrivacyPolicy -> onClickPrivacyPolicy()
        LoginViewModel.Event.ClickUserAgreement -> onClickUserAgreement()
        is LoginViewModel.Event.Login -> onLoginEvent(it)
      }
    }
  }

  private fun onClickForgetPasswordEvent() {
    startActivity(MINE_FORGET_PASSWORD)
  }

  private fun onClickPrivacyPolicy() {
    ILegalNoticeService::class.impl().startPrivacyPolicyActivity(this)
  }

  private fun onClickUserAgreement() {
    ILegalNoticeService::class.impl().startUserAgreementActivity(this)
  }

  private fun onLoginEvent(event: LoginViewModel.Event.Login) {
    when (event.result) {
      null -> { // 游客模式
        IAccountService::class.impl().getVerifyService().loginByTourist()
        rebootApp()
      }
      true -> { // 登录成功
        if (mIsReboot) {
          rebootApp()
        } else {
          if (mSuccessIntent != null) {
            startActivity(mSuccessIntent)
          }
          finish()
        }
      }
      false -> { // 登录失败

      }
    }
  }

  private fun rebootApp() {
    val rebootIntent = appContext.packageManager
      .getLaunchIntentForPackage(appContext.packageName)!!
      .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
    startActivity(rebootIntent)
    finishAndRemoveTask()
  }

  private fun showUserAgreement() {
    UserAgreementDialog.Builder(this)
      .setPositiveClick {
        mViewModel.isCheckUserArgument.value = true
        BaseApp.baseApp.privacyAgree()
        dismiss()
        defaultSp.edit {
          putBoolean(SP_PRIVACY_AGREED, true)
        }
      }.setNegativeClick {
        mViewModel.isCheckUserArgument.value = false
        BaseApp.baseApp.privacyDenied()
        dismiss()
        finish()
      }.show()
  }


  private fun initUpdate() {
    IAppUpdateService::class.impl().tryNoticeUpdate(this, true)
  }
}