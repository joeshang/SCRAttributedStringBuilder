//
//  NSMutableAttributedString+SCRAttributedStringBuilder.h
//  SCRAttributedStringBuilder
//
//  Created by Chuanren Shang on 2018/4/21.
//  Copyright © 2018 Chuanren Shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (SCRAttributedStringBuilder)

#pragma mark - Content

// 创建一个 Attributed String
+ (NSMutableAttributedString *(^)(NSString *string))build;

// 尾部追加一个新的 Attributed String
- (NSMutableAttributedString *(^)(NSString *string))append;

// 在尾部添加图片附件，默认使用图片尺寸，图片垂直居中，为了设置处理垂直居中（基于字体的 capHeight），需要在添加图片附件之前设置字体
- (NSMutableAttributedString *(^)(UIImage *image))appendImage;

// 在尾部添加图片附件，可以自定义尺寸，其他同 appendImage
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))appendSizeImage;

// 在头部添加图片附件，由于不确定字体信息，因此需要显式输入字体
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))insertImage;

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

// 行高，为了实现 Sketch 效果，会根据当前字体对 baselineOffset 进行修正
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
