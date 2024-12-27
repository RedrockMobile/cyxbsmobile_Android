package com.cyxbs.pages.notification.ui.fragment

import android.graphics.drawable.Drawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import androidx.appcompat.widget.LinearLayoutCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.gone
import com.cyxbs.components.utils.extensions.visible
import com.cyxbs.pages.notification.R
import com.cyxbs.pages.notification.adapter.ActivityUfieldRVAdapter
import com.cyxbs.pages.notification.bean.UfieldMsgBean
import com.cyxbs.pages.notification.ui.activity.NotificationActivity
import com.cyxbs.pages.notification.viewmodel.NotificationViewModel
import com.mredrock.cyxbs.lib.base.ui.BaseFragment
import kotlin.properties.Delegates

class UfieldNotificationFragment : BaseFragment() {

    private val notification_rv_act by R.id.notification_rv_act.view<RecyclerView>()

    private val notification_ll_no_internet by R.id.notification_ll_no_internet.view<LinearLayoutCompat>()

    //rv适配器
    private lateinit var adapter: ActivityUfieldRVAdapter

    //fragment对应的Activity
    private var myActivity by Delegates.notNull<NotificationActivity>()

    //使用和Activity同一个ViewModel来与activity通信
    private val viewModel: NotificationViewModel by activityViewModels()

    private lateinit var allNotification : MutableList<UfieldMsgBean>
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.notification_fragment_ufield, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        myActivity = requireActivity() as NotificationActivity
        initRV()
        initObserver()
    }



    private fun initRV() {
        adapter = ActivityUfieldRVAdapter(this,viewModel)
        notification_rv_act.adapter = adapter
        //动画效果
        val resId = R.anim.notification_layout_animation_fall_down
        val anim = AnimationUtils.loadLayoutAnimation(myActivity, resId)
        notification_rv_act.layoutAnimation = anim
        notification_rv_act.layoutManager = LinearLayoutManager(this.context)
        //分割线
        val dividerDrawable: Drawable? =
            ContextCompat.getDrawable(requireContext(), R.drawable.notification_ic_divider)
        val dividerItemDecoration =
            DividerItemDecoration(this.context, LinearLayoutManager(this.context).orientation)
        dividerDrawable?.let { dividerItemDecoration.setDrawable(it) }
        notification_rv_act.addItemDecoration(dividerItemDecoration)
    }

    private fun initObserver() {
        viewModel.ufieldActivityMsg.observe(viewLifecycleOwner) {
            if (it.isEmpty()){
                notification_rv_act.gone()
                notification_ll_no_internet.gone()
            }else{
                allNotification=it.reversed() as MutableList<UfieldMsgBean>
                adapter.submitList(allNotification)
            }
        }
        viewModel.getUfieldMsgSuccessful.observe(viewLifecycleOwner) {
            if (it == false) {
                notification_ll_no_internet.visible()
                notification_rv_act.gone()
            } else {
                notification_rv_act.visible()
                notification_ll_no_internet.gone()
            }
        }
    }
}