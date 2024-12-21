package com.cyxbs.pages.electricity.service

import android.annotation.SuppressLint
import androidx.core.content.edit
import com.google.auto.service.AutoService
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.api.account.IUserStateService
import com.mredrock.cyxbs.config.sp.defaultSp
import com.cyxbs.pages.electricity.config.SP_BUILDING_FOOT_KEY
import com.cyxbs.pages.electricity.config.SP_BUILDING_HEAD_KEY
import com.cyxbs.pages.electricity.config.SP_ROOM_KEY
import com.mredrock.cyxbs.init.InitialManager
import com.mredrock.cyxbs.init.InitialService
import com.mredrock.cyxbs.lib.utils.service.impl

/**
 * .
 *
 * @author 985892345
 * 2023/8/9 23:53
 */
@AutoService(InitialService::class)
class ElectricityInitialService : InitialService {
    @SuppressLint("CheckResult")
    override fun onMainProcess(manager: InitialManager) {
        super.onMainProcess(manager)
        IAccountService::class.impl
            .getVerifyService()
            .observeUserStateEvent()
            .subscribe {
                if (it == IUserStateService.UserState.NOT_LOGIN) {
                    // 移植的旧的逻辑
                    defaultSp.edit {
                        remove(SP_BUILDING_HEAD_KEY)
                        remove(SP_BUILDING_FOOT_KEY)
                        remove(SP_ROOM_KEY)
                    }
                }
            }
    }
}