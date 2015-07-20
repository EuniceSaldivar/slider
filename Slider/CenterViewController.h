//
//  CenterViewController.h
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import "LeftViewController.h"
#import "RightViewController.h"

@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end



@interface CenterViewController : UIViewController <LeftViewControllerDelegate, RightViewControllerDelegate>

@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *left;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *right;

@end
