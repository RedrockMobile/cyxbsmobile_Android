//
//  ToDoDetailVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/24.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

// todo详情
class ToDoDetailVC: UIViewController {
    
    var stringMap = [String: Int]()
    
    // MARK: - Properties
    
    private var model = TodoDataModel()
    
    // MARK: - Life Cycle
    
    init(model: TodoDataModel) {
        super.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        
        detailView.nameTextField.text = model.titleStr
        setTimetext(modelStr: model.timeStr)
        setRepeatContent(model: model)
        setTypeTitle(modelStr: model.type as String)
        detailView.noteTextView.text = model.detailStr
        detailView.placeHolderLab.isHidden = model.detailStr.isEmpty ? false : true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        detailView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    // MARK: - Method
    
    // 设置截止时间
    private func setTimetext(modelStr: String) {
        if modelStr.isEmpty {
            detailView.timeLab.text = "设置截止时间"
            detailView.timeForkBtn.removeFromSuperview()
        } else {
            detailView.addSubview(detailView.timeForkBtn)
        }
        let removeYearStr = modelStr.replacingOccurrences(of: "\\d{4}年", with: "", options: .regularExpression, range: nil)
        let components = removeYearStr.split(separator: "日")
        if components.count > 1 {
            let string = String(components[0] + "日  " + components[1])
            let attributedStr = NSMutableAttributedString(string: string)
            let attributes: [NSAttributedString.Key : Any] = [
                .kern: 2
            ]
            attributedStr.addAttributes(attributes, range: NSRange(location: 0, length: attributedStr.length))
            detailView.timeLab.attributedText = attributedStr
            detailView.timeLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        }
    }
    
    // 设置重复
    private func setRepeatContent(model: TodoDataModel) {
        stringMap.removeAll()
        for subView in detailView.repeatScrollView.subviews {
            subView.removeFromSuperview()
        }
        detailView.selectRepeatView.repeatMode = model.repeatMode
        
        var dateAry: [String] = []
        
        switch model.repeatMode {
        case .day:
            detailView.repeatScrollView.addSubview(detailView.createRepeatCell(dateStr: "每天", leftPos: 0, width: 64))
        case .week:
            var startLeft = 0.0
            let weekAry = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
            for week in model.weekArr {
                let weekNum = (Int(week) ?? 1) // [1, 7]
                let weekStr = weekAry[weekNum - 1] // [0, 6]
                stringMap[weekStr] = weekNum
                
                detailView.repeatScrollView.addSubview(detailView.createRepeatCell(dateStr: weekStr, leftPos: startLeft, width: 64))
                startLeft = startLeft + 64 + 18
            }
            detailView.repeatScrollView.contentSize = CGSize(width: startLeft, height: detailView.repeatScrollView.height)
            
            dateAry = model.weekArr
        case .month:
            var startLeft = 0.0
            for monthStr in model.dayArr {
                let monthNum = Int(monthStr) ?? 0
                let str = monthStr + "日"
                stringMap[str] = monthNum
                
                detailView.repeatScrollView.addSubview(detailView.createRepeatCell(dateStr: str, leftPos: startLeft, width: 64))
                startLeft = startLeft + 64 + 18
            }
            detailView.repeatScrollView.contentSize = CGSize(width: startLeft, height: detailView.repeatScrollView.height)
            
            dateAry = model.dayArr
        default:
            detailView.repeatScrollView.addSubview(detailView.createNotRepeateCell())
        }
        
        // refresh ui
        detailView.selectRepeatView.refreshUI(repeatMode: model.repeatMode, dateArr: dateAry)
    }
    
    // 设置类型
    private func setTypeTitle(modelStr: String) {
        let string: String
        if modelStr == "study" {
            string = "学习"
        } else if modelStr == "life" {
            string = "生活"
        } else {
            string = "其他"
        }
        detailView.groupBtn.setTitle(string, for: .normal)
    }
    
    // 展示提示语
    private func showTipsView(frame: CGRect) {
        let tipsView = UIView(frame: frame)
        tipsView.layer.cornerRadius = 17
        tipsView.clipsToBounds = true
        tipsView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#2D4D80", alpha: 1), dark: UIColor(hexString: "#DFDFE3", alpha: 1))
        
        let tipsLab = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        tipsLab.font = .systemFont(ofSize: 13)
        tipsLab.text = "已超100字，无法再输入"
        tipsLab.textColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        tipsLab.textAlignment = .center
        
        tipsView.addSubview(tipsLab)
        view.addSubview(tipsView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            tipsView.removeFromSuperview()
        }
    }
    
    // MARK: - Lazy
    
    /// 待办详情页
    private lazy var detailView: ToDoDetailView = {
        let detailView = ToDoDetailView()
        detailView.delegate = self
        detailView.noteTextView.delegate = self
        detailView.selectDateView.delegate = self
        detailView.selectRepeatView.delegate = self
        detailView.selectTypeView.delegate = self
        return detailView
    }()
    /// 用来容纳详情页的scrollview
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
}

// MARK: - ToDoDetailViewDelegate

extension ToDoDetailVC: ToDoDetailViewDelegate {
    
    func returnToPrevious() {
        if detailView.saveBtn.isUserInteractionEnabled {
            let alertController = XBSAlertController(title: "确定是否返回", message: "返回后修改内容不保存") {
                self.navigationController?.popViewController(animated: true)
            } cancelAction: {
                print("ToDo详情页取消返回")
            }
            self.present(alertController, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func saveTheChanges() {
        model.overdueTime = 0
        model.titleStr = detailView.nameTextField.text ?? ""
        model.detailStr = detailView.noteTextView.text
        model.resetOverdueTime(NSDate.nowTimestamp())
        model.lastModifyTime = Int(Date().timeIntervalSince1970)
        TodoSyncTool.share().alterTodo(with: model, needRecord: true)
        navigationController?.popViewController(animated: true)
    }
    
    func deleteTime() {
        model.timeStr = ""
        detailView.timeLab.text = "设置截止时间"
        detailView.timeForkBtn.removeFromSuperview()
    }
    
    func deleteRepeat(str: String) {
                
        switch model.repeatMode {
        case .day :
            model.repeatMode = .NO
        case .week:
            guard let num = stringMap[str] else { return }
            if let index = model.weekArr.firstIndex(of: "\(num)") {
                model.weekArr.remove(at: index)
            }
            if model.weekArr.isEmpty {
                model.repeatMode = .NO
            }
        case .month:
            guard let num = stringMap[str] else { return }
            if let index = model.dayArr.firstIndex(of: "\(num)") {
                model.dayArr.remove(at: index)
            }
            if model.dayArr.isEmpty {
                model.repeatMode = .NO
            }
        default:
            break
        }
        
        setRepeatContent(model: model)
    }
}

// MARK: - UITextFieldDelegate

extension ToDoDetailVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        detailView.placeHolderLab.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        detailView.saveBtn.isUserInteractionEnabled = true
        detailView.saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
        if textView.text.isEmpty {
            detailView.placeHolderLab.isHidden = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 100 {
            showTipsView(frame: CGRect(x: (view.width - 197) / 2, y: view.height - 430 - 36, width: 197, height: 36))
            textView.text = String(textView.text.prefix(100))
        }
    }
}

// MARK: - DiscoverTodoSelectDateViewDelegate

extension ToDoDetailVC: DiscoverTodoSelectDateViewDelegate {
    
    func selectTimeViewSureBtnClicked(date: Date) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "M月d日HH:mm"
        let timeLabText = dateFormatter1.string(from: date)
        setTimetext(modelStr: timeLabText)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy年M月d日HH:mm"
        let timeStr = dateFormatter2.string(from: date)
        model.timeStr = timeStr
        
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
    
    func selectTimeViewCancelBtnClicked() {
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
}

// MARK: - DiscoverTodoSelectRepeatViewDelegate

extension ToDoDetailVC: DiscoverTodoSelectRepeatViewDelegate {
    
    func selectRepeatViewSureBtnClicked(_ view: DiscoverTodoSelectRepeatView) {
        model.repeatMode = view.repeatMode
        switch view.repeatMode {
        case .week:
            model.weekArr = view.dateArr
        case .month:
            model.dayArr = view.dateArr
        default:
            break
        }
        
        model.repeatMode = view.btnArr.isEmpty ? .NO : model.repeatMode
        
        setRepeatContent(model: model)
        
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
    
    func selectRepeatViewCancelBtnClicked() {
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
}

// MARK: - DiscoverTodoSelectTypeViewDelegate

extension ToDoDetailVC: DiscoverTodoSelectTypeViewDelegate {
    
    func selectTypeViewSureBtnClicked(_ type: ToDoType) {
        model.typeMode = type
        var string = ""
        switch type {
        case .study:
            string = "study"
        case .life:
            string = "life"
        case .other:
            string = "other"
        default:
            break
        }
        model.type = string as NSString
        setTypeTitle(modelStr: string)
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
    
    func selectTypeViewCancelBtnClicked() {
        UIView.animate(withDuration: 0.3) {
            self.detailView.blackBackView.alpha = 0
            self.detailView.whiteBackView.top = SCREEN_HEIGHT
        }
    }
}
