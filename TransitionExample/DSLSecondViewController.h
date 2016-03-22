//
//  DSLSecondViewController.h
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

@class DSLThing;


@interface DSLSecondViewController : UIViewController

@property (nonatomic, strong) DSLThing *thing;

@property NSIndexPath *cellIndex;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
