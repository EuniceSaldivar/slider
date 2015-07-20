//
//  RightViewController.h
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RightViewControllerDelegate <NSObject>
@required
- (void)msgSent:(NSString *)msgSent email:(NSString *)emailSent;
@end

@interface RightViewController : UIViewController

@property (nonatomic, assign) id<RightViewControllerDelegate> delegate;


@end
