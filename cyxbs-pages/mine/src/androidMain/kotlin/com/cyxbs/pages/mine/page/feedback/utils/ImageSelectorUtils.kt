package com.cyxbs.pages.mine.page.feedback.utils

import android.Manifest
import android.net.Uri
import androidx.fragment.app.FragmentActivity
import com.cyxbs.components.utils.extensions.doPermissionAction
import com.cyxbs.components.utils.extensions.toastLong
import top.limuyang2.photolibrary.LPhotoHelper
import top.limuyang2.photolibrary.util.LPPImageType

/**
 *@author ZhiQiang Tu
 *@time 2021/8/25  13:31
 *@signature 我们不明前路，却已在路上
 */
const val CHOOSE_FEED_BACK_PIC = 0x101010
fun FragmentActivity.selectImageFromAlbum(maxCount: Int, list: List<Uri>) {
    doPermissionAction(Manifest.permission.WRITE_EXTERNAL_STORAGE) {
        doAfterGranted {
            LPhotoHelper.Builder()
                .maxChooseCount(maxCount) //最多选几个
                .selectedPhotos(ArrayList(list.map { it.path!! }))
                .columnsNumber(3) //每行显示几列图片
                .imageType(LPPImageType.ofAll()) // 文件类型
                .pauseOnScroll(false) // 是否滑动暂停加载图片显示
                .isSingleChoose(false) // 是否是单选
                .isOpenLastAlbum(false) // 是否直接打开最后一次选择的相册
                .theme(com.cyxbs.components.config.R.style.ConfigLPhotoTheme)
                .build()
                .start(this@selectImageFromAlbum, CHOOSE_FEED_BACK_PIC)
        }
        doAfterRefused {
            toastLong("访问相册失败，原因：未授权")
        }
    }
}

