//
//  AttributedStringBuilder
//  SCRAttributedStringBuilder
//
//  Created by Chuanren Shang on 2019/7/21.
//  Copyright © 2019 Chuanren Shang. All rights reserved.
//

import Foundation
import UIKit

public class AttributedStringBuilder {
    private var attributedString = NSMutableAttributedString()
    private var ranges = [NSRange]()

    public class func build(_ config: (_ builder: AttributedStringBuilder) -> Void) -> NSMutableAttributedString {
        let builder = AttributedStringBuilder()
        config(builder)
        return builder.result()
    }

    public func result() -> NSMutableAttributedString {
        return attributedString
    }

    // MARK: - Content

    public func end() -> Void {
    }

    public func append(_ string: String) -> AttributedStringBuilder {
        ranges = [ NSRange(location: attributedString.length, length: string.count) ]
        attributedString.append(NSAttributedString(string: string))
        return self
    }

    public func insert(_ string: String, _ index: Int) -> AttributedStringBuilder {
        guard index <= attributedString.length else {
            return self
        }
        attributedString.insert(NSAttributedString(string: string), at: index)
        ranges = [ NSRange(location: index, length: string.count) ]
        return self
    }

    public func appendSpacing(_ spacing: Float) -> AttributedStringBuilder {
        guard spacing > 0 else {
            return self
        }
        let attachment = NSTextAttachment()
        attachment.image = nil
        attachment.bounds = CGRect(x: 0, y: 0, width: Int(spacing), height: 0)
        return appendAttachment(attachment)
    }

    public func appendAttachment(_ attachment: NSTextAttachment) -> AttributedStringBuilder {
        attributedString.append(NSAttributedString(attachment: attachment))
        return self
    }

    public func appendImage(_ image: UIImage) -> AttributedStringBuilder {
        return appendImage(image, image.size)
    }

    public func appendImage(_ image: UIImage, _ imageSize: CGSize) -> AttributedStringBuilder {
        let font = attributedString.attribute(.font, at: attributedString.string.count - 1, effectiveRange: nil) as? UIFont
        return appendImage(image, imageSize, font)
    }

    public func appendImage(_ image: UIImage, _ font: UIFont) -> AttributedStringBuilder {
        return appendImage(image, image.size, font)
    }

    public func appendImage(_ image: UIImage, _ imageSize: CGSize, _ font: UIFont?) -> AttributedStringBuilder {
        var offset: CGFloat = 0
        if let font = font {
            offset = CGFloat(roundf(Float((font.capHeight - imageSize.height) / 2)))
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: offset, width: imageSize.width, height: imageSize.height)
        attributedString.append(NSAttributedString(attachment: attachment))
        return self
    }

    public func insertImage(_ image: UIImage, _ imageSize: CGSize, _ index: Int, _ font: UIFont) -> AttributedStringBuilder {
        let offset = CGFloat(roundf(Float((font.capHeight - imageSize.height) / 2)))
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: offset, width: imageSize.width, height: imageSize.height)
        attributedString.insert(NSAttributedString(attachment: attachment), at: index)
        var updatedRange = [NSRange]()
        for range in ranges {
            updatedRange.append(NSRange(location: range.location + 1, length: range.length))
        }
        ranges = updatedRange
        return self
    }

    public func headInsertImage(_ image: UIImage, _ imageSize: CGSize, _ font: UIFont) -> AttributedStringBuilder {
        var updatedRange = [NSRange]()
        for range in ranges {
            let offset = CGFloat(roundf(Float((font.capHeight - imageSize.height) / 2)))
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: offset, width: imageSize.width, height: imageSize.height)
            attributedString.insert(NSAttributedString(attachment: attachment), at: range.location)
            updatedRange.append(NSRange(location: range.location + 1, length: range.length))
        }
        ranges = updatedRange
        return self
    }

    // MARK: - Range

    public func range(_ location: Int, _ length: Int) -> AttributedStringBuilder {
        guard location >= 0 && length > 0 && location + length <= attributedString.length else {
            return self
        }
        ranges = [ NSRange(location: location, length: length) ]
        return self
    }

    public func all() -> AttributedStringBuilder {
        ranges = [ NSRange(location: 0, length: attributedString.length) ]
        return self
    }

    public func match(_ keyword: String) -> AttributedStringBuilder {
        guard keyword.count > 0 else {
            return self
        }
        var result = [NSRange]()
        var searchRange = NSRange(location: 0, length: attributedString.length)
        var foundRange = NSRange()
        while searchRange.location < attributedString.string.count {
            let string = NSString(string: attributedString.string)
            foundRange = string.range(of: keyword, options: [], range: searchRange)
            if foundRange.location == NSNotFound {
                break
            }
            result.append(foundRange)
            searchRange.location = foundRange.location + foundRange.length
            searchRange.length = attributedString.string.count - searchRange.location
        }
        ranges = result
        return self
    }

    public func matchFirst(_ keyword: String) -> AttributedStringBuilder {
        guard keyword.count > 0 else {
            return self
        }
        let string = NSString(string: attributedString.string)
        let range = string.range(of: keyword)
        if range.location != NSNotFound {
            ranges = [ range ]
        }
        return self
    }

    public func matchLast(_ keyword: String) -> AttributedStringBuilder {
        guard keyword.count > 0 else {
            return self
        }
        let string = NSString(string: attributedString.string)
        let range = string.range(of: keyword, options: [ .backwards ])
        if range.location != NSNotFound {
            ranges = [ range ]
        }
        return self
    }

    // MARK: - Basic

    public func font(_ font: UIFont) -> AttributedStringBuilder {
        addAttribute(name: .font, value: font)
        return self
    }

    public func fontSize(_ size: CGFloat) -> AttributedStringBuilder {
        let font = UIFont.systemFont(ofSize: size)
        addAttribute(name: .font, value: font)
        return self
    }

    public func color(_ color: UIColor) -> AttributedStringBuilder {
        addAttribute(name: .foregroundColor, value: color)
        return self
    }

    public func hexColor(_ hexValue: Int) -> AttributedStringBuilder {
        let red = CGFloat((hexValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexValue & 0xFF) / 255.0
        let color = UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
        addAttribute(name: .foregroundColor, value: color)
        return self
    }

    public func backgroundColor(_ color: UIColor) -> AttributedStringBuilder {
        addAttribute(name: .backgroundColor, value: color)
        return self
    }

    // MARK: - Glyph

    public func strikethroughStyle(_ style: NSUnderlineStyle) -> AttributedStringBuilder {
        addAttribute(name: .strikethroughStyle, value: style.rawValue)
        return self
    }

    public func strikethroughColor(_ color: UIColor) -> AttributedStringBuilder {
        addAttribute(name: .strikethroughColor, value: color)
        return self
    }

    public func underlineStyle(_ style: NSUnderlineStyle) -> AttributedStringBuilder {
        addAttribute(name: .underlineStyle, value: style.rawValue)
        return self
    }

    public func underlineColor(_ color: UIColor) -> AttributedStringBuilder {
        addAttribute(name: .underlineColor, value: color)
        return self
    }

    public func strokeColor(_ color: UIColor) -> AttributedStringBuilder {
        addAttribute(name: .strokeColor, value: color)
        return self
    }

    public func strokeWidth(_ width: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .strokeWidth, value: width)
        return self
    }

    public func shadow(_ shadow: NSShadow) -> AttributedStringBuilder {
        addAttribute(name: .shadow, value: shadow)
        return self
    }

    public func textEffect(_ effect: String) -> AttributedStringBuilder {
        addAttribute(name: .textEffect, value: effect)
        return self
    }

    public func link(_ link: URL) -> AttributedStringBuilder {
        addAttribute(name: .link, value: link)
        return self
    }

    // MARK: - Paragraph

    public func lineSpacing(_ lineSpacing: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.lineSpacing = lineSpacing
        }
        return self
    }

    public func paragraphSpacing(_ paragraphSpacing: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.paragraphSpacing = paragraphSpacing
        }
        return self
    }

    public func alignment(_ alignment: NSTextAlignment) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.alignment = alignment
        }
        return self
    }

    public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.lineBreakMode = lineBreakMode
        }
        return self
    }

    public func firstLineHeadIndent(_ firstLineHeadIndent: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.firstLineHeadIndent = firstLineHeadIndent
        }
        return self
    }

    public func headIndent(_ headIndent: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.headIndent = headIndent
        }
        return self
    }

    public func tailIndent(_ tailIndent: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.tailIndent = tailIndent
        }
        return self
    }

    public func lineHeight(_ lineHeight: CGFloat) -> AttributedStringBuilder {
        configParagraphStyle { style in
            style.minimumLineHeight = lineHeight
            style.maximumLineHeight = lineHeight
        }
        for range in ranges {
            var offset: CGFloat = 0
            if let font = attributedString.attribute(.font, at: range.location + range.length - 1, effectiveRange: nil) as? UIFont {
                offset = (lineHeight - font.lineHeight) / 4.0
            }
            attributedString.addAttribute(.baselineOffset, value: offset, range: range)
        }
        return self
    }

    // MARK: - Special

    public func baselineOffset(_ offset: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .baselineOffset, value: offset)
        return self
    }

    public func ligature(_ ligature: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .ligature, value: ligature)
        return self
    }

    public func kern(_ kern: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .kern, value: kern)
        return self
    }

    public func obliqueness(_ obliqueness: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .obliqueness, value: obliqueness)
        return self
    }

    public func expansion(_ expansion: CGFloat) -> AttributedStringBuilder {
        addAttribute(name: .expansion, value: expansion)
        return self
    }

    // MARK: - Private

    private func addAttribute(name: NSAttributedString.Key, value: Any) {
        for range in ranges {
            attributedString.addAttribute(name, value: value, range: range)
        }
    }

    private func configParagraphStyle(_ config: (NSMutableParagraphStyle) -> Void) {
        for range in ranges {
            let index = range.location + range.length - 1
            var style = attributedString.attribute(.paragraphStyle, at: index, effectiveRange: nil) as? NSMutableParagraphStyle
            if style == nil {
                style = NSMutableParagraphStyle()
            }
            if let style = style {
                config(style)
                attributedString.addAttribute(.paragraphStyle, value: style, range: range)
            }
        }
    }

}
