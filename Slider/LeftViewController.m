//
//  LeftViewController.m
//  Slider
//
//  Created by Eunice Saldivar on 7/16/15.
//  Copyright (c) 2015 jumpdigital. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController{
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = [NSArray arrayWithObjects:@"Home", @"The Institute", @"Academics", @"Research", @"Faculty", @"Students", nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [menu count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableID = @"tableMenu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableID];
    }
    
    UIFont *font = [UIFont fontWithName:@"Futura" size:20.0];
    cell.textLabel.font = font;
    cell.textLabel.text = [menu objectAtIndex:indexPath.row];
    cell.textLabel.frame = CGRectMake(100.0f, 40.0f, 200.0f, 30.0f);
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected:%lu", indexPath.row);
    [_delegate menuSelected:indexPath.row];
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
