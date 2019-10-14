//
//  SwiftViewController.swift
//  SCRAttributedStringBuilderDemo
//
//  Created by Chuanren Shang on 2019/7/21.
//  Copyright © 2019 Chuanren Shang. All rights reserved.
//

import UIKit
import SCRAttributedStringBuilder

class SwiftViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blue
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "luffer")
        attachment.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        let text = "测试多行文字测试多行文字测试多行文字链接测试多行文字测试多行文字链接测试多行文字测试多行文字测试多行文字链接测试多行文字测试多行文字测试多行文字\n"
        label.attributedText = AttributedStringBuilder.build { builder in
            builder
                .append("颜色字体\n").fontSize(30).color(UIColor.purple)
                .range(1, 1).color(UIColor.red)
                .insert("/插入文字/", 2).fontSize(20).color(UIColor.blue)
                .append(text).firstLineHeadIndent(20).lineHeight(25).paragraphSpacing(20)
                .match("链接").hexColor(0xFF4400).backgroundColor(UIColor.lightGray)
                .matchFirst("链接").underlineStyle(.thick).underlineColor(UIColor.green)
                .matchLast("链接").strikethroughStyle(.single).strikethroughColor(UIColor.yellow)
                .append(text).alignment(.center).headIndent(20).tailIndent(-20).lineSpacing(10)
                .append("路飞").font(UIFont.systemFont(ofSize:25)).strokeWidth(2).strokeColor(UIColor.darkGray)
                .headInsertImage(UIImage(named:"luffer")!, CGSize(width: 50, height: 50), UIFont.systemFont(ofSize:25))
                .appendImage(UIImage(named:"luffer")!, CGSize(width: 50, height: 50))
                .appendImage(UIImage(named:"luffer")!, CGSize(width: 50, height: 50), UIFont.systemFont(ofSize: 15))
                .append("路飞").font(UIFont.systemFont(ofSize:15))
                .appendSpacing(20)
                .appendAttachment(attachment)
                .insertImage(UIImage(named: "luffer")!, CGSize(width: 50, height: 50), 0, UIFont.systemFont(ofSize:30))
                .append("\n阴影").shadow(shadow).append("基线偏移\n").baselineOffset(-5)
                .append(" ").backgroundColor(UIColor.red).fontSize(2).end()
        }
    }

}
