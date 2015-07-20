//
//  MainViewController.m
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import "MainViewController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS 4
#define SLIDE_TIMING .25
#define PANEL_WIDTH 60
#define CENTER_TAG 1
#define LEFT_TAG 2
#define RIGHT_TAG 3


@interface MainViewController () <UIGestureRecognizerDelegate, CenterViewControllerDelegate>

@property (nonatomic, strong) CenterViewController *centerViewController;
@property (nonatomic, strong) LeftViewController *leftViewController;
@property (nonatomic, strong) RightViewController *rightViewController;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;
@property (nonatomic, assign) BOOL showingLeft;
@property (nonatomic, assign) BOOL showingRight;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setupView {
    self.centerViewController = [[CenterViewController alloc] initWithNibName:@"CenterViewController" bundle:nil];
    self.centerViewController.view.tag = CENTER_TAG;
    self.centerViewController.delegate = self;
    
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    
    [_centerViewController didMoveToParentViewController:self];
    [self setupGestures];
    
}

- (UIView *)getLeftView
{
    // init view if it doesn't already exist
    if (_leftViewController == nil)
    {
        // this is where you define the view for the left panel
        self.leftViewController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        self.leftViewController.view.tag = LEFT_TAG;
        self.leftViewController.delegate = _centerViewController;
        
        [self.view addSubview:self.leftViewController.view];
        
        [self addChildViewController:_leftViewController];
        [_leftViewController didMoveToParentViewController:self];
        
        _leftViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeft = YES;
    
    // set up view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];
    
    UIView *view = self.leftViewController.view;
    return view;
}

- (UIView *)getRightView
{
    // init view if it doesn't already exist
    if (_rightViewController == nil)
    {
        // this is where you define the view for the right panel
        self.rightViewController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
        self.rightViewController.view.tag = RIGHT_TAG;
        self.rightViewController.delegate = _centerViewController;
        
        [self.view addSubview:self.rightViewController.view];
        
        [self addChildViewController:self.rightViewController];
        [_rightViewController didMoveToParentViewController:self];
        
        _rightViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingRight = YES;
    
    // set up view shadows
    [self showCenterViewWithShadow:YES withOffset:2];
    
    UIView *view = self.rightViewController.view;
    return view;
}

- (void)movePanelRight // to show left panel
{
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             _centerViewController.left.tag = 0;
                         }
                     }];
}

- (void)movePanelLeft{
    UIView *childView = [self getRightView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(-self.view.frame.size.width + PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             _centerViewController.right.tag = 0;
                         }
                     }];
}

- (void)movePanelToOriginalPosition
{
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}

- (void)resetMainView
{
    
    // remove left and right views, and reset variables, if needed
    if (_leftViewController != nil)
    {
        [self.leftViewController.view removeFromSuperview];
        self.leftViewController = nil;
        
        _centerViewController.left.tag = 1;
        self.showingLeft = NO;
    }
    
    if (_rightViewController != nil)
    {
        [self.rightViewController.view removeFromSuperview];
        self.rightViewController = nil;
        
        _centerViewController.right.tag = 1;
        self.showingRight = NO;
    }
    
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
    
}

- (void)setupGestures
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_centerViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender
{
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            if (!_showingRight) {
                childView = [self getLeftView];
            }
        } else {
            if (!_showingLeft) {
                childView = [self getRightView];
            }
            
        }
        // Make sure the view you're working with is front and center.
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeft) {
                [self movePanelRight];
            }  else if (_showingRight) {
                [self movePanelLeft];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        _showPanel = abs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;
        
        // Allow dragging only in x-coordinates by only updating the x-coordinate with translation position.
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        // If you needed to check for a change in direction, you could use this code to do so.
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
}

- (void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset
{
    if (value)
    {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
