//
//  NSMutableAttributedString+SCRAttributedStringBuilder.h
//  SCRAttributedStringBuilder
//
//  Created by Chuanren Shang on 2018/4/21.
//  Copyright © 2018 Chuanren Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

// 原理说明：
// 将方法分为 Content，Range 和 Attribute 三类，其中 Content 用于添加内容，Attribute 用于给内容应用属性，而 Range 用于调整应用范围。
// 因此，在 Content 中，无论是 append 还是 insert，会将当前 Range 切换成新加入内容的，属性会应用在此 Range 上。
// 由于属性主要用于应用在字符上，因此附件不会切换 Range。另外为了应对 match 到多个的情况，Range 是一个数组。

@interface NSMutableAttributedString (SCRAttributedStringBuilder)

#pragma mark - Content

// 创建一个 Attributed String
+ (NSMutableAttributedString *(^)(NSString *string))build;

// 尾部追加一个新的 Attributed String
- (NSMutableAttributedString *(^)(NSString *string))append;

// 同 append 比，参数是 NSAttributedString
- (NSMutableAttributedString *(^)(NSAttributedString *attributedString))attributedAppend;

// 插入一个新的 Attributed String
- (NSMutableAttributedString *(^)(NSString *string, NSUInteger index))insert;

// 增加间隔，spacing 的单位是 point。放到 Content 的原因是，间隔是通过空格+字体模拟的，但不会导致 Range 的切换
- (NSMutableAttributedString *(^)(CGFloat spacing))appendSpacing;

// 尾部追加一个附件。同插入字符不同，插入附件并不会将当前 Range 切换成附件所在的 Range，下同
- (NSMutableAttributedString *(^)(NSTextAttachment *))appendAttachment;

// 在尾部追加图片附件，默认使用图片尺寸，图片垂直居中，为了设置处理垂直居中（基于字体的 capHeight），需要在添加图片附件之前设置字体
- (NSMutableAttributedString *(^)(UIImage *image))appendImage;

// 在尾部追加图片附件，可以自定义尺寸，默认使用图片前一位的字体进行对齐，其他同 appendImage
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))appendSizeImage;

// 在尾部追加图片附件，可以自定义想对齐的字体，图片使用自身尺寸，其他同 appendImage
- (NSMutableAttributedString *(^)(UIImage *, UIFont *))appendFontImage;

// 在尾部追加图片附件，可以自定义尺寸和想对齐的字体，其他同 appendImage
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))appendCustomImage;

// 在 index 位置插入图片附件，由于不确定字体信息，因此需要显式输入字体
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font))insertImage;

// 同 insertImage 的区别在于，会在当前 Range 的头部插入图片附件，如果没有 Range 则什么也不做
- (NSMutableAttributedString *(^)(UIImage *, CGSize, UIFont *))headInsertImage;

#pragma mark - Range

// 根据 start 和 length 设置范围
- (NSMutableAttributedString *(^)(NSInteger location, NSInteger length))range;

// 将范围设置为当前字符串全部
- (NSMutableAttributedString *)all;

// 匹配所有符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))match;

// 从头开始匹配第一个符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))matchFirst;

// 为尾开始匹配第一个符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))matchLast;

#pragma mark - Basic

// 字体
- (NSMutableAttributedString *(^)(UIFont *font))font;

// 字号，默认字体
- (NSMutableAttributedString *(^)(CGFloat fontSize))fontSize;

// 字体颜色
- (NSMutableAttributedString *(^)(UIColor *color))color;

// 字体颜色，16 进制
- (NSMutableAttributedString *(^)(NSInteger hex))hexColor;

// 背景颜色
- (NSMutableAttributedString *(^)(UIColor *color))backgroundColor;

#pragma mark - Glyph

// 删除线风格
- (NSMutableAttributedString *(^)(NSUnderlineStyle style))strikethroughStyle;

// 删除线颜色
// 由于 iOS 的 Bug，删除线在 iOS 10.3 中无法正确显示，需要配合 baseline 使用
// 具体见：https://stackoverflow.com/questions/43074652/ios-10-3-nsstrikethroughstyleattributename-is-not-rendered-if-applied-to-a-sub
- (NSMutableAttributedString *(^)(UIColor *color))strikethroughColor;

// 下划线风格
- (NSMutableAttributedString *(^)(NSUnderlineStyle style))underlineStyle;

// 下划线颜色
- (NSMutableAttributedString *(^)(UIColor *color))underlineColor;

// 字形边框颜色
- (NSMutableAttributedString *(^)(UIColor *color))strokeColor;

// 字形边框宽度
- (NSMutableAttributedString *(^)(CGFloat width))strokeWidth;

// 字体效果
- (NSMutableAttributedString *(^)(NSString *effect))textEffect;

// 阴影
- (NSMutableAttributedString *(^)(NSShadow *shadow))shadow;

// 链接
- (NSMutableAttributedString *(^)(NSURL *url))link;

#pragma mark - Paragraph

// 行间距
- (NSMutableAttributedString *(^)(CGFloat spacing))lineSpacing;

// 段间距
- (NSMutableAttributedString *(^)(CGFloat spacing))paragraphSpacing;

// 对齐
- (NSMutableAttributedString *(^)(NSTextAlignment alignment))alignment;

// 换行
- (NSMutableAttributedString *(^)(NSLineBreakMode mode))lineBreakMode;

// 段第一行头部缩进
- (NSMutableAttributedString *(^)(CGFloat indent))firstLineHeadIndent;

// 段头部缩进
- (NSMutableAttributedString *(^)(CGFloat indent))headIndent;

// 段尾部缩进
- (NSMutableAttributedString *(^)(CGFloat indent))tailIndent;

// 行高，iOS 的行高会在顶部增加空隙，效果一般不符合 UI 的认知，很少使用
// 这里为了完全匹配 Sketch 的行高效果，会根据当前字体对 baselineOffset 进行修正
// 具体见: https://joeshang.github.io/2018/03/29/ios-multiline-text-spacing/
- (NSMutableAttributedString *(^)(CGFloat lineHeight))lineHeight;

#pragma mark - Special

// 基线偏移
- (NSMutableAttributedString *(^)(CGFloat offset))baselineOffset;

// 连字
- (NSMutableAttributedString *(^)(CGFloat ligature))ligature;

// 字间距
- (NSMutableAttributedString *(^)(CGFloat kern))kern;

// 倾斜
- (NSMutableAttributedString *(^)(CGFloat obliqueness))obliqueness;

// 扩张
- (NSMutableAttributedString *(^)(CGFloat expansion))expansion;

@end
