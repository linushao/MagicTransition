//
//  MagicMoveTransition.m
//  TransitionExample
//
//  Created by AceWei on 16/3/15.
//  Copyright © 2016年 Dative Studios. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "DSLFirstViewController.h"
#import "DSLSecondViewController.h"
#import "DSLThingCell.h"

@interface MagicMoveTransition ()<UIViewControllerAnimatedTransitioning>

@end

@implementation MagicMoveTransition


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    DSLSecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    DSLFirstViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    DSLThingCell *cell = (DSLThingCell *)[fromVC.collectionView cellForItemAtIndexPath:_cellIndex];
    
//    DSLThingCell *cell =(DSLThingCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    
    
    
    
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
//        [containerView setNeedsLayout];
        toVC.view.alpha = 1;
        snapShotView.frame = toVC.imageView.frame;
    } completion:^(BOOL finished) {
//        NSLog(@"count:%ld",self.cellRow);
        cell.imageView.hidden = NO;
        toVC.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}


@end
