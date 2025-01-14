package com.mredrock.cyxbs.common.utils.extensions

import android.content.Context
import android.content.DialogInterface
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.tbruyelle.rxpermissions3.RxPermissions

/**
 * 简化运行时权限的操作
 *
 * Created By jay68 on 2018/8/9.
 */

/*
eg:
doPermissionAction(Manifest.permission.READ_PHONE_STATE, Manifest.permission.CALL_PHONE) {
    reason = "为使用xxx需要您的xxx权限"  //optional. show a dialog to tell user why need this permission before request permission

    doAfterGranted {
        //optional. do something after permission granted
    }

    doAfterRefused {
        //optional. do something after permission refused by user
    }
}

// if you think this may cause user feel bad, you can add a neverNotice flag like this:
doPermissionAction(Manifest.permission.READ_PHONE_STATE, Manifest.permission.CALL_PHONE) {
    isShowNeverNotice = true
    tag = "xxx" //optional. mark a flag in sharePreference to convenient skip show request in next time

    ...
    //others are the same as above
}

// also,you can give a choice to cancel this dialog, but this dialog also show in next time.
// you just add a flag called:isShowCancelNotice = true
// but there, show never notice and show cancel notice are opposite, and priority : never notice > cancel notice
*/
@Deprecated("使用 utils 中的 PermissionActionBuilder")
class PermissionActionBuilder {
    var doAfterGranted: () -> Unit = {}
        private set
    var doAfterRefused: (() -> Unit)? = null
        private set
    var reason: String? = null

    var isShowNeverNotice = false

    var isShowCancelNotice = false

    var tag: String? = null


    fun doAfterGranted(action: () -> Unit) {
        doAfterGranted = action
    }

    fun doAfterRefused(action: () -> Unit) {
        doAfterRefused = action
    }
}

private fun requestPermission(
    rxPermissions: RxPermissions,
    builder: PermissionActionBuilder,
    vararg permissionsToRequest: String
) =
    rxPermissions.request(*permissionsToRequest).subscribe { granted ->
        if (granted) {
            builder.doAfterGranted()
        } else {
            builder.doAfterRefused?.invoke()
        }
    }

private fun performRequestPermission(
    context: Context,
    rxPermissions: RxPermissions,
    vararg permissionsRequired: String,
    actionBuilder: PermissionActionBuilder.() -> Unit
) {
    val builder = PermissionActionBuilder().apply(actionBuilder)
    val permissionsToRequest = permissionsRequired.filterNot { rxPermissions.isGranted(it) }

    when {
        context.sharedPreferences(
            builder.tag
                ?: permissionsRequired.toString()
        ).getBoolean("isNeverShow", false) -> Unit
        permissionsToRequest.isEmpty() -> builder.doAfterGranted.invoke()
        builder.reason != null ->
            AlertDialog.Builder(context).apply {
                setMessage(builder.reason)
                setPositiveButton(android.R.string.ok) { _: DialogInterface, i: Int ->
                    requestPermission(rxPermissions, builder, *permissionsToRequest.toTypedArray())
                }
                if (builder.isShowNeverNotice) {
                    setNegativeButton("不再提示") { _: DialogInterface, i: Int ->
                        context.sharedPreferences(
                            builder.tag
                                ?: permissionsRequired.toString()
                        ).editor {
                            putBoolean("isNeverShow", true)
                        }
                    }
                } else if (builder.isShowCancelNotice) {
                    setNegativeButton(android.R.string.cancel) { _: DialogInterface, i: Int ->

                    }

                }
            }.show()
        else -> requestPermission(rxPermissions, builder, *permissionsToRequest.toTypedArray())
    }
}

@Deprecated("使用 utils 中的 FragmentActivity#doPermissionAction()")
fun AppCompatActivity.doPermissionAction(
    vararg permissionsRequired: String,
    actionBuilder: PermissionActionBuilder.() -> Unit
) {
    performRequestPermission(
        this,
        RxPermissions(this),
        *permissionsRequired,
        actionBuilder = actionBuilder
    )
}

@Deprecated("使用 utils 中的 Fragment#doPermissionAction()")
fun Fragment.doPermissionAction(
    vararg permissionsRequired: String,
    actionBuilder: PermissionActionBuilder.() -> Unit
) {
    performRequestPermission(
        activity!!,
        RxPermissions(this),
        *permissionsRequired,
        actionBuilder = actionBuilder
    )
}