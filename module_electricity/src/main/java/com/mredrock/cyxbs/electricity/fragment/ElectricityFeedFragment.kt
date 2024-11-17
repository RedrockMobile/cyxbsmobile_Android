package com.mredrock.cyxbs.electricity.fragment

import android.os.Bundle
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.style.AbsoluteSizeSpan
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.fragment.app.viewModels
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.config.route.DISCOVER_ELECTRICITY_FEED
import com.mredrock.cyxbs.config.sp.defaultSp
import com.mredrock.cyxbs.electricity.R
import com.mredrock.cyxbs.electricity.bean.ElecInf
import com.mredrock.cyxbs.electricity.config.*
import com.mredrock.cyxbs.electricity.viewmodel.ChargeViewModel
import com.mredrock.cyxbs.lib.base.operations.doIfLogin
import com.mredrock.cyxbs.lib.base.ui.BaseFragment
import com.mredrock.cyxbs.lib.utils.extensions.dp2px
import com.mredrock.cyxbs.lib.utils.extensions.gone
import com.mredrock.cyxbs.lib.utils.extensions.setOnSingleClickListener
import com.mredrock.cyxbs.lib.utils.extensions.visible
import com.mredrock.cyxbs.lib.utils.service.ServiceManager
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach


@Route(path = DISCOVER_ELECTRICITY_FEED)
class ElectricityFeedFragment : BaseFragment() {

    private val viewModel by viewModels<ChargeViewModel>()

    private val ll_feed by R.id.ll_feed.view<View>()
    private val tv_feed_subtitle by R.id.tv_feed_subtitle.view<TextView>()
    private val csl_electricity_data_feed: ConstraintLayout by R.id.csl_electricity_data_feed.view()
    private val tv_electricity_no_data_feed: TextView by R.id.tv_electricity_no_data_feed.view()
    private val tv_electricity_feed_fee: TextView by R.id.tv_electricity_feed_fee.view()
    private val tv_electricity_feed_kilowatt: TextView by R.id.tv_electricity_feed_kilowatt.view()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.electricity_fragment_base_feed, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        init()
    }

    private fun init() {
        tv_electricity_no_data_feed.setText(R.string.electricity_searching)
        ll_feed.setOnSingleClickListener {
            doIfLogin(getString(R.string.electricity_inquire_string)) {
                parentFragmentManager.let {
                    ElectricityFeedSettingDialogFragment().apply {
                        refresher = { id, room ->
                            viewModel.getCharge(id, room)
                        }
                    }.show(it, "ElectricityFeedSetting")
                }
            }
        }
        viewModel.chargeInfo.observe {
            handleData(it)
        }
        //首次默认加载失败，说明账号有问题
        viewModel.loadFailed.onEach {
            tv_electricity_no_data_feed.text = getString(R.string.electricity_unbind)
        }.launchIn(viewLifecycleScope)
    }

    private fun handleData(it: ElecInf?) {
        if (it == null || it.isEmpty()) {
            tv_feed_subtitle.text = ""
        } else {
            tv_feed_subtitle.text = it.recordTime.plus("抄表")
        }
        update(it)
    }

    override fun onResume() {
        super.onResume()
        onRefresh()
    }

    private fun onRefresh() {
        if (!ServiceManager(IAccountService::class).getVerifyService().isLogin()) {
            return
        }
        if (viewModel.chargeInfo.value != null) {
            handleData(viewModel.chargeInfo.value)
        } else {
            val pos = defaultSp.getInt(SP_BUILDING_HEAD_KEY, -1)

            if (pos == -1) {
                viewModel.preGetCharge()
                return
            }
            val id = BUILDING_NAMES.getValue(BUILDING_NAMES_HEADER[pos])[defaultSp.getInt(
                SP_BUILDING_FOOT_KEY, -1
            )].split("(")[1].split("栋")[0]
            val room = defaultSp.getString(SP_ROOM_KEY, "") ?: ""
            if (id.isEmpty() || room.isEmpty()) {
                viewModel.preGetCharge()
            } else {
                viewModel.getCharge(id, room)
            }
        }
    }

    // 老代码迁移
    private fun update(elecInf: ElecInf?) {
        if (elecInf == null || elecInf.isEmpty()) {
            csl_electricity_data_feed.gone()
            tv_electricity_no_data_feed.visible()
            tv_electricity_no_data_feed.setText(R.string.electricity_no_data)
        } else {
            csl_electricity_data_feed.visible()
            tv_electricity_no_data_feed.gone()
            if (elecInf.getAverage().length > 1) {
                //写出这样的代码，我很抱歉,后端不改～～
                tv_electricity_feed_fee.text =
                    SpannableStringBuilder(elecInf.getEleCost().toDouble().run {
                        if (this < 0) {
                            "0.0"
                        } else {
                            this.toString()
                        }
                    }.plus("元")).apply {
                        setSpan(AbsoluteSizeSpan(36.dp2px), 0, this.length - 1, Spannable.SPAN_INCLUSIVE_INCLUSIVE)
                        setSpan(
                            AbsoluteSizeSpan(13.dp2px),
                            this.length - 1,
                            this.length,
                            Spannable.SPAN_INCLUSIVE_INCLUSIVE
                        )
                    }
            }
            //elecSpend可能为空
            val spend = elecInf.elecSpend
            tv_electricity_feed_kilowatt.text = SpannableStringBuilder(spend.plus("度")).apply {
                setSpan(
                    AbsoluteSizeSpan(36.dp2px),
                    0,
                    this.length - 1,
                    Spannable.SPAN_INCLUSIVE_INCLUSIVE
                )
                setSpan(
                    AbsoluteSizeSpan(13.dp2px),
                    this.length - 1,
                    this.length,
                    Spannable.SPAN_INCLUSIVE_INCLUSIVE
                )
            }
        }
    }
}
