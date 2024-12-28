package com.cyxbs.components.account.api

import io.reactivex.rxjava3.core.Observable

interface IUserService {

    fun getUsername(): String

    fun getStuNum(): String

    fun getGender(): String

    fun getAvatarImgUrl(): String

    fun getCollege(): String

    //用于刷新个人信息，请在需要的地方调用
    fun refreshInfo()
    
    
    /**
     * 观察学号的改变（状态）
     *
     * 有数据倒灌的 Observable，每次订阅会发送之前的最新值
     *
     * ## 注意
     * ### 1、Activity 和 Fragment 中使用一般需要切换线程
     * ```
     * observeOn(AndroidSchedulers.mainThread())
     * ```
     *
     * ### 2、生命周期问题
     * 新模块中 BaseActivity 已自带了 safeSubscribeBy() 方法用于关联生命周期
     *
     * 旧模块中推荐转换为 Flow 然后配合生命周期
     * ```
     * // 使用例子如下
     * IAccountService::class.impl
     *     .getUserService()
     *     .observeStuNumEvent()
     *     .asFlow() // asFlow() 将 Observable 装换为 Flow
     *     .onEach {
     *         // ...
     *     }.launchIn(lifecycleScope)
     * ```
     *
     * ## 其他问题
     * ### 1、为什么使用 Rxjava，不使用 Flow ?
     * Flow 目前还有很多 api 处于测试阶段，不如 Rxjava 稳定
     *
     * ### 2、单一流装换为多流
     * 如果你想对于不同学号返回给下游不同的 Observable，**需要使用 [Observable.switchMap]**，因为它可以自动停止上一个发送的 Observable
     * ```
     * 写法如下：
     * observeStuNumState()
     *   .observeOn(Schedulers.io()) // 注意：你需要使用 observeOn 才能切换线程，subscribeOn 无法切换发送源的线程
     *   .switchMap { value ->
     *     // switchMap 可以在上游发送新的数据时自动关闭上一次数据生成的 Observable
     *     if (it.isEmpty()) Observable.just(emptyList()) else {
     *       LessonDataBase.INSTANCE.getStuLessonDao()              // 数据库
     *         .observeAllLesson(stuNum)                            // 观察数据库的数据变动，这是 Room 的响应式编程
     *         .distinctUntilChanged()                              // 必加，因为 Room 每次修改都会回调，所以需要加这个去重
     *         .doOnSubscribe {
     *           getLesson(stuNum, isNeedOldList).safeSubscribeBy()
     *         }.map { StuResult(stuNum, it) }
     *         .subscribeOn(Schedulers.io())
     *     }
     *   }
     * ```
     *
     * - 更多注意事项请看 [observeStuNumEvent]
     */
    fun observeStuNumState(): Observable<String>
    
    /**
     * 观察学号的改变（事件）
     *
     * 没有数据倒灌的 Observable，即每次订阅不会发送之前的最新值
     *
     * ## 更多注意事项请看 [observeStuNumState]
     */
    fun observeStuNumEvent(): Observable<String>
}