//
//  CenterViewController.m
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UITextView *menuDescription;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

@implementation CenterViewController{
    NSArray *menu;
    NSArray *imageFile;
    NSString *description;
    NSString *msg;
    NSString *email;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = [NSArray arrayWithObjects:@"Electrical and Electronics Engineering Institute", @"The Institute", @"Academics", @"Research", @"Faculty", @"Students", nil];
    imageFile = [NSArray arrayWithObjects:@"home.png", @"insti.jpeg", @"acad.jpg", @"research.jpg", @"faculty.png", @"students.jpg", nil];
    description = @"The UP-EEEI is the premier academic institution in the field of electrical and electronics engineering in the Philippines. The undergraduate program in Electrical Engineering (EE), Electronics and Communications Engineering (ECE) and Computer Engineering (CoE) provide a strong background in fundamentals with an emphasis on the development of analytical and creative abilities aimed at problem solving and innovation. Lectures and discussion classes are founded on solid appreciation of fundamentals and exposure to new and emerging technologies. These are accompanied by the most advanced instructional and research hands-on laboratories in the country that reinforce learning through experimentation. In 1993, the UP-EEEI (then the Department of Electrical Engineering) was the first unit in the College of Engineering to require a senior undergraduate capstone project, which was previously an elective. The '198', as it is fondly called in EEE-speak, is an institution that trains students in the practice of good engineering judgment, principles of scientific investigation, teamwork, communication skills and proper time management. In recent years, an increasing number of these “198” projects conducted in our research laboratories have even been pursued beyond the lab and into commercial prototypes that help spur local development of technology.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnMoveRight:(id)sender
{
    UIBarButtonItem *menuBtn = sender;
    switch (menuBtn.tag) {
        case 0: {
            [_delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [_delegate movePanelRight];
            break;
        }
            
        default:
            break;
    }
}

- (void)menuSelected:(NSInteger)row{
    
    [_delegate movePanelToOriginalPosition];
    
    self.mainImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageFile objectAtIndex:row]]];
    self.menuTitle.text = [NSString stringWithFormat:@"%@", [menu objectAtIndex:row]];
    self.menuDescription.text = description;
    self.menuDescription.textAlignment = NSTextAlignmentJustified;
    self.menuDescription.font = [UIFont fontWithName:@"Futura" size:14.0];
    
}

- (void)msgSent:(NSString *)msgSent email:(NSString *)emailSent{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message Sent!"
                                                        message:@"Thank you for your comment/inquiry! We'll get back to you as soon as possible." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    [_delegate movePanelToOriginalPosition];
    self.mainImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageFile objectAtIndex:0]]];
    self.menuTitle.text = [NSString stringWithFormat:@"%@", [menu objectAtIndex:0]];
    self.menuDescription.text = description;
    self.menuDescription.textAlignment = NSTextAlignmentJustified;
    self.menuDescription.font = [UIFont fontWithName:@"Futura" size:14.0];

}


- (IBAction)btnMoveLeft:(id)sender
{
    UIBarButtonItem *compose = sender;
    switch (compose.tag) {
        case 0: {
            [_delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [_delegate movePanelLeft];
            break;
        }
            
        default:
            break;
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
