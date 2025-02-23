package com.cyxbs.pages.volunteer.fragment

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.util.SparseArray
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import android.widget.LinearLayout
import android.widget.PopupWindow
import android.widget.TextSwitcher
import android.widget.TextView
import android.widget.ViewSwitcher
import androidx.core.content.ContextCompat
import androidx.core.util.containsKey
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.cyxbs.components.base.ui.BaseFragment
import com.mredrock.cyxbs.common.utils.extensions.dp2px
import com.cyxbs.pages.volunteer.R
import com.cyxbs.pages.volunteer.adapter.PopupWindowRvAdapter
import com.cyxbs.pages.volunteer.adapter.VolunteerRecordAdapter
import com.cyxbs.pages.volunteer.bean.VolunteerTime
import com.cyxbs.pages.volunteer.event.VolunteerLoginEvent
import com.cyxbs.pages.volunteer.utils.DateUtils
import com.cyxbs.pages.volunteer.viewmodel.VolunteerRecordViewModel
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode

/**
 * Created by yyfbe, Date on 2020/9/4.
 */
class VolunteerRecordFragment : BaseFragment(), ViewSwitcher.ViewFactory {

    //last当前，first最早的一年
    private val firstYear by lazy(LazyThreadSafetyMode.NONE) { mutableListOf<VolunteerTime.RecordBean>() }
    private val secondYear by lazy(LazyThreadSafetyMode.NONE) { mutableListOf<VolunteerTime.RecordBean>() }
    private val thirdYear by lazy(LazyThreadSafetyMode.NONE) { mutableListOf<VolunteerTime.RecordBean>() }
    private val lastYear by lazy(LazyThreadSafetyMode.NONE) { mutableListOf<VolunteerTime.RecordBean>() }
    private val volunteer_time_recycler by R.id.volunteer_time_recycler.view<RecyclerView>()
    private val swc_volunteer_record_year by R.id.swc_volunteer_record_year.view<TextSwitcher>()
    private val tv_volunteer_record_year_time by R.id.tv_volunteer_record_year_time.view<TextView>()
    private val srl_refresh by R.id.srl_refresh.view<SwipeRefreshLayout>()
    private val ll_volunteer_record_year by R.id.ll_volunteer_record_year.view<LinearLayout>()

    //每年在rv的index
    private var firstYearIndex = -1
    private var secondYearIndex = -1
    private var thirdYearIndex = -1
    private var lastYearIndex = -1

    //每年的时长
    private var firstYearValue = 0f
    private var secondYearValue = 0f
    private var thirdYearValue = 0f
    private var lastYearValue = 0f
    private var viewModel: VolunteerRecordViewModel? = null

    //目前定位到的年份
    private var currentIndexYear = 0
    private val yearsMap by lazy(LazyThreadSafetyMode.NONE) { SparseArray<MutableList<VolunteerTime.RecordBean>>() }
    private val years: List<Int> by lazy(LazyThreadSafetyMode.NONE) {
        listOf(
            DateUtils.thisYear(),
            (DateUtils.thisYear() - 1),
            (DateUtils.thisYear() - 2),
            (DateUtils.thisYear() - 3)
        )
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return LayoutInflater.from(context)
            .inflate(R.layout.volunteer_fragment_volunteer_time, container, false)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        viewModel =
            activity?.let { ViewModelProvider(it).get(VolunteerRecordViewModel::class.java) }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        EventBus.getDefault().register(this) // 不建议使用 EventBus
        initView()
        initSwitch()
        initObserve()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        EventBus.getDefault().unregister(this) // 不建议使用 EventBus
    }

    private fun recyclerViewListener() {
        volunteer_time_recycler.apply {
            addOnScrollListener(object : RecyclerView.OnScrollListener() {
                override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
                    super.onScrolled(recyclerView, dx, dy)
                    when ((layoutManager as LinearLayoutManager).findFirstCompletelyVisibleItemPosition()) {
                        firstYearIndex -> {
                            if (currentIndexYear == 0) return
                            currentIndexYear = 0
                            swc_volunteer_record_year.setText(
                                getString(
                                    R.string.volunteer_string_year,
                                    years[3].toString()
                                )
                            )
                            tv_volunteer_record_year_time.text = resources.getString(
                                R.string.volunteer_string_hours_all,
                                firstYearValue.toString()
                            )
                        }

                        secondYearIndex, firstYearIndex - 1 -> {
                            if (currentIndexYear == 1) return
                            currentIndexYear = 1
                            swc_volunteer_record_year.setText(
                                getString(
                                    R.string.volunteer_string_year,
                                    years[2].toString()
                                )
                            )
                            tv_volunteer_record_year_time.text = resources.getString(
                                R.string.volunteer_string_hours_all,
                                secondYearValue.toString()
                            )
                        }

                        thirdYearIndex, secondYearIndex - 1 -> {
                            if (currentIndexYear == 2) return
                            currentIndexYear = 2
                            swc_volunteer_record_year.setText(
                                getString(
                                    R.string.volunteer_string_year,
                                    years[1].toString()
                                )
                            )
                            tv_volunteer_record_year_time.text = resources.getString(
                                R.string.volunteer_string_hours_all,
                                thirdYearValue.toString()
                            )
                        }

                        lastYearIndex, thirdYearIndex - 1 -> {
                            if (currentIndexYear == 3) return
                            currentIndexYear = 3
                            swc_volunteer_record_year.setText(
                                getString(
                                    R.string.volunteer_string_year,
                                    years[0].toString()
                                )
                            )
                            tv_volunteer_record_year_time.text = resources.getString(
                                R.string.volunteer_string_hours_all,
                                lastYearValue.toString()
                            )
                        }
                    }


                }
            })
        }
    }

    @SuppressLint("StringFormatMatches")
    private fun initObserve() {
        viewModel?.volunteerTime?.observe(viewLifecycleOwner, Observer {
            if (srl_refresh.isRefreshing) {
                srl_refresh.isRefreshing = false
            }
            volunteer_time_recycler.adapter =
                it.record?.let { data -> VolunteerRecordAdapter(data) }
            val thisYear = DateUtils.thisYear()
            if (!it.record.isNullOrEmpty()) {
                //重置
                reset()
                for ((index, i) in it.record!!.withIndex()) {
                    when (DateUtils.getYear(i.start_time.toString())) {
                        thisYear -> {
                            lastYear.add(i)
                            lastYearValue += i.hours?.toFloat() ?: 0f
                            //对空进行处理，不添加
                            yearsMap.put(years[0], lastYear)
                            if (lastYearIndex == -1) {
                                lastYearIndex = 0
                            }
                        }

                        thisYear - 1 -> {
                            thirdYear.add(i)
                            thirdYearValue += i.hours?.toFloat() ?: 0f
                            yearsMap.put(years[1], thirdYear)
                            if (thirdYearIndex == -1) {
                                thirdYearIndex = index
                            }
                        }

                        thisYear - 2 -> {
                            secondYear.add(i)
                            secondYearValue += i.hours?.toFloat() ?: 0f
                            yearsMap.put(years[2], secondYear)
                            if (secondYearIndex == -1) {
                                secondYearIndex = index
                            }
                        }

                        thisYear - 3 -> {
                            firstYear.add(i)
                            firstYearValue += i.hours?.toFloat() ?: 0f
                            yearsMap.put(years[3], firstYear)
                            if (firstYearIndex == -1) {
                                firstYearIndex = index
                            }
                        }

                        else -> {
                            //啊这，这种情况，高中就加时长了吗，那就直接展示，不给定位了
                        }
                    }
                }
            }
            recyclerViewListener()
            val displayTime: String = when {
                lastYearValue > 0 -> {
                    lastYearValue.toString()
                }

                thirdYearValue > 0 -> {
                    thirdYearValue.toString()
                }

                secondYearValue > 0 -> {
                    secondYearValue.toString()
                }

                firstYearValue > 0 -> {
                    firstYearValue.toString()
                }

                else -> {
                    it.hours.toString()
                }
            }
            tv_volunteer_record_year_time.text =
                resources.getString(R.string.volunteer_string_hours_all, displayTime)
            showPopup()
        })
    }

    private fun initView() {
        volunteer_time_recycler.layoutManager = LinearLayoutManager(context)
        srl_refresh.setOnRefreshListener {
            viewModel?.getVolunteerTime()
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN, sticky = true)
    fun getVolunteerTime(volunteerLoginEvent: VolunteerLoginEvent) {
        viewModel?.volunteerTime?.value = volunteerLoginEvent.volunteerTime
    }

    private fun showPopup() {
        val displayList = mutableListOf<String>()
        for (i in years) {
            if (yearsMap.containsKey(i)) {
                displayList.add(i.toString())
            }
        }
        val popupView = View.inflate(context, R.layout.volunteer_layout_pop_year_menu, null)
        val popupWindow = PopupWindow(
            popupView,
            ViewGroup.LayoutParams.WRAP_CONTENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        popupWindow.isOutsideTouchable = true
        popupView.findViewById<RecyclerView>(R.id.rl_pop_menu_year).apply {
            layoutManager = LinearLayoutManager(context)
            adapter = PopupWindowRvAdapter(displayList) {
                swc_volunteer_record_year.setText(it)
                onPopupMenuItemClick(it)
                popupWindow.dismiss()
            }
        }

        ll_volunteer_record_year.setOnClickListener {
            context ?: return@setOnClickListener
            if (!popupWindow.isShowing) {
                popupWindow.showAsDropDown(
                    swc_volunteer_record_year,
                    requireContext().dp2px(-8f),
                    0
                )
                popupWindow.update()
            } else {
                popupWindow.dismiss()
            }
        }

    }

    private fun onPopupMenuItemClick(title: String) {
        swc_volunteer_record_year.setText(getString(R.string.volunteer_string_year, title))
        val mLayoutManager = volunteer_time_recycler.layoutManager as LinearLayoutManager
        when (title) {
            DateUtils.thisYear().toString() -> {
                //加上判断，以防出错时使用了默认-1
                if (lastYearIndex >= 0) {
                    mLayoutManager.scrollToPositionWithOffset(lastYearIndex, 0)
//                    volunteer_time_recycler.smoothScrollToPosition(lastYearIndex)
                    tv_volunteer_record_year_time.text = resources.getString(
                        R.string.volunteer_string_hours_all,
                        lastYearValue.toString()
                    )
                }
            }

            (DateUtils.thisYear() - 1).toString() -> {
                if (thirdYearIndex >= 0) {
                    mLayoutManager.scrollToPositionWithOffset(thirdYearIndex, 0)
//                    volunteer_time_recycler.smoothScrollToPosition(thirdYearIndex)
                    tv_volunteer_record_year_time.text = resources.getString(
                        R.string.volunteer_string_hours_all,
                        thirdYearValue.toString()
                    )
                }
            }

            (DateUtils.thisYear() - 2).toString() -> {
                if (secondYearIndex >= 0) {
                    mLayoutManager.scrollToPositionWithOffset(secondYearIndex, 0)
//                    volunteer_time_recycler.smoothScrollToPosition(secondYearIndex)
                    tv_volunteer_record_year_time.text = resources.getString(
                        R.string.volunteer_string_hours_all,
                        secondYearValue.toString()
                    )
                }
            }

            (DateUtils.thisYear() - 3).toString() -> {
                if (firstYearIndex >= 0) {
                    mLayoutManager.scrollToPositionWithOffset(firstYearIndex, 0)
//                    volunteer_time_recycler.smoothScrollToPosition(firstYearIndex)
                    tv_volunteer_record_year_time.text = resources.getString(
                        R.string.volunteer_string_hours_all,
                        firstYearValue.toString()
                    )
                }
            }
        }
    }

    private fun reset() {
        lastYearValue = 0f
        thirdYearValue = 0f
        secondYearValue = 0f
        firstYearValue = 0f
        lastYear.clear()
        thirdYear.clear()
        secondYear.clear()
        firstYear.clear()
    }

    private fun initSwitch() {
        // 设置转换动画，这里引用系统自带动画
        val inAnim = AnimationUtils.loadAnimation(context, R.anim.volunteer_anim_text_switcher_in)
        swc_volunteer_record_year.inAnimation = inAnim
        // 设置ViewSwitcher.ViewFactory
        swc_volunteer_record_year.setFactory(this)
    }

    override fun makeView(): View {
        val textView = TextView(context)
        context ?: return textView
        textView.textSize = requireContext().dp2px(5f).toFloat()
        textView.setTextColor(
            ContextCompat.getColor(
                requireContext(),
                com.mredrock.cyxbs.common.R.color.common_level_three_font_color
            )
        )
        return textView
    }
}