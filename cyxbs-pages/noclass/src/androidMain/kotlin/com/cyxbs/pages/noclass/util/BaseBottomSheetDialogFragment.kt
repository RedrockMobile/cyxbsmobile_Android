package com.cyxbs.pages.noclass.util

import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.cyxbs.components.base.utils.ArgumentHelper

open class BaseBottomSheetDialogFragment : BottomSheetDialogFragment() {

    fun <T : Any> arguments() = ArgumentHelper<T>{ requireArguments() }
}