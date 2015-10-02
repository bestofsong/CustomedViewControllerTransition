//
//  InteractiveTransitionController.m
//  CustomViewControllerTransition
//
//  Created by wansong on 15/10/2.
//  Copyright © 2015年 self. All rights reserved.
//

#import "InteractiveTransitionController.h"

@implementation InteractiveTransitionController

+ (instancetype)sharedInstance {
  static dispatch_once_t once;
  static id ret = nil;
  dispatch_once(&once, ^{
    ret = [[[self class] alloc] init];
  });
  
  return ret;
}
@end
