//
//  SZTextView.m
//  SZTextView
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import "SZTextView.h"

@interface SZTextView ()
@property (strong, nonatomic) UILabel *_placeholderLabel;
@end

static NSString *kPlaceholderKey = @"placeholder";
static NSString *kFontKey = @"font";
static NSString *kTextKey = @"text";
static float kUITextViewPadding = 8.0;

@implementation SZTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    // the label which displays the placeholder
    // needs to inherit some properties from its parent text view

    // account for standard UITextViewPadding
    CGRect frame = CGRectMake(kUITextViewPadding, kUITextViewPadding, 0, 0);
    self._placeholderLabel = [[UILabel alloc] initWithFrame:frame];
    self._placeholderLabel.opaque = NO;
    self._placeholderLabel.backgroundColor = [UIColor clearColor];
    self._placeholderLabel.textColor = [UIColor grayColor];
    self._placeholderLabel.textAlignment = self.textAlignment;
    self._placeholderLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self._placeholderLabel.font = self.font;
    self._placeholderLabel.text = self.placeholder;
    [self._placeholderLabel sizeToFit];
    [self addSubview:self._placeholderLabel];

    // some observations
    NSNotificationCenter *defaultCenter;
    defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(textDidChange:)
                          name:UITextViewTextDidChangeNotification object:self];

    [self addObserver:self forKeyPath:kPlaceholderKey
              options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kFontKey
              options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kTextKey
              options:NSKeyValueObservingOptionNew context:nil];

}

- (void)layoutSubviews
{
    [super layoutSubviews];

    UIEdgeInsets inset = self.contentInset;
    CGRect frame = self._placeholderLabel.frame;
    // the width needs to be limited to the text view's width
    // to prevent the label text from bleeding off
    frame.size.width = self.bounds.size.width;
    frame.size.width-= kUITextViewPadding + inset.right + inset.left;
    self._placeholderLabel.frame = frame;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kPlaceholderKey]) {
        self._placeholderLabel.text = [change valueForKey:NSKeyValueChangeNewKey];
        [self._placeholderLabel sizeToFit];
    }
    else if ([keyPath isEqualToString:kFontKey]) {
        self._placeholderLabel.font = [change valueForKey:NSKeyValueChangeNewKey];
        [self._placeholderLabel sizeToFit];
    }
    else if ([keyPath isEqualToString:kTextKey]) {
        NSString *newText = [change valueForKey:NSKeyValueChangeNewKey];
        if (newText.length > 0) {
            [self._placeholderLabel removeFromSuperview];
        } else {
            [self addSubview:self._placeholderLabel];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    self._placeholderLabel.textColor = placeholderTextColor;
}

- (UIColor *)placeholderTextColor
{
    return self._placeholderLabel.textColor;
}

- (void)textDidChange:(NSNotification *)aNotification
{
    if (self.text.length < 1) {
        [self addSubview:self._placeholderLabel];
        [self sendSubviewToBack:self._placeholderLabel];
    } else {
        [self._placeholderLabel removeFromSuperview];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:kPlaceholderKey];
    [self removeObserver:self forKeyPath:kFontKey];
    [self removeObserver:self forKeyPath:kTextKey];
}

@end
