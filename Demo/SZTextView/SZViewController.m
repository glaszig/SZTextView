//
//  SZViewController.m
//  SZTextView
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import "SZViewController.h"
#import "SZTableViewCell.h"

@interface SZViewController () <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation SZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGFloat inset = 15.0;
    // ios 7
    if ([UITextView instancesRespondToSelector:@selector(setTextContainerInset:)]) {
        self.textView.textContainerInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    } else {
        self.textView.contentInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    SZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    cell.textView.text = @"set from table view delegate";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
