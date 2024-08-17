package com.cyxbsmobile_single.module_todo.ui.dialog

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.LayoutInflater
import android.widget.GridLayout
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.appcompat.widget.AppCompatButton
import androidx.core.content.ContextCompat
import com.cyxbsmobile_single.module_todo.R
import com.cyxbsmobile_single.module_todo.util.weekStringList
import com.google.android.material.bottomsheet.BottomSheetDialog
import java.util.Calendar

/**
 * description: 选择日期的Dialog
 * author: sanhuzhen
 * date: 2024/8/11 22:45
 */
class CalendarDialog(context: Context, val onCalendarSelected: (Int, Int, Int, Int, Int) -> Unit) :
    BottomSheetDialog(context, R.style.BottomSheetDialogTheme) {


    //设置一个选中状态的TextView，用于将背景销毁
    private var selectedDayView: TextView? = null

    //选择的时间
    private var selectHour = 24
    private var selectMinute = 60
    private val calendar = Calendar.getInstance()
    private val currentDay = calendar.get(Calendar.DAY_OF_MONTH)
    private val currentMonth = calendar.get(Calendar.MONTH)
    private val currentYear = calendar.get(Calendar.YEAR)


    private val tvCalendarHeader by lazy { findViewById<TextView>(R.id.todo_tv_header_calendar) }
    private val ivPreMonth by lazy { findViewById<ImageView>(R.id.todo_iv_pre_month) }
    private val ivNextMonth by lazy { findViewById<ImageView>(R.id.todo_iv_next_month) }
    private val glWeekCalendar by lazy { findViewById<GridLayout>(R.id.todo_gl_week) }
    private val glCalendar by lazy { findViewById<GridLayout>(R.id.todo_gl_calendar) }
    private val rlCalendar by lazy { findViewById<RelativeLayout>(R.id.todo_rl_calendar) }
    private val btnConfirm by lazy { findViewById<AppCompatButton>(R.id.todo_btn_confirm_calendar) }
    private val btnCancel by lazy { findViewById<AppCompatButton>(R.id.todo_btn_cancel_calendar) }
    private val tvSelectTime by lazy { findViewById<TextView>(R.id.todo_tv_time_calendar) }

    init {
        val dialogView = LayoutInflater.from(context)
            .inflate(R.layout.todo_dialog_bottom_sheet_calendar, null, false)
        setContentView(dialogView)

        dialogView?.apply {
            //设置日历
            setCalendar()
            initClick()
        }
    }

    @SuppressLint("SetTextI18n", "DefaultLocale")
    private fun initClick() {
        ivPreMonth?.setOnClickListener {
            changeMonth(-1)
        }
        ivNextMonth?.setOnClickListener {
            changeMonth(1)
        }

        rlCalendar?.setOnClickListener {

            //传递选中的时间，判断是不是当前这一天
            TimeSelectDialog(
                context,
                calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH),
                calendar.get(Calendar.DAY_OF_MONTH)
            ) { hour, minute ->
                selectHour = hour
                selectMinute = minute
                tvSelectTime?.text = "${
                    String.format(
                        "%02d", selectHour
                    )
                }:${
                    String.format(
                        "%02d", selectMinute
                    )
                }"
            }.show()
        }

        btnConfirm?.setOnClickListener {
            //回传选择的日期
            onCalendarSelected(
                calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH) + 1,
                calendar.get(Calendar.DAY_OF_MONTH),
                selectHour,
                selectMinute
            )
            dismiss()
        }
        btnCancel?.setOnClickListener {
            dismiss()
        }
    }

    /**
     * 设置日历
     */
    private fun setCalendar() {
        setWeekOfCalendar()
        setDayOfCalendar()
    }

    private fun setWeekOfCalendar() {
        //填充星期
        for (i in 0..6) {
            val weekView = TextView(context).apply {
                textSize = 16f
                gravity = Gravity.CENTER
                setTextColor(Color.GRAY)
                text = weekStringList[i]
            }
            glWeekCalendar?.addView(weekView, createGridLayoutParam())
        }
    }

    private fun setDayOfCalendar() {
        glCalendar?.removeAllViews()

        calendar.set(Calendar.DAY_OF_MONTH, 1)
        val firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1 //获取当前月份第一天是星期几

        val daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH) //获取当前月份的天数

        calendar.set(Calendar.DAY_OF_MONTH, currentDay)

        //填充之前的空白天数
        for (i in 1 until firstDayOfWeek) {
            val emptyView = TextView(context)
            glCalendar?.addView(emptyView, createGridLayoutParam())
        }

        //填充当前月份的天数
        for (day in 1..daysInMonth) {
            val dayView = createDayTextView(day)
            dayView.setOnClickListener {
                if (calendar.get(Calendar.YEAR) > currentYear || (calendar.get(Calendar.YEAR) == currentYear && calendar.get(
                        Calendar.MONTH
                    ) > currentMonth) || (calendar.get(Calendar.YEAR) == currentYear && calendar.get(
                        Calendar.MONTH
                    ) == currentMonth && day >= currentDay)
                ) {
                    //用户点击日期时触发
                    calendar.set(Calendar.DAY_OF_MONTH, day)
                    selectedDayView?.background = null
                    dayView.background = ContextCompat.getDrawable(
                        context, R.drawable.todo_shape_bg_day_select
                    ) //根据需要设置背景
                    selectedDayView = dayView
                }
            }
            glCalendar?.addView(dayView, createGridLayoutParam())
        }
    }

    //创建日期TextView
    @SuppressLint("ResourceAsColor")
    private fun createDayTextView(day: Int): TextView {
        return TextView(context).apply {
            text = day.toString()
            textSize = 16f
            gravity = Gravity.CENTER
            setPadding(10, 10, 10, 10)
            val year = calendar.get(Calendar.YEAR)
            val month = calendar.get(Calendar.MONTH)
            val dayColor = when {
                year > currentYear -> Color.BLACK
                year < currentYear -> Color.GRAY
                month < currentMonth -> Color.GRAY
                month > currentMonth -> Color.BLACK
                day > currentDay -> Color.BLACK
                day < currentDay -> Color.GRAY
                else -> {
                    if (selectedDayView == null) {
                        selectedDayView = this
                        background =
                            ContextCompat.getDrawable(context, R.drawable.todo_shape_bg_day_select)
                    }
                    Color.BLUE
                }
            }

            setTextColor(dayColor)
        }
    }

    //创建GridLayout的布局参数
    private fun createGridLayoutParam(): GridLayout.LayoutParams {
        return GridLayout.LayoutParams().apply {
            width = GridLayout.LayoutParams.WRAP_CONTENT
            height = GridLayout.LayoutParams.WRAP_CONTENT
            columnSpec = GridLayout.spec(GridLayout.UNDEFINED, 1f)
            rowSpec = GridLayout.spec(GridLayout.UNDEFINED, GridLayout.FILL)
            setMargins(25, 25, 25, 25)
        }
    }

    @SuppressLint("DefaultLocale", "SetTextI18n")
    private fun changeMonth(amount: Int) {
        calendar.add(Calendar.MONTH, amount)
        setDayOfCalendar() //刷新日历${calendar.get(Calendar.MONTH) + 1}月
        tvCalendarHeader?.text =
            "${calendar.get(Calendar.YEAR)}年${calendar.get(Calendar.MONTH) + 1}月"
    }
}