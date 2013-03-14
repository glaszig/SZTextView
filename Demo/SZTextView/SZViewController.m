//
//  SZViewController.m
//  SZTextView
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import "SZViewController.h"

@interface SZViewController () <UITextViewDelegate>

@end

@implementation SZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.placeholder = @"Enter lorem ipsum here";
    self.textView.placeholderTextColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    self.textView.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView
{
//    [textView resignFirstResponder];
}
@end
