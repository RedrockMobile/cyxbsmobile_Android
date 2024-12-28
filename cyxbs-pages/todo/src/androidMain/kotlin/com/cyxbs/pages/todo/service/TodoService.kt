package com.cyxbs.pages.todo.service

import androidx.fragment.app.Fragment
import com.cyxbs.pages.todo.api.ITodoService
import com.cyxbs.pages.todo.ui.fragment.TodoFeedFragment
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * Author: RayleighZ
 * Time: 2021-08-09 15:58
 * Describe: 提供Feed的类
 */
@ImplProvider
object TodoService : ITodoService {
    override fun getTodoFeed(): Fragment = TodoFeedFragment()
}