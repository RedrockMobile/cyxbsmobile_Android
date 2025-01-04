package com.cyxbs.pages.declare.post.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.toast
import com.cyxbs.pages.declare.R


/**
 * com.mredrock.cyxbs.declare.pages.post.adapter.PostSectionRvAdapter.kt
 * CyxbsMobile_Android
 *
 * @author 寒雨
 * @since 2023/2/8 下午4:56
 */
class PostSectionRvAdapter(
    private val onItemTouch: (list: MutableList<String>, position: Int, et: EditText) -> Unit,
    private val onItemUpdate: (list: MutableList<String>) -> Unit
) : RecyclerView.Adapter<PostSectionRvAdapter.Holder>() {

    val list: MutableList<String> = mutableListOf(
        "", "", "", ""
    )

    @SuppressLint("ClickableViewAccessibility")
    sealed class Holder(itemView: View) : RecyclerView.ViewHolder(itemView)

    inner class DeclareItemSectionHolder(parent: ViewGroup) : Holder(
        LayoutInflater.from(parent.context).inflate(R.layout.declare_item_section, parent, false)
    ) {
        val sivRm = itemView.findViewById<View>(R.id.siv_rm)
        val et = itemView.findViewById<EditText>(R.id.et)
        init {
            sivRm.setOnClickListener {
                list.removeAt(bindingAdapterPosition)
                notifyItemRemoved(bindingAdapterPosition)
                // 刷新下面所有的item，让选项号保持顺序
                (bindingAdapterPosition..list.size).forEach {
                    notifyItemChanged(it)
                }
                onItemUpdate(list)
            }
            et.isFocusable = false
            et.setOnClickListener {
                onItemTouch(list, bindingAdapterPosition, et)
            }
        }
    }

    inner class DeclareItemAddSectionHolder(parent: ViewGroup) : Holder(
        LayoutInflater.from(parent.context).inflate(R.layout.declare_item_add_section, parent, false)
    ) {
        val sivAdd = itemView.findViewById<View>(R.id.siv_add)
        init {
            sivAdd.setOnClickListener {
                if (list.size == 10) {
                    toast("最多仅可以添加10个选项")
                    return@setOnClickListener
                }
                list.add("")
                notifyItemInserted(list.size - 1)
                onItemUpdate(list)
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): Holder {
        return if (viewType == TYPE_TAIL) {
            DeclareItemAddSectionHolder(parent)
        } else {
            DeclareItemSectionHolder(parent)
        }
    }

    override fun onBindViewHolder(holder: Holder, position: Int) {
        when (getItemViewType(position)) {
            TYPE_NORMAL -> {
                holder as DeclareItemSectionHolder
                val content = list[position]
                if (holder.et.hint != "选项${position + 1}") {
                    holder.itemView.post {
                        holder.et.hint = "选项${position + 1}"
                        holder.et.setText(content)
                    }
                }
            }
        }
    }

    override fun getItemViewType(position: Int): Int {
        // 最后一个
        if (position == itemCount - 1) {
            return TYPE_TAIL
        }
        return TYPE_NORMAL
    }

    // 尾部
    override fun getItemCount(): Int {
        return list.size + 1
    }

    companion object {
        private const val TYPE_NORMAL = 0
        private const val TYPE_TAIL = 1
    }
}