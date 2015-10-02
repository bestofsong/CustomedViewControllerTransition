//
//  AnimationController.h
//  CustomViewControllerTransition
//
//  Created by wansong on 15/10/2.
//  Copyright © 2015年 self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isDismissTransition;
+ (instancetype)sharedAnimationController;
@end
