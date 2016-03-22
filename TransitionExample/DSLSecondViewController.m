//
//  DSLSecondViewController.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "DSLSecondViewController.h"

#import "DSLThing.h"

#import "MagicOutTransition.h"
#import "DSLFirstViewController.h"

#import "PanInteractiveTransition.h"
#import "MagicMoveTransition.h"

@interface DSLSecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)PanInteractiveTransition *panInteractiveTransition;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end


@implementation DSLSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.thing.title;
    self.imageView.image = self.thing.image;
    
    self.navigationController.delegate = self;
    
    
    _panInteractiveTransition = [PanInteractiveTransition new];
    [_panInteractiveTransition panToDismiss:self];
    
    
//    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
//    //设置从什么边界滑入
//    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
//    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
    
//    UIPanGestureRecognizer *edgePanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
//    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}


-(void)edgePanGesture:(UIPanGestureRecognizer *)gesture{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGPoint translation = [gesture translationInView:self.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:{
            //1
            CGFloat percent = (translation.y/300) <= 1 ? (translation.y/300):1;
            [self.percentDrivenTransition updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //2
            if (gesture.state == UIGestureRecognizerStateCancelled) {
                [self.percentDrivenTransition cancelInteractiveTransition];
            }else{
                [self.percentDrivenTransition finishInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
    
}



#pragma mark - TransitioningDelegate /system

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    NSLog(@"toVC class:%@",[toVC class]);
    if ([toVC isKindOfClass:[DSLFirstViewController class]]) {
        return [MagicOutTransition new];
    } else {
        return nil;
    }
}



- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
//    NSLog(@"animationController class:%@",[animationController class]);
//    if ([animationController isKindOfClass:[MagicOutTransition class]]) {
////        return self.percentDrivenTransition;
//        return self.panInteractiveTransition;
//    }else{
//        return nil;
//    }
    return self.panInteractiveTransition.interacting ? self.panInteractiveTransition : nil;
}




@end
