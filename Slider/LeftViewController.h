//
//  LeftViewController.h
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LeftViewControllerDelegate <NSObject>
@required
- (void)menuSelected:(NSInteger)row;
@end

@interface LeftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id<LeftViewControllerDelegate> delegate;


@end
