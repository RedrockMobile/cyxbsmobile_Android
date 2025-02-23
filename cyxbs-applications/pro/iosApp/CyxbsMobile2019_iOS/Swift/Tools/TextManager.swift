//
//  TextLimitManager.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/15.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class TextManager {
    static let shared = TextManager()

    private init() {}
    
    //计算文本在使用某字体时的宽度
    func calculateTextWidth(text: String, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let textSize = attributedText.size()
        return textSize.width
    }

    //限制textfield输入字数
    func setupLimitForTextField(_ textField: UITextField, maxLength: Int) {
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: nil) { [weak self] (notification) in
            self?.textFieldDidChange(notification, textField: textField, maxLength: maxLength)
        }
    }

    //限制textview输入字数
    func setupLimitForTextView(_ textView: UITextView, maxLength: Int) {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: textView, queue: nil) { [weak self] (notification) in
            self?.textViewDidChange(notification, textView: textView, maxLength: maxLength)
        }
    }

    private func textFieldDidChange(_ notification: Notification, textField: UITextField, maxLength: Int) {
        if let toBeString = textField.text {
            // 键盘输入模式（OC里面通过[[UITextInputMode currentInputMode] primaryLanguage]来获取当前输入法，Swift里面没有currentInputMode这个东西，只能是获取你正在使用的所有输入法，然后第一个就是当前输入法）
            if let language = UITextInputMode.activeInputModes.first?.primaryLanguage {
                if language == "zh-Hans" {
                    // 中文输入法
                    // 这里跟OC也有点区别，直接如下这么写就行，只有在输入拼音选中后才会走到else里面，然后在else里面写条件判断就好了
                    if let _ = textField.markedTextRange {
                    } else {
                        if toBeString.count > maxLength {
                            // swift里面处理字符串特别麻烦，这里非要用String.index 这种类型，然后我给string常用的一些方法都封装了一下。这里直接这么调用就可以
                            textField.text = toBeString.substring(to: maxLength)
                        }
                    }
                } else {
                    // 非中文输入法，直接统计字数和限制，这里没有考虑其他语种的情况
                    if toBeString.count > maxLength {
                        textField.text = toBeString.substring(to: maxLength)
                    }
                }
            }
        }
    }

    private func textViewDidChange(_ notification: Notification, textView: UITextView, maxLength: Int) {
        if let toBeString = textView.text {
            // 键盘输入模式（OC里面通过[[UITextInputMode currentInputMode] primaryLanguage]来获取当前输入法，Swift里面没有currentInputMode这个东西，只能是获取你正在使用的所有输入法，然后第一个就是当前输入法）
            if let language = UITextInputMode.activeInputModes.first?.primaryLanguage {
                if language == "zh-Hans" {
                    // 中文输入法
                    // 这里跟OC也有点区别，直接如下这么写就行，只有在输入拼音选中后才会走到else里面，然后在else里面写条件判断就好了
                    if let _ = textView.markedTextRange {
                    } else {
                        if toBeString.count > maxLength {
                            // swift里面处理字符串特别麻烦，这里非要用String.index 这种类型，然后我给string常用的一些方法都封装了一下。这里直接这么调用就可以
                            textView.text = toBeString.substring(to: maxLength)
                        }
                    }
                } else {
                    // 非中文输入法，直接统计字数和限制，这里没有考虑其他语种的情况
                    if toBeString.count > maxLength {
                        textView.text = toBeString.substring(to: maxLength)
                    }
                }
            }
        }
    }
}

extension String {
    // 截取字符串从开始到 index
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self
        }
        return String(self[startIndex..<end_Index])
    }

    // 截取字符串从 index 到结束
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index) else {
            return self
        }
        return String(self[start_index..<endIndex])
    }

    // 切割字符串(区间范围 前闭后开)
    func sliceString(_ range: CountableRange<Int>) -> String {
        guard let startIndex = validStartIndex(original: range.lowerBound), let endIndex = validEndIndex(original: range.upperBound), startIndex <= endIndex else {
            return ""
        }
        return String(self[startIndex..<endIndex])
    }

    // 切割字符串(区间范围 前闭后闭)
    func sliceString(_ range: CountableClosedRange<Int>) -> String {
        guard let start_Index = validStartIndex(original: range.lowerBound), let end_Index = validEndIndex(original: range.upperBound), startIndex <= endIndex else {
            return ""
        }
        if endIndex.encodedOffset <= end_Index.encodedOffset {
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }

    // 校验字符串位置是否合理，并返回 String.Index
    private func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset:
            return startIndex
        case endIndex.encodedOffset...:
            return endIndex
        default:
            return index(startIndex, offsetBy: original)
        }
    }

    // 校验是否是合法的起始位置
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else {
            return nil
        }
        return validIndex(original: original)
    }

    // 校验是否是合法的结束位置
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else {
            return nil
        }
        return validIndex(original: original)
    }
}

