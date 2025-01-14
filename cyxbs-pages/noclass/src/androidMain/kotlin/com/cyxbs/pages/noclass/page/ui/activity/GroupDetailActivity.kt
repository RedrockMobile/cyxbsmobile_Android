package com.cyxbs.pages.noclass.page.ui.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.TextUtils
import android.view.WindowManager
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.Button
import android.widget.EditText
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.TextView
import androidx.activity.OnBackPressedCallback
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.visible
import com.cyxbs.pages.noclass.R
import com.cyxbs.pages.noclass.bean.NoClassSpareTime
import com.cyxbs.pages.noclass.bean.NoClassGroup
import com.cyxbs.pages.noclass.bean.Student
import com.cyxbs.pages.noclass.page.adapter.NoClassTemporaryAdapter
import com.cyxbs.pages.noclass.page.ui.dialog.SearchAllDialog
import com.cyxbs.pages.noclass.page.ui.dialog.SearchNoExistDialog
import com.cyxbs.pages.noclass.page.ui.fragment.NoClassCourseVpFragment
import com.cyxbs.pages.noclass.page.viewmodel.other.CourseViewModel
import com.cyxbs.pages.noclass.page.viewmodel.activity.GroupDetailViewModel
import com.cyxbs.pages.noclass.util.alphaAnim

/**
 *
 * @ProjectName:    CyxbsMobile_Android
 * @Package:        com.cyxbs.pages.noclass.page.ui
 * @ClassName:      GroupDetailActivity
 * @Author:         Yan
 * @CreateDate:     2022年08月25日 04:34:00
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 * @Description:    具体分组页面
 */
class GroupDetailActivity : BaseActivity(){
    
    private val mViewModel by viewModels<GroupDetailViewModel>()

    /**
     * 课表专属viewModel
     */
    private val mCourseViewModel by viewModels<CourseViewModel>()

    /**
     * 上方添加同学的编辑框
     */
    private val mEditTextView : EditText by R.id.et_noclass_group_add_classmate.view()

    /**
     * 标题文字
     */
    private val mTitleText : TextView by R.id.tv_noclass_detail_title.view()

    /**
     * RV
     */
    private val mRecyclerView : RecyclerView by R.id.rv_noclass_group_detail_container.view()

    /**
     * 按钮
     */
    private val mBtnQuery : Button by R.id.btn_noclass_group_detail_query.view()

    /**
     * 底部承载课表的container
     */
    private val mCourseContainer : FrameLayout by R.id.noclass_group_detail_bottom_sheet_course_container.view()

    /**
     * 课表上弹和下滑的行为
     */
    private lateinit var mCourseBehavior : BottomSheetBehavior<FrameLayout>

    /**
     * 当前选择的NoclassGroup
     */
    private lateinit var mCurrentNoclassGroup : NoClassGroup
    
    /**
     * Adapter
     */
    private val mAdapter : NoClassTemporaryAdapter by lazy { NoClassTemporaryAdapter() }

    /**
     * 删除缓冲区
     */
    private val mWaitDeleteList : ArrayList<Student> by lazy { ArrayList() }

    /**
     * 取消状态栏
     */
    override val enableEdgeToEdge: Boolean
        get() = true

    /**
     * 下面得提示文字，试试左滑删除列表
     */
    private val mHintText : TextView by R.id.noclass_group_detail_tv_hint.view()

    /**
     * 设置两秒后消失得runnable和handler，注意及时释放
     */
    private var mRunnable : Runnable? = null
    private var mHandler : Handler? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.noclass_activity_group_detail)
        initBack()
        getList()
        initObserve()
        initRv()
        initTextView()
        initEditText()
        initCourseContainer()
        initQuery()
        initHintText("试试左滑删除列表")
    }

    /**
     * 由于onBackPress已经废弃，所以改用OnBackPressedDispatcher
     *
     */
    private fun initBack() {
        val backCallBack = object : OnBackPressedCallback(true){
            override fun handleOnBackPressed() {
                if (mCourseBehavior.state == BottomSheetBehavior.STATE_EXPANDED) {
                    mCourseBehavior.state = BottomSheetBehavior.STATE_HIDDEN
                } else {
                    setResult(RESULT_OK, Intent().apply {
                        val noClassGroup = NoClassGroup(mCurrentNoclassGroup.id,mCurrentNoclassGroup.isTop,mAdapter.currentList,mCurrentNoclassGroup.name)
                        putExtra("GroupDetailResult",noClassGroup)
                    })
                    finish()
                }
            }

        }
        onBackPressedDispatcher.addCallback(this, backCallBack)
    }

    /**
     * 初始化课表的容器
     */
    private fun initCourseContainer() {
        mCourseBehavior = BottomSheetBehavior.from(mCourseContainer)
        //先将课表替换为空课表
        replaceFragment(R.id.noclass_group_detail_bottom_sheet_course_container) {
            NoClassCourseVpFragment.newInstance(NoClassSpareTime.EMPTY_PAGE)
        }
        mCourseBehavior.state = BottomSheetBehavior.STATE_HIDDEN
    }

    /**
     * 接受外部传来的数据
     */
    private fun getList(){
        mCurrentNoclassGroup = intent.getSerializableExtra("NoClassGroup") as NoClassGroup
        mTitleText.text = mCurrentNoclassGroup.name
    }
    
    /**
     * 初始化观测livedata
     */
    private fun initObserve(){
        //观察搜索结果出来就弹窗
        var searchAllDialog: SearchAllDialog?
        mViewModel.searchAll.observe(this){
            if (it != null){
                if (it.isSuccess()){
                    //搜索只要成功就清空搜索框框
                    mEditTextView.setText("")
                    if (it.data.types != null) {
                        if (supportFragmentManager.findFragmentByTag("SearchAllDialog") == null){
                            searchAllDialog = SearchAllDialog.newInstance(
                                searchResult = it.data,
                                groupId = mCurrentNoclassGroup.id
                            ).apply {
                                setOnClickGroupDetailAdd { students ->
                                    val stuList = mAdapter.currentList.toMutableSet()
                                    stuList.addAll(students)
                                    mAdapter.submitList(stuList.toList())
                                }
                            }
                            searchAllDialog!!.show(supportFragmentManager, "SearchAllDialog")
                        }
                    } else {
                        SearchNoExistDialog(this).show()
                    }
                }else{
                    initHintText("网络异常请检查网络")
                }
            }
        }
        // 监听删除是否成功决定本地是否删除
        mViewModel.deleteMembers.observe(this){
            // 如果删除成功
            if (it.second){
                for (stu in mWaitDeleteList){
                    // 如果待删除学生的id和要删除的学生的id一致,就真的删除，并且移除缓冲区中的元素
                    if (stu.id == it.first){
                        mAdapter.deleteMember(stu)
                        mWaitDeleteList.remove(stu)
                    }
                }
            }else{
                toast("删除失败")
            }
        }
        // 观察noClassData，如果有变化就展开
        mCourseViewModel.noclassData.observe(this){
            mCourseBehavior.state = BottomSheetBehavior.STATE_EXPANDED
        }
    }

    /**
     * 初始化下面试试左滑删除列表，设置两秒后消失
     */
    private fun initHintText(content : String? = null) {
        mHintText.alpha = 1f
        mHintText.visible()
        content?.let { mHintText.text = it }
        mHandler = Handler(Looper.getMainLooper())
        mRunnable = Runnable {
            mHintText.alphaAnim(mHintText.alpha,0f,200).start()
        }
        mHandler!!.postDelayed(mRunnable!!,2000)
    }
    
    /**
     * 初始化RV
     */
    private fun initRv(){
        with(mRecyclerView){
            val lm = LinearLayoutManager(this@GroupDetailActivity)
            layoutManager = lm
            adapter = mAdapter.apply {
                //设置删除功能
                setOnItemDelete {
                    mWaitDeleteList.add(it)
                    mViewModel.deleteMembers(mCurrentNoclassGroup.id,it)
                }
                //设置将上一个展开的item关闭的操作
                setOnItemSlideBack {curPosition ->
                    val list = currentList.toMutableList()
                    rightSlideOpenLoc?.let { lastPosition ->
                        list[curPosition].isOpen = true
                        list[lastPosition].isOpen = false
                        submitList(list)
                        notifyItemChanged(lastPosition)
                    }
                }
            }
            addOnScrollListener(object : RecyclerView.OnScrollListener(){
                override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
                    // 正在拖动
                    if (newState == RecyclerView.SCROLL_STATE_DRAGGING){
                        with(mAdapter){
                            rightSlideOpenLoc?.let {
                                val list = currentList.toMutableList()
                                list[it].isOpen = false
                                submitList(list)
                                notifyItemChanged(it)
                                rightSlideOpenLoc = null
                            }
                        }
                    }
                }
            })
        }
        // 将跳转过来的数据填充进去
        mAdapter.submitList(mCurrentNoclassGroup.members)
    }

    /**
     * 完成上方标题点击初始化
     */
    private fun initTextView(){
        // 点击回退到主界面
        findViewById<ImageView>(R.id.iv_noclass_group_detail_return).apply {
            setOnClickListener {
                finish()
            }
        }
    }

    /**
     * 这个是查询课表按钮
     */
    private fun initQuery(){
        mBtnQuery.setOnClickListener {
            mCourseViewModel.getLessons(mAdapter.currentList.map { it.id },mAdapter.currentList)
        }
    }

    /**
     * 上方编辑框的初始化
     */
    private fun initEditText(){
        //防止软键盘弹起导致视图错位
        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_NOTHING)
        //设置键盘上点击搜索的监听
        mEditTextView.setOnEditorActionListener{ _, actionId, _ ->
            if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                doSearch()
                return@setOnEditorActionListener true
            }
            return@setOnEditorActionListener false
        }
    }
    
    /**
     * 执行搜索操作
     */
    private fun doSearch(){
        val content = mEditTextView.text.toString().trim()
        if (TextUtils.isEmpty(content)) {
            toast("输入为空")
            return
        }
        (getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager).hideSoftInputFromWindow(currentFocus?.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
        mEditTextView.setText("")
        mViewModel.getSearchAllResult(content)
    }

    override fun onDestroy() {
        super.onDestroy()
        mRunnable?.let { mHandler?.removeCallbacks(it) }
    }
}