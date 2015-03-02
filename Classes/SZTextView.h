//
//  SZTextView.h
//  SZTextView
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface SZTextView : UITextView

@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) IBInspectable UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end
