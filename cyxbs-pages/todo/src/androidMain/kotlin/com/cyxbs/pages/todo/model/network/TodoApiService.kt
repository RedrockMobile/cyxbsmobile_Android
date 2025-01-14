package com.cyxbs.pages.todo.model.network

import com.cyxbs.pages.todo.model.bean.DelPushWrapper
import com.cyxbs.pages.todo.model.bean.SyncTime
import com.cyxbs.pages.todo.model.bean.TodoListGetWrapper
import com.cyxbs.pages.todo.model.bean.TodoListPushWrapper
import com.cyxbs.pages.todo.model.bean.TodoListSyncTimeWrapper
import com.cyxbs.pages.todo.model.bean.TodoPinData
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.ApiWrapper
import io.reactivex.rxjava3.core.Single
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.HTTP
import retrofit2.http.POST
import retrofit2.http.Query

/**
 * description:
 * author: sanhuzhen
 * date: 2024/8/17 11:05
 */
interface TodoApiService {
    companion object {
        val INSTANCE by lazy { ApiGenerator.getApiService(TodoApiService::class) }
    }

    /**
     * 从数据库获取全部todo
     */
    @GET("/magipoke-todo/list")
    fun queryAllTodo():
            Single<ApiWrapper<TodoListSyncTimeWrapper>>

    /**
     * 获取自上次同步到现在之间修改的所有todo
     */
    @GET("/magipoke-todo/todos")
    fun queryChangedTodo(
        @Query("sync_time")
        syncTime: Long
    ): Single<ApiWrapper<TodoListGetWrapper>>

    /**
     * 上传todo到数据库
     */
    @POST("/magipoke-todo/batch-create")
    fun pushTodo(@Body pushWrapper: TodoListPushWrapper):
            Single<ApiWrapper<SyncTime>>

    /**
     * 获取最后修改的时间戳
     */
    @GET("/magipoke-todo/sync-time")
    fun getLastSyncTime(
        @Query("sync_time")
        syncTime: Long
    ): Single<ApiWrapper<SyncTime>>

    /**
     * 删除todo
     */
    @HTTP(method = "DELETE", path = "/magipoke-todo/todos", hasBody = true)
    fun delTodo(
        @Body delPushWrapper: DelPushWrapper
    ): Single<ApiWrapper<SyncTime>>

    /**
     * 置顶
     */
    @POST("/magipoke-todo/pin")
    fun pinTodo(
        @Body todoPinData: TodoPinData
    ): Single<ApiWrapper<SyncTime>>

}