package com.cyxbs.pages.mine.util.ui

import android.content.Context
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.network.model.SecurityQuestion
import com.cyxbs.pages.mine.page.security.adapter.SelQuestionRVAdapter
import com.google.android.material.bottomsheet.BottomSheetDialog

/**
 * Author: RayleighZ
 * Time: 2020-10-29 15:06
 * describe: 设置密保问题时选择问题用的sheetDialog
 */
class SelQuestionDialog(
    context: Context,
    val listOfSecurityQuestion: List<SecurityQuestion>,
    val onClick: (Int) -> Unit
) : BottomSheetDialog(context, com.cyxbs.components.config.R.style.ConfigBottomSheetDialogTheme) {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mine_fragment_security_choose_question)
        val questionRV = findViewById<RecyclerView>(R.id.mine_rv_security_choose_question)!!
        val adapter = SelQuestionRVAdapter(listOfSecurityQuestion) {
            onClick(it)
            this.hide()
        }
        questionRV.adapter = adapter
        questionRV.layoutManager = LinearLayoutManager(context)
    }
}