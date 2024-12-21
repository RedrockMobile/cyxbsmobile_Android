package com.cyxbs.pages.electricity.bean

import com.google.gson.annotations.SerializedName
import com.mredrock.cyxbs.lib.utils.network.IApiStatus

data class ElectricityInfo(
  @SerializedName("elec_inf")
  val elecInf: ElecInf,
  @SerializedName("status")
  override val status: Int,
  @SerializedName("info")
  override val info: String
) : IApiStatus