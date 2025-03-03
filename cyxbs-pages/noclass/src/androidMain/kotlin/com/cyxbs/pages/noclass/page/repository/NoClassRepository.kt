package com.cyxbs.pages.noclass.page.repository

import com.cyxbs.components.utils.network.ApiStatus
import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.pages.noclass.bean.NoClassBatchResponseInfo
import com.cyxbs.pages.noclass.bean.NoClassGroup
import com.cyxbs.pages.noclass.bean.NoClassTemporarySearch
import com.cyxbs.pages.noclass.bean.NoclassGroupId
import com.cyxbs.pages.noclass.bean.Student
import com.cyxbs.pages.noclass.net.NoclassApiService
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Single
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 *
 * @ProjectName:    CyxbsMobile_Android
 * @Package:        com.cyxbs.pages.noclass.page.repository
 * @ClassName:      NoClassRepository
 * @Author:         Yan
 * @CreateDate:     2022年08月29日 03:11:00
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 * @Description:
 */
object NoClassRepository {

    /**
     * 获得全部分组数据
     */
    fun getNoclassGroupDetail() : Single<ApiWrapper<List<NoClassGroup>>>{
        return NoclassApiService
            .INSTANCE
            .getGroupAll()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 上传分组
     */
    fun postNoclassGroup(
        name : String,
        stuNums : String,
    ) : Single<ApiWrapper<NoclassGroupId>> {
        return NoclassApiService
            .INSTANCE
            .postGroup(name,stuNums)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 更新分组
     */
    fun updateGroup(
        groupId: String,
        name: String,
        isTop: String,
    ): Single<ApiStatus>{
        return NoclassApiService
            .INSTANCE
            .updateGroup(groupId, name, isTop)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 删除分组
     */
    fun deleteGroup(
        groupIds : String
    ): Single<ApiStatus> {
        return NoclassApiService
            .INSTANCE
            .deleteGroup(groupIds)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 删除分组中的人
     */
    fun deleteNoclassGroupMember(groupId : String, stuNum : String): Single<ApiStatus> {
        return NoclassApiService
            .INSTANCE
            .deleteGroupMember(groupId,stuNum)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 增加分组中的人
     */
    fun addNoclassGroupMember(groupId: String, stuNum: String): Single<ApiStatus> {
        return NoclassApiService
            .INSTANCE
            .addGroupMember(groupId, stuNum)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }
    
    /**
     * 查询人
     */
    fun searchStudent(stuNum: String) : Single<ApiWrapper<List<Student>>>{
        return NoclassApiService
            .INSTANCE
            .searchPeople(stuNum)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 临时分组页面查询所有
     */
    fun searchAll(content : String) : Single<ApiWrapper<NoClassTemporarySearch>>{
        return NoclassApiService
            .INSTANCE
            .searchAll(content)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

    /**
     * 批量添加页面，检查上传的信息
     */
    fun checkUploadInfo(content: List<String>) :Single<ApiWrapper<NoClassBatchResponseInfo>> {
        return NoclassApiService
            .INSTANCE
            .checkUploadInfo(content)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
    }

}