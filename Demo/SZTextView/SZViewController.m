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

    [[SZTextView appearance] setPlaceholderTextColor:[UIColor lightGrayColor]];

    CGFloat inset = 15.0;
    // ios 7
    if ([UITextView instancesRespondToSelector:@selector(setTextContainerInset:)]) {
        self.textView.textContainerInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    } else {
        self.textView.contentInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    }

    self.textView.placeholder = @"Enter lorem ipsum here weofi ahöslfawoeö color. Dolor sit amet multiple.";
    self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
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
