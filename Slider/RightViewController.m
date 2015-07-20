//
//  RightViewController.m
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *msg;

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPressed:(id)sender{
    if ((self.email.text.length == 0) || (self.msg.text.length == 0)) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:@"All fields are required." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        NSString *string = [NSString stringWithFormat:@"%@ : %@\n", self.email.text, self.msg.text];
        NSString *path = @"file:///Users/macbookpro/Desktop/JD/Slider/messageFile.txt";
        //save content to the documents directory
        /*[content writeToFile:@"file:///Users/macbookpro/Desktop/JD/Slider/messageFile.txt"
                  atomically:NO
                    encoding:NSStringEncodingConversionAllowLossy
                       error:nil];
        */
        
        NSOutputStream *stream = [[NSOutputStream alloc] initToFileAtPath:path append:YES];
        [stream open];
        // Make NSData object from string:
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        // Write data to output file:
        [stream write:data.bytes maxLength:data.length];
        [stream close];
        
        
    [_delegate msgSent:[NSString stringWithFormat:@"%@", self.msg.text] email:[NSString stringWithFormat:@"%@", self.email.text]];
    }
    //NSLog(@"email:%@ msg:%@", self.email.text, self.msg.text);
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
