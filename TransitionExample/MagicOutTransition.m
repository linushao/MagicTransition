//
//  MagicOutTransition.m
//  TransitionExample
//
//  Created by AceWei on 16/3/15.
//  Copyright © 2016年 Dative Studios. All rights reserved.
//

#import "MagicOutTransition.h"
#import "DSLFirstViewController.h"
#import "DSLSecondViewController.h"
#import "DSLThingCell.h"

@interface MagicOutTransition ()<UIViewControllerAnimatedTransitioning>

@end

@implementation MagicOutTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSLSecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DSLFirstViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    DSLThingCell *cell = (DSLThingCell *)[toVC.collectionView cellForItemAtIndexPath:fromVC.cellIndex];
    
    
    UIView *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    
    fromVC.imageView.hidden = YES;
    cell.imageView.hidden = YES;
   
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    toVC.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}


@end
