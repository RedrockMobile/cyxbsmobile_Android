package com.cyxbs.pages.food.ui.view

import android.content.Context
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import com.cyxbs.pages.food.R
import com.cyxbs.components.base.dailog.ChooseDialog
import com.cyxbs.components.utils.extensions.color
import com.cyxbs.components.utils.extensions.dp2px

/**
 * Create by bangbangp on 2023/2/14 17:55
 * Email:1678921845@qq.com
 * Description:
 */
class FoodMainDialog private constructor(
    context: Context,
) : ChooseDialog(
    context,
) {

    class Builder(context: Context, data: Data) : ChooseDialog.Builder(
        context,
        data
    ) {
        override fun buildInternal(): ChooseDialog {
            return FoodMainDialog(context)
        }
    }

    override fun createContentView(parent: FrameLayout): View {
        return LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            addView(
                //标题
                TextView(context).apply {
                    text = "温馨提示"
                    layoutParams = LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams.MATCH_PARENT,
                        LinearLayout.LayoutParams.WRAP_CONTENT
                    ).apply {
                        topMargin = 28.dp2px
                    }
                    setTextColor(com.cyxbs.components.config.R.color.config_level_three_font_color.color)
                    textSize = 18F
                    gravity = Gravity.CENTER
                }
            )
            addView(
                TextView(context).apply {
                    layoutParams = LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams.MATCH_PARENT,
                        LinearLayout.LayoutParams.WRAP_CONTENT
                    ).apply {
                        text = data.content
                        gravity = Gravity.CENTER
                        topMargin = 10.dp2px
                        leftMargin = 18.dp2px
                        rightMargin = leftMargin
                        bottomMargin = 18.dp2px
                    }
                    setTextColor(com.cyxbs.components.config.R.color.config_alpha_level_two_font_color.color)
                    textSize = 14F
                }
            )
            addView(
                View(context).apply {
                    layoutParams = LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams.MATCH_PARENT,
                        1).apply {
                            bottomMargin = 20.dp2px
                    }
                    setBackgroundColor(R.color.food_text_dialog_line.color)
                }
            )
        }
    }

    override fun initContentView(view: View) {
        view as LinearLayout
    }
}