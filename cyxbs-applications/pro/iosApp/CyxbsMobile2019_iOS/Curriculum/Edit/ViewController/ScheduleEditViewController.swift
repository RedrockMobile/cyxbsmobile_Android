//
//  ScheduleEditViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import ProgressHUD

class ScheduleEditViewController: UIViewController {
    
    var dismissAction: ((ScheduleEditViewController) -> ())?
    
    private(set) var isAppending: Bool
    
    init(curriculum: CurriculumModel) {
        modelCalculate = curriculum
        isAppending = false
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience
    init(title: String? = nil, place: String? = nil, sections: IndexSet = [], inWeek: Int, location: Int, lenth: Int = 1) {
        
        var curriculum = CurriculumModel()
        curriculum.course = title ?? ""
        curriculum.classRoom = place ?? ""
        var sections = sections
        if sections.contains(0) {
            sections = IndexSet(1 ... 24)
        }
        curriculum.inSections = sections
        curriculum.inWeek = inWeek
        curriculum.period = location ... location + lenth
        
        self.init(curriculum: curriculum)
        isAppending = true
    }
    
    private(set) var modelCalculate: CurriculumModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        view.addSubview(backgroundImgView)
        view.addSubview(contentScrollView)
        view.addSubview(cancelBtn)
        if !isAppending {
            view.addSubview(deleteBtn)
        }
        setupUI()
        setupData()
    }
    
    // MARK: lazy
    
    lazy var backgroundImgView: UIImageView = {
        let imgView = UIImageView(frame: view.bounds)
        imgView.image = UIImage(named: "curriculum.custom.background")
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = createBtn(title: "  取消  ", touchUpInsideAction: #selector(touchUpInside(cancelBtn:)))
        btn.frame.origin = CGPoint(x: view.bounds.width - btn.bounds.width - 17, y: Constants.statusBarHeight + 10)
        return btn
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = createBtn(title: "  删除  ", touchUpInsideAction: #selector(touchUpInside(deleteBtn:)))
        btn.frame.origin = CGPoint(x: cancelBtn.frame.minX - btn.bounds.width - 10, y: cancelBtn.frame.minY)
        return btn
    }()

    lazy var editView: ScheduleCustomEditView = {
        let editView = ScheduleCustomEditView(frame: CGRect(x: 0, y: Constants.statusBarHeight, width: view.bounds.width, height: view.bounds.height))
        editView.sizeToFit()
        editView.backBtnTaped = { aView in
            self.finishEditing(view: aView)
        }
        return editView
    }()
}

// MARK: setup

extension ScheduleEditViewController {
    
    func createBtn(title: String?, touchUpInsideAction action: Selector) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(.hex("#4841E2"), for: .normal)
        btn.sizeToFit()
        btn.frame.origin = CGPoint(x: view.bounds.width - 17, y: Constants.statusBarHeight + 10)
        btn.backgroundColor = .ry(light: "#F2F3F8", dark: "#000000").withAlphaComponent(0.6)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    func setupUI() {
        contentScrollView.addSubview(editView)
        contentScrollView.contentSize.height = editView.frame.maxY + 20
    }
    
    func setupData() {
        let title = modelCalculate.course.count > 0 ? modelCalculate.course : nil
        let place = modelCalculate.classRoom.count > 0 ? modelCalculate.classRoom : nil
        editView.prepare(title: title, place: place, sections: modelCalculate.inSections, inWeek: modelCalculate.inWeek, location: modelCalculate.period.lowerBound, lenth: modelCalculate.period.count)
    }
}

// MARK: interactive

extension ScheduleEditViewController {
    
    @objc
    func touchUpInside(cancelBtn: UIButton) {
        dismiss(animated: true)
    }
    
    @objc
    func touchUpInside(deleteBtn: UIButton) {
        deleteCourse()
    }
    
    func finishEditing(view: ScheduleCustomEditView) {
        modelCalculate.course = view.title
        modelCalculate.classRoom = view.place
        modelCalculate.period = view.period
        modelCalculate.inSections = view.sections
        modelCalculate.inWeek = view.inWeek
        modelCalculate.teacher = "自定义"
        modelCalculate.type = "事务"
        modelCalculate.rawWeek = modelCalculate.inSections.rangeView.map { "\($0.lowerBound)-\($0.upperBound - 1)" }.joined(separator: ", ") + "周"
        
        if isAppending {
            requestToAppending()
        } else {
            requestToChangging()
        }
    }
    
    func requestToAppending() {
        ProgressHUD.show("正在添加事项")
        
        HttpManager.shared.magipoke_reminder_Person_addTransaction(begin_lesson: modelCalculate.period.lowerBound, period: modelCalculate.period.count, day: modelCalculate.inWeek - 1, week: Array(modelCalculate.inSections), title: modelCalculate.course, content: modelCalculate.classRoom).ry_JSON { response in
            switch response {
            case .success(let model):
                let status = model["state"].intValue
                if status == 10000 {
                    self.modelCalculate.courseID = "\(model["id"].intValue)"
                    ProgressHUD.showSuccess("云端已更新")
                }
                fallthrough
                
            case .failure(_):
                UserModel.default.customSchedule.curriculum.append(self.modelCalculate)
            }
            ProgressHUD.showSucceed("添加事项成功")
            self.dismissTodo()
        }
    }
    
    func deleteCourse() {
        ProgressHUD.show("正在删除事项")
        
        let id = Int(modelCalculate.courseID ?? "") ?? 0
        HttpManager.shared.magipoke_reminder_Person_deleteTransaction(id: id).ry_JSON { response in
            switch response {
            case .success(let model):
                let status = model["state"].intValue
                if status == 10000 {
                    ProgressHUD.showSuccess("云端已删除")
                }
                fallthrough
                
            case .failure(_):
                if let index = UserModel.default.customSchedule.curriculum.firstIndex(where: { $0.courseID == self.modelCalculate.courseID }) {
                    UserModel.default.customSchedule.curriculum.remove(at: index)
                }
            }
            ProgressHUD.showSucceed("删除事项成功")
            self.dismissTodo()
        }
    }
    
    func requestToChangging() {
        ProgressHUD.show("正在修改事项")
        
        HttpManager.shared.magipoke_reminder_Person_editTransaction(begin_lesson: modelCalculate.period.lowerBound, period: modelCalculate.period.count, day: modelCalculate.inWeek - 1, week: Array(modelCalculate.inSections), id: Int(modelCalculate.courseID ?? "") ?? 0, title: modelCalculate.course, content: modelCalculate.classRoom).ry_JSON { response in
            switch response {
            case .success(let model):
                let status = model["state"].intValue
                if status == 10000 {
                    self.modelCalculate.courseID = "\(model["id"].intValue)"
                    ProgressHUD.showSuccess("云端修改成功")
                }
                fallthrough
                
            case .failure(_):
                if let index = UserModel.default.customSchedule.curriculum.firstIndex(where: { $0.courseID == self.modelCalculate.courseID }) {
                    UserModel.default.customSchedule.curriculum[index] = self.modelCalculate
                    ProgressHUD.showSucceed("本地修改成功")
                    self.dismissTodo()
                } else {
                    ProgressHUD.showError("未找到本地事项")
                    self.requestToAppending()
                }
            }
        }
    }
    
    func dismissTodo() {
        dismissAction?(self)
        dismiss(animated: true)
    }
}
