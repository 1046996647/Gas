//
//  ZwlSlider.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ZwlSlider.h"

@implementation ZwlSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, bounds.size.width, 15);
}


@end
