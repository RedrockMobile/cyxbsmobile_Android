package com.cyxbs.pages.mine.base.presenter

import androidx.lifecycle.*
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel

/**
 *@author ZhiQiang Tu
 *@time 2021/8/7  11:51
 *@signature 我们不明前路，却已在路上
 */

/**
 *  Presenter的基类，内部自动获取了ViewModel的实例
 */
abstract class BasePresenter<VM : BaseViewModel> : DefaultLifecycleObserver,IPresenter<VM>{
    protected var vm: VM? = null

    /*protected var view: WeakReference<V>? = null
    fun onAttachView(view: IView) {
        this.view = WeakReference(view as V)
    }
    fun detachView() {
        this.view?.clear()
    }*/


    /**
     *  在Activity或者Fragment创建的时候传入
     *
     * @see com.mredrock.cyxbs.common.ui.BaseMVPVMFragment
     * @see com.mredrock.cyxbs.common.ui.BaseMVPVMActivity
     */
    override fun onAttachVM(vm: BaseViewModel) {
        this.vm = vm as VM
    }

    /**
     *  在Activity或者Fragment销毁的时候销毁
     *
     * @see com.mredrock.cyxbs.common.ui.BaseMVPVMFragment
     * @see com.mredrock.cyxbs.common.ui.BaseMVPVMActivity
     */
    override fun onDetachVM(){
        vm = null
    }

    /**
     *  1.在Activity被Destroy掉的时候调用
     *  2.改方法是用以清楚Presenter中一些可能会存在内存泄漏的变量
     */
    open fun clear(){}
}