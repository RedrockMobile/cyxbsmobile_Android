package com.cyxbs.pages.course.page.find.ui.find.fragment

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import androidx.fragment.app.activityViewModels
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.google.android.flexbox.FlexDirection
import com.google.android.flexbox.FlexWrap
import com.google.android.flexbox.FlexboxLayoutManager
import com.google.android.material.snackbar.BaseTransientBottomBar
import com.google.android.material.snackbar.Snackbar
import com.cyxbs.pages.course.R
import com.cyxbs.pages.course.page.find.adapter.RvHistoryAdapter
import com.cyxbs.pages.course.page.find.room.FindPersonEntity
import com.cyxbs.pages.course.page.find.room.FindStuEntity
import com.cyxbs.pages.course.page.find.ui.find.activity.ShowResultActivity
import com.cyxbs.pages.course.page.find.viewmodel.activity.FindLessonViewModel
import com.cyxbs.pages.course.page.find.viewmodel.fragment.FindTeaViewModel
import com.cyxbs.components.base.ui.BaseFragment

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/2/8 17:08
 */
class FindTeaFragment : BaseFragment() {
  
  private val mViewModel by viewModels<FindTeaViewModel>()

  // Activity 的 ViewModel
  private val mActivityViewModel by activityViewModels<FindLessonViewModel>()
  // 历史记录的 Adapter
  private lateinit var mRvAdapter: ListAdapter<FindPersonEntity, RvHistoryAdapter.HistoryVH>
  // 搜索框
  private val mEtSearch by R.id.course_et_find_course_tea.view<EditText>()
  // 历史记录
  private val mRvHistory by R.id.course_rv_find_course_tea.view<RecyclerView>()

  override fun onCreateView(
    inflater: LayoutInflater,
    container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View = inflater.inflate(R.layout.course_fragment_find_tea, container, false)

  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)
    initRecycler()
    initEditText()
    initObserve()
  }

  private fun initRecycler() {
    mRvHistory.layoutManager = FlexboxLayoutManager(requireContext(), FlexDirection.ROW, FlexWrap.WRAP)
    mRvHistory.adapter = RvHistoryAdapter()
      .setOnDeleteClick {
        mViewModel.deleteHistory(num)
      }.setOnTextClick {
        mActivityViewModel.changeCourseState(num, this is FindStuEntity)
      }.apply {
        mRvAdapter = this
      }
  }

  private fun initEditText() {
    mEtSearch.setOnEditorActionListener { tv, _, _ ->
      val text = tv.text
      if (text.isEmpty()) {
        Snackbar.make(requireView(), "输入为空", BaseTransientBottomBar.LENGTH_SHORT).show()
        false
      } else {
        toast("查询中")
        mViewModel.searchTeachers(text.toString())
        // 取消键盘
        (requireActivity().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager)
          .hideSoftInputFromWindow(requireActivity().currentFocus?.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
        true
      }
    }
  }

  private fun initObserve() {
    mViewModel.teacherSearchData.collectLaunch {
      if (it.isNotEmpty()) {
        ShowResultActivity.startActivity(requireContext(), ShowResultActivity.TeaData(it))
      } else {
        toast("查无此人")
      }
    }

    mViewModel.teacherHistory.observe {
      mRvAdapter.submitList(it.reversed())
    }
  
    // 打开界面直接查找时
    mActivityViewModel.findText.observe {
      if (it is FindLessonViewModel.TeaName) {
        mEtSearch.setText(it.text)
        mViewModel.searchTeachers(it.text)
      } else if (it is FindLessonViewModel.TeaNum) {
        mActivityViewModel.changeCourseState(it.text, false)
      }
    }
  }
}