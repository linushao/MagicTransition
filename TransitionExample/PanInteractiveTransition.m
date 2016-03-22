//
//  PanInteractiveTransition.m
//  TransitionExample
//
//  Created by AceWei on 16/3/15.
//  Copyright © 2016年 Dative Studios. All rights reserved.
//

#import "PanInteractiveTransition.h"
#import "DSLSecondViewController.h"

@interface PanInteractiveTransition ()

@property(nonatomic,strong)DSLSecondViewController *fromVC;

@end

@implementation PanInteractiveTransition

-(void)panToDismiss:(UIViewController *)viewcontroller;
{
    _fromVC = viewcontroller;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [_fromVC.view addGestureRecognizer:pan];
}


#pragma mark -panGestureAction
-(void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [gesture translationInView:_fromVC.view].x / _fromVC.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    
    switch (gesture.state) {
        //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
        case UIGestureRecognizerStateBegan:
            self.interacting =  YES;
            [_fromVC.navigationController popViewControllerAnimated:YES];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
            [self updateInteractiveTransition:progress];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
            self.interacting = NO;
            if (progress > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}


-(void)logPoint:(CGPoint)point
{
    NSLog(@"x:%f, y:%f",point.x, point.y);
}



@end
