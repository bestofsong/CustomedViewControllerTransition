//
//  ViewController.m
//  CustomViewControllerTransition
//
//  Created by wansong on 15/10/1.
//  Copyright © 2015年 self. All rights reserved.
//

#import "ViewController.h"
#import "AnimationController.h"
#import "InteractiveTransitionController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) UIViewController *dest;
@property (nonatomic) BOOL transitionNeedInteractive;
- (IBAction)goButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.dest = [[self storyboard] instantiateViewControllerWithIdentifier:@"DestViewController"];
  self.dest.transitioningDelegate = self;
  
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
  [self.view addGestureRecognizer:pan];
}

-(void)handlePan:(UIPanGestureRecognizer *)pinch {
  self.transitionNeedInteractive = YES;
  CGFloat fullRange = self.view.bounds.size.height;
  CGPoint touchPoint = [pinch translationInView:self.view];
  CGFloat currentRange = -touchPoint.y;
  
  switch (pinch.state) {
    case UIGestureRecognizerStateBegan: {
      [self goButton:nil];
      [[InteractiveTransitionController sharedInstance] updateInteractiveTransition:0];
      break;
    }
    case UIGestureRecognizerStateChanged: {
      CGFloat progress = currentRange / fullRange;
      if (progress < 0) {
        progress = 0;
      }else if (progress > 1) {
        progress = 1;
      }else{}
      
      [[InteractiveTransitionController sharedInstance] updateInteractiveTransition:progress];
      break;
    }
      
    case UIGestureRecognizerStatePossible:
    case UIGestureRecognizerStateFailed:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateEnded: {
      BOOL cancelled = currentRange < fullRange * 0.6;
      if (cancelled) {
       [[InteractiveTransitionController sharedInstance] cancelInteractiveTransition];
      } else {
       [[InteractiveTransitionController sharedInstance] finishInteractiveTransition];
      }
      break;
    }
  }
}

- (IBAction)goButton:(id)sender {
  self.transitionNeedInteractive = NO;
  [self showViewController:self.dest sender:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  [[AnimationController sharedAnimationController] setIsDismissTransition:NO];
  return [AnimationController sharedAnimationController];
}

-(id)animationControllerForDismissedController:(UIViewController *)dismissed {
  [[AnimationController sharedAnimationController] setIsDismissTransition:YES];
  return [AnimationController sharedAnimationController];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
  return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
  return self.transitionNeedInteractive ? [InteractiveTransitionController sharedInstance] : nil;
}
@end
