//
//  PanInteractiveTransition.h
//  TransitionExample
//
//  Created by AceWei on 16/3/15.
//  Copyright © 2016年 Dative Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 *  很重要的参数，没有这个按nav的goback按钮没用
 */
@property(nonatomic,assign)BOOL interacting;

- (void)panToDismiss:(UIViewController *)viewcontroller;

@end
