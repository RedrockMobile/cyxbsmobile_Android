package com.mredrock.cyxbs.mine.network.model

import java.io.Serializable

/**
 * Created by zzzia on 2018/8/21.
 * 图片上传，返回地址
 */
class UploadImgResponse : Serializable {
  override fun toString(): String {
    return "UploadImgResponse{" +
        "date='" + date + '\'' +
        ", photosrc='" + photosrc + '\'' +
        ", thumbnail_src='" + thumbnail_src + '\'' +
        ", state=" + state +
        ", stunum='" + stunum + '\'' +
        '}'
  }

  /**
   * date : 2018-08-21 16:05:37
   * photosrc : http://wx.idsbllp.cn/app/Public/photo/1534838737_1029204034.jpg
   * thumbnail_src : http://wx.idsbllp.cn/app/Public/photo/thumbnail/1534838737_1029204034.jpg
   * state : 1
   * stunum : 2016210409
   */
  var date: String? = null
  var photosrc: String? = null
  var thumbnail_src: String? = null
  var state: Int = 0
  var stunum: String? = null
}
