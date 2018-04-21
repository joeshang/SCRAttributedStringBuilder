//
//  NSString+SCRAttributedStringBuilder.m
//  SCRAttributedStringBuilder
//
//  Created by Chuanren Shang on 2018/4/21.
//  Copyright © 2018 Chuanren Shang. All rights reserved.
//

#import "NSString+SCRAttributedStringBuilder.h"
#import "NSMutableAttributedString+SCRAttributedStringBuilder.h"

@implementation NSString (SCRAttributedStringBuilder)

- (NSMutableAttributedString *)attributedBuild {
    return NSMutableAttributedString.build(self);
}

@end
