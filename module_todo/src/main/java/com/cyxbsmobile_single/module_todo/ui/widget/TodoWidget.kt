package com.cyxbsmobile_single.module_todo.ui.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import com.alibaba.android.arouter.launcher.ARouter
import com.cyxbsmobile_single.module_todo.R
import com.cyxbsmobile_single.module_todo.model.TodoModel
import com.cyxbsmobile_single.module_todo.model.bean.Todo
import com.cyxbsmobile_single.module_todo.service.TodoWidgetService
import com.cyxbsmobile_single.module_todo.ui.activity.TodoDetailActivity
import com.cyxbsmobile_single.module_todo.ui.activity.TodoInnerMainActivity
import com.google.gson.Gson
import com.mredrock.cyxbs.common.BaseApp
import com.mredrock.cyxbs.common.config.TODO_ADD_TODO_BY_WIDGET
import com.mredrock.cyxbs.common.utils.LogUtils
import com.mredrock.cyxbs.common.utils.extensions.defaultSharedPreferences


/**
 * Author: RayleighZ
 * Time: 2021-07-31 19:49
 */
class TodoWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context?,
        appWidgetManager: AppWidgetManager?,
        appWidgetIds: IntArray?
    ) {
        super.onUpdate(context, appWidgetManager, appWidgetIds)
        context?.let {
            val remoteView = initRemoteView(it)
            appWidgetManager?.updateAppWidget(appWidgetIds, remoteView)
        }
    }

    private fun initRemoteView(context: Context): RemoteViews {
        val remoteView = RemoteViews(context.packageName, R.layout.todo_widget_main)
        val intent = Intent(context, TodoWidgetService::class.java)
        remoteView.apply {
            setRemoteAdapter(R.id.todo_lv_widget_todo_list, intent)
        }
        remoteView.setOnClickPendingIntent(
            R.id.todo_iv_widget_add_todo,
            PendingIntent.getBroadcast(
                context,
                1,
                Intent(context, TodoWidget::class.java).apply {
                    action = "cyxbs.widget.todo.add"
                },
                PendingIntent.FLAG_UPDATE_CURRENT
            )
        )
        remoteView.setPendingIntentTemplate(R.id.todo_lv_widget_todo_list, PendingIntent.getBroadcast(
            context,
            0,
            Intent(context, TodoWidget::class.java),
            PendingIntent.FLAG_UPDATE_CURRENT
        ))
        return remoteView
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        super.onReceive(context, intent)
        intent?.action?.let { LogUtils.d("RayleighZ", it) }
        when (intent?.action) {
            "cyxbs.widget.todo.refresh" -> {
                context?.let {
                    refresh(it)
                }
            }

            "cyxbs.widget.todo.add" -> {
                ARouter.getInstance().build(TODO_ADD_TODO_BY_WIDGET).navigation()
            }

            "cyxbs.widget.todo.check" -> {
                val todo = Gson().fromJson(intent.getStringExtra("todo"),Todo::class.java)
                todo.isChecked = true
                TodoModel.INSTANCE.updateTodo(todo){
                    //刷新一波
                    context?.let {
                        refresh(it)
                    }
                }
            }

            "cyxbs.widget.todo.jump" -> {
                val todo = Gson().fromJson(intent.getStringExtra("todo"),Todo::class.java)
                context?.let {
                    TodoDetailActivity.startActivity(todo, it)
                }
            }
        }
    }

    private fun refresh(context: Context){
        val manager = AppWidgetManager.getInstance(context)
        val componentName = ComponentName(context, TodoWidget::class.java)
        val remoteView = initRemoteView(context)
        manager.updateAppWidget(componentName, remoteView)
        manager.notifyAppWidgetViewDataChanged(
            manager.getAppWidgetIds(componentName),
            R.id.todo_lv_widget_todo_list
        )
    }
}