//
//  ViewControllerDest.m
//  CustomViewControllerTransition
//
//  Created by wansong on 15/10/1.
//  Copyright © 2015年 self. All rights reserved.
//

#import "ViewControllerDest.h"

@interface ViewControllerDest ()
- (IBAction)popButtonAction:(id)sender;

@end

@implementation ViewControllerDest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)popButtonAction:(id)sender {
  UIViewController *presentingVc = self.presentingViewController;
  [presentingVc dismissViewControllerAnimated:YES
                                   completion:^{
                                     ;
                                   }];
}
@end
