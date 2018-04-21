//
//  NSString+SCRAttributedStringBuilder.h
//  SCRAttributedStringBuilder
//
//  Created by Chuanren Shang on 2018/4/21.
//  Copyright © 2018 Chuanren Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCRAttributedStringBuilder)

// 生成 Attributed String
- (NSMutableAttributedString *)attributedBuild;

@end
