//
//  SZTableViewCell.h
//  SZTextView
//
//  Created by glaszig on 10.02.15.
//  Copyright (c) 2015 glaszig. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZTextView;

@interface SZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SZTextView *textView;
@end
