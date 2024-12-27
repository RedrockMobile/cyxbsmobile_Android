package com.cyxbs.pages.course.service

import android.content.Context
import com.alibaba.android.arouter.facade.annotation.Route
import com.cyxbs.pages.course.api.COURSE_LINK
import com.cyxbs.pages.course.api.ILinkService
import com.cyxbs.pages.course.page.link.model.LinkRepository
import com.cyxbs.pages.course.page.link.room.LinkStuEntity
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/3 12:47
 */
@Route(path = com.cyxbs.pages.course.api.COURSE_LINK)
class LinkServiceImpl : com.cyxbs.pages.course.api.ILinkService {
  
  override fun getLinkStu(): Single<com.cyxbs.pages.course.api.ILinkService.LinkStu> {
    return LinkRepository.getLinkStudent()
      .map { it.toLinkStu() }
  }
  
  override fun observeSelfLinkStu(): Observable<com.cyxbs.pages.course.api.ILinkService.LinkStu> {
    return LinkRepository.observeLinkStudent()
      .map { it.toLinkStu() }
  }
  
  override fun init(context: Context) {
  }
  
  private fun LinkStuEntity.toLinkStu(): com.cyxbs.pages.course.api.ILinkService.LinkStu {
    return com.cyxbs.pages.course.api.ILinkService.LinkStu(selfNum, linkNum, linkMajor, linkName, isShowLink, isBoy)
  }
}