//
//  AnimationController.m
//  CustomViewControllerTransition
//
//  Created by wansong on 15/10/2.
//  Copyright © 2015年 self. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController()
@property id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation AnimationController

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  self.transitionContext = transitionContext;
  UIView *containterView = [transitionContext containerView];
  
  UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect bounds = containterView.bounds;
  if (self.isDismissTransition) {
    [containterView bringSubviewToFront:from.view];
    [containterView insertSubview:to.view belowSubview:from.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                       from.view.transform = CGAffineTransformMakeTranslation(0, bounds.size.height);
                     } completion:^(BOOL finished) {
                       CGRect finalFrame = bounds;
                       finalFrame.origin.y += bounds.size.height;
                       from.view.frame = finalFrame;
                       [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
  }else {
    bounds.origin.y += bounds.size.height;
    [containterView insertSubview:to.view aboveSubview:from.view];
    to.view.transform = CGAffineTransformMakeTranslation(0, bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                       to.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                       [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
  }
  
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return 3;
}

- (void)animationEnded:(BOOL)transitionCompleted {
  if (!transitionCompleted) {
    
    UIView *containterView = [self.transitionContext containerView];
    UIViewController *from = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containterView addSubview:from.view];
    
    [to.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
  }else {
    NSLog(@"animation finished normally.");
  }
}

+ (instancetype)sharedAnimationController {
  static dispatch_once_t once;
  static id ret = nil;
  dispatch_once(&once, ^{
    ret = [[[self class] alloc] init];
  });
  
  return ret;
}
@end
