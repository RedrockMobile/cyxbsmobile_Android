package com.mredrock.cyxbs.mine.util.widget

import android.content.Context
import android.util.AttributeSet
import android.widget.Switch
import com.mredrock.cyxbs.lib.utils.extensions.dp2px

/**
 * Created by roger on 2019/12/12
 *
 * 学长 java 移植
 */
//通过反射来更改Switch的宽度
class SwitchPlus(
  context: Context,
  attrs: AttributeSet?
) : Switch(context, attrs) {

  private val mSwitchWidthField by lazy {
    val clazz = Class.forName(Switch::class.java.name)
    val switchWidth = clazz.getDeclaredField("mSwitchWidth")
    switchWidth.isAccessible = true
    switchWidth
  }

  override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
    super.onMeasure(widthMeasureSpec, heightMeasureSpec)
    //通过反射来更改switch的宽度
    try {
      mSwitchWidthField.set(this, 50.dp2px)
    } catch (e: ClassNotFoundException) {
      e.printStackTrace()
    } catch (e: IllegalAccessException) {
      e.printStackTrace()
    } catch (e: NoSuchFieldException) {
      e.printStackTrace()
    }
  }
}
