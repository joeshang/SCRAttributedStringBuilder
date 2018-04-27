//
//  ViewController.m
//  SCRAttributedStringBuilderDemo
//
//  Created by Chuanren Shang on 2018/4/21.
//  Copyright © 2018 Chuanren Shang. All rights reserved.
//

#import "ViewController.h"
#import "NSString+SCRAttributedStringBuilder.h"
#import "NSMutableAttributedString+SCRAttributedStringBuilder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    NSString *text = @"测试多行文字测试多行文字测试多行文字链接测试多行文字测试多行文字链接测试多行文字测试多行文字测试多行文字链接测试多行文字测试多行文字测试多行文字\n";
    self.label.attributedText = @"颜色/字体\n".attributedBuild.fontSize(30).color([UIColor purpleColor])
        .range(1, 1).color([UIColor redColor])
        .append(text).firstLineHeadIndent(20).lineHeight(25).paragraphSpacing(20)
        .match(@"链接").hexColor(0xFF4400).backgroundColor([UIColor lightGrayColor])
        .matchFirst(@"链接").underlineStyle(NSUnderlineStyleThick).underlineColor([UIColor greenColor])
        .matchLast(@"链接").strikethroughStyle(NSUnderlineStyleSingle).strikethroughColor([UIColor yellowColor])
        .append(text).alignment(NSTextAlignmentCenter).headIndent(20).tailIndent(-20).lineSpacing(10)
        .append(@"路飞").font([UIFont systemFontOfSize:25]).strokeWidth(2).strokeColor([UIColor darkGrayColor])
        .appendSizeImage([UIImage imageNamed:@"luffer"], CGSizeMake(50, 50))
        .insertImage([UIImage imageNamed:@"luffer"], CGSizeMake(50, 50), [UIFont systemFontOfSize:25])
        .append(@"\n阴影").shadow(shadow).append(@"基线偏移").baselineOffset(-5);
}

@end
