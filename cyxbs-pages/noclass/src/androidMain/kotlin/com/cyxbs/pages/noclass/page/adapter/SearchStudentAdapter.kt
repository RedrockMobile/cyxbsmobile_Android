package com.cyxbs.pages.noclass.page.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.noclass.R
import com.cyxbs.pages.noclass.bean.Student

/**
 *
 * @ProjectName:    CyxbsMobile_Android
 * @Package:        com.cyxbs.pages.noclass.page.adapter
 * @ClassName:      SearchStudentAdapter
 * @Author:         Yan
 * @CreateDate:     2022年09月02日 03:02:00
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 * @Description:    查找学生RV的adapter
 */
class SearchStudentAdapter : ListAdapter<Student,SearchStudentAdapter.VH>(studentDiffUtil){
 
  companion object{
    private val studentDiffUtil : DiffUtil.ItemCallback<Student> = object : DiffUtil.ItemCallback<Student>(){
      
      override fun areItemsTheSame(oldItem: Student, newItem: Student): Boolean {
        return oldItem.id == newItem.id
      }
  
      override fun areContentsTheSame(oldItem: Student, newItem: Student): Boolean {
        return oldItem == newItem
      }
  
    }
  }

  private var onAddClick : ((Student) -> Unit)? = null
  fun setOnAddClick( onAddClick : (Student) -> Unit){
    this.onAddClick = onAddClick
  }
  inner class VH(itemView : View) : RecyclerView.ViewHolder(itemView){
    val tvName: TextView = itemView.findViewById(R.id.noclass_tv_student_name)
    val tvNum: TextView = itemView.findViewById(R.id.noclass_tv_student_id)
    val tvMajor: TextView = itemView.findViewById(R.id.noclass_tv_student_major)
    init {
      itemView.findViewById<ImageView>(R.id.noclass_iv_student_add).apply {
        setOnClickListener {
          val student = getItem(bindingAdapterPosition)
          onAddClick?.invoke(student)
        }
      }
    }
  }
  
  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VH {
    val view = LayoutInflater.from(parent.context).inflate(R.layout.noclass_item_search_student,parent,false)
    return VH(view)
  }
  
  override fun onBindViewHolder(holder: VH, position: Int) {
    val item = currentList[position]
    with(holder){
      tvName.text = item.name
      tvNum.text = item.id
      tvMajor.text = setAdapterString( item.major,17)
    }
  }

  fun deleteStudent(student: Student){
    val stuList = currentList.toMutableList()
    stuList.remove(student)
    submitList(stuList)
  }

  /**
   * 设置合适长度的String，当超过对应的长度之后就会在最后加...
   */
  private fun setAdapterString(str : String?, maxLength : Int) : String?{
    if (str == null) return null
    return if (str.length < maxLength){
      str
    }else{
      "${str.substring(0,maxLength)}..."
    }
  }
}