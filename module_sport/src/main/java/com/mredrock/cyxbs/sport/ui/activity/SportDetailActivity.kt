package com.mredrock.cyxbs.sport.ui.activity

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.config.config.SchoolCalendar
import com.mredrock.cyxbs.config.route.DISCOVER_SPORT
import com.mredrock.cyxbs.lib.base.ui.BaseBindActivity
import com.mredrock.cyxbs.lib.utils.extensions.gone
import com.mredrock.cyxbs.lib.utils.extensions.setOnDoubleClickListener
import com.mredrock.cyxbs.lib.utils.extensions.visible
import com.mredrock.cyxbs.sport.R
import com.mredrock.cyxbs.sport.databinding.SportActivitySportDetailBinding
import com.mredrock.cyxbs.sport.model.SportDetailBean
import com.mredrock.cyxbs.sport.ui.adapter.SportRvAdapter
import com.mredrock.cyxbs.sport.model.SportDetailRepository
import java.util.Calendar

/**
 * @author : why
 * @time   : 2022/8/10 18：22
 * @bless  : God bless my code
 * @description : 体育打卡点击进入后的详情页面
 */
@Route(path = DISCOVER_SPORT)
class SportDetailActivity : BaseBindActivity<SportActivitySportDetailBinding>() {
    
    /**
     * RecyclerView的adapter
     */
    private val mSportRvAdapter = SportRvAdapter()

    /**
     * 是否放假中
     */
    private var mIsHoliday = false

    //因为课表提供的周数可能为 null 因此当返回null时设置为22（即放假中）
    private val mWeek: Int = SchoolCalendar.getWeekOfTerm() ?: 22

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //初始化
        init()
        //设置右上角的时间
        setTime()
        //获取ViewModel
        binding.run {
            //设置刷新监听
            if (mIsHoliday) {
                //放假则直接结束刷新
                sportSrlDetailList.setEnableRefresh(false)
            } else {
                sportSrlDetailList.setEnableRefresh(true)
                sportSrlDetailList.setOnRefreshListener {
                    SportDetailRepository.refresh() // 刷新新数据
                }
            }
        }
        //添加数据
        SportDetailRepository.sportData.observe { result ->
            binding.sportSrlDetailList.finishRefresh()
            result.onSuccess {
                loadData(it)
            }.onFailure {
                if (!mIsHoliday) {
                    showError()
                }
            }
        }
    }

    /**
     * 设置RecyclerView的adapter和layoutManager
     *
     * 设置双击返回顶部
     *
     * 初始化时加载数据较慢，显示加载动画让用户知晓正在加载
     */
    private fun init() {
        binding.run {
            //设置RecyclerView
            sportRvDetailList.run {
                adapter = mSportRvAdapter
                layoutManager = LinearLayoutManager(this@SportDetailActivity)
            }
            //设置双击返回顶部
            onDoubleClickScrollToTop()
            //设置返回键
            sportIbDetailBack.setOnClickListener {
                finish()
            }
        }
    }

    /**
     * 设置右上角处的时间: 年份，季节 或是放假中
     */
    @SuppressLint("SetTextI18n")
    private fun setTime() {
        binding.run {
            //设置右上方的时间段
            //年份
            val year: Int = Calendar.getInstance()[Calendar.YEAR]
            //学期的季节
            val season: String = when (Calendar.getInstance()[Calendar.MONTH] + 1) {
                1 -> "秋"
                in 2..7 -> "春"
                in 8..12 -> "秋"
                else -> ""
            }
            if (mWeek in 1..21) {
                //若周数为1到21则认定为未放假
                sportTvDetailTime.text = "${year}年  $season"
            } else {
                //若为其他值则显示放假中,并设置提示图为放假
                mIsHoliday = true
                sportTvDetailTime.text = "放假中"
                sportSrlDetailList.finishRefresh()
                sportRvDetailList.gone()
                sportSivDetailHint.setImageResource(R.drawable.sport_ic_holiday)
                sportSivDetailHint.visible()
                sportTvDetailHint.text = "大家都放假了，好好度假吧！"
                sportTvDetailHint.visible()
            }
        }
    }

    /**
     * 获取到数据后加载到页面顶部以及RecyclerView中
     */
    @SuppressLint("SetTextI18n")
    private fun loadData(bean: SportDetailBean) {
        binding.run {
            sportTvDetailTotalDone.text =
                (bean.runDone + bean.otherDone).toString()                //总的已打次数
            sportTvDetailTotalNeed.text =
                " /${bean.runTotal + bean.otherTotal}"                     //总的需要打卡次数
            sportTvDetailRunDone.text =
                (bean.runDone).toString()                                 //跑步已打卡次数
            sportTvDetailRunNeed.text =
                " /${bean.runTotal}"                                       //跑步需要打卡的次数
            sportTvDetailOtherDone.text =
                (bean.otherDone).toString()                               //其他已打卡次数
            sportTvDetailOtherNeed.text =
                " /${bean.otherTotal}"                                     //其他需要打卡的次数
            sportTvDetailAward.text = bean.award.toString()               //奖励次数
        }
        //未放假则正常加载
        if (mWeek in 1..21) {
            //添加页面顶部总数据
            if ((bean.runDone + bean.otherDone) != 0) {
                //若打卡次数不为0则添加RecyclerView的数据并将提示所用的图片和文字隐藏
                binding.sportTvDetailHint.gone()
                binding.sportSivDetailHint.gone()
                binding.sportRvDetailList.visible()
                //把风雨操场的两项数据进行合并（因为太长了显示不下，经与产品商讨后采用此种方式，ios同步）
                val list = bean.item.map {
                    it.apply {
                        spot = spot.replace("风雨操场（篮球馆）", "风雨操场")
                        spot = spot.replace("风雨操场（乒乓球馆）", "风雨操场")
                    }
                }.reversed()
                mSportRvAdapter.submitList(list)
            } else if ((bean.runDone + bean.otherDone) == 0) {
                //若打卡的次数为0则隐藏RecyclerView并设置没有记录的提示
                binding.run {
                    sportRvDetailList.gone()
                    sportSivDetailHint.setImageResource(R.drawable.sport_ic_no_data)
                    sportSivDetailHint.visible()
                    sportTvDetailHint.text = "暂时还没记录哦~"
                    sportTvDetailHint.visible()
                }
            }
        }
    }

    /**
     * 展示数据加载错误的页面
     */
    @SuppressLint("SetTextI18n")
    private fun showError() {
        binding.run {
            //将右上角时间设置为null
            binding.sportTvDetailTime.text = "null"
            //结束刷新
            sportSrlDetailList.finishRefresh()
            //隐藏RecyclerView并加载出错的图片及提示
            sportRvDetailList.gone()
            sportSivDetailHint.setImageResource(com.mredrock.cyxbs.config.R.drawable.config_ic_404)
            sportSivDetailHint.visible()
            sportTvDetailHint.text = "数据错误"
            sportTvDetailHint.visible()
            //设置顶部数据为null
            sportTvDetailTotalDone.text = "null"                            //总的已打次数
            sportTvDetailTotalNeed.text = ""                                //总的需要打卡次数
            sportTvDetailRunDone.text = "null"                              //跑步已打卡次数
            sportTvDetailRunNeed.text = ""                                  //跑步需要打卡的次数
            sportTvDetailOtherDone.text = "null"                            //其他已打卡次数
            sportTvDetailOtherNeed.text = ""                                //其他需要打卡的次数
            sportTvDetailAward.text = "null"                                //奖励次数
        }
    }

    /**
     * 设置双击顶部板块返回RecyclerView的第一个item
     */
    private fun onDoubleClickScrollToTop() {
        binding.sportClDetailTop.setOnDoubleClickListener {
            binding.sportRvDetailList.smoothScrollToPosition(0)
            binding.sportSrlDetailList.autoRefresh()
        }
    }
}