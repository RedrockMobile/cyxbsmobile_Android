package com.cyxbs.pages.course.service

import com.cyxbs.pages.course.api.ILinkService
import com.cyxbs.pages.course.page.link.model.LinkRepository
import com.cyxbs.pages.course.page.link.room.LinkStuEntity
import com.g985892345.provider.api.annotation.ImplProvider
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/3 12:47
 */
@ImplProvider
object LinkServiceImpl : ILinkService {
  
  override fun getLinkStu(): Single<ILinkService.LinkStu> {
    return LinkRepository.getLinkStudent()
      .map { it.toLinkStu() }
  }
  
  override fun observeSelfLinkStu(): Observable<ILinkService.LinkStu> {
    return LinkRepository.observeLinkStudent()
      .map { it.toLinkStu() }
  }

  private fun LinkStuEntity.toLinkStu(): ILinkService.LinkStu {
    return ILinkService.LinkStu(selfNum, linkNum, linkMajor, linkName, isShowLink, isBoy)
  }
}