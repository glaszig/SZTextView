//
//  SZTextView.m
//  SZTextView
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import "SZTextView.h"

#define HAS_TEXT_CONTAINER [self respondsToSelector:@selector(textContainer)]
#define HAS_TEXT_CONTAINER_INSETS(x) [(x) respondsToSelector:@selector(textContainerInset)]
#define Y_PADDING (HAS_TEXT_CONTAINER_INSETS(self) ? 0.0f : kUITextViewPadding)
#define X_PADDING (HAS_TEXT_CONTAINER_INSETS(self) ? 4.0f : kUITextViewPadding)

@interface SZTextView ()
@property (strong, nonatomic) UITextView *_placeholderLabel;
@end

static NSString *kPlaceholderKey = @"placeholder";
static NSString *kFontKey = @"font";
static NSString *kTextKey = @"text";
static NSString *kExclusionPaths = @"exclusionPaths";
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
    
    CGRect frame = CGRectMake(X_PADDING, Y_PADDING, 0, 0);
    self._placeholderLabel = [[UITextView alloc] initWithFrame:frame];
    self._placeholderLabel.opaque = NO;
    self._placeholderLabel.backgroundColor = [UIColor clearColor];
    self._placeholderLabel.textColor = [UIColor grayColor];
    self._placeholderLabel.textAlignment = self.textAlignment;
    self._placeholderLabel.textContainerInset = UIEdgeInsetsZero;
    self._placeholderLabel.editable = NO;
    self._placeholderLabel.selectable = NO;
    self._placeholderLabel.scrollEnabled = NO;
    self._placeholderLabel.userInteractionEnabled = NO;
    self._placeholderLabel.font = self.font;
    
    if (HAS_TEXT_CONTAINER) {
        self._placeholderLabel.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
    }
    
    if (_placeholder) {
        self._placeholderLabel.text = _placeholder;
    }
    
    [self addSubview:self._placeholderLabel];
    self.clipsToBounds = YES;

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
    
    if (HAS_TEXT_CONTAINER) {
        [self.textContainer addObserver:self forKeyPath:kExclusionPaths
                                options:NSKeyValueObservingOptionNew context:nil];
    }

}

- (void)setPlaceholder:(NSString *)placeholderText
{
    _placeholder = placeholderText;
    [self resizePlaceholderFrame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self resizePlaceholderFrame];
}

- (void)resizePlaceholderFrame
{
    UIEdgeInsets inset;
    
    if (HAS_TEXT_CONTAINER_INSETS(self)) {
        inset = self.textContainerInset;
    }
    else {
        inset = self.contentInset;
    }
    
    CGRect frame = self._placeholderLabel.frame;
    
    // the width needs to be limited to the text view's width
    // to prevent the label text from bleeding off
    frame.size.width = self.bounds.size.width;
    frame.size.width -= 2 * X_PADDING + inset.right + inset.left;

    CGSize labelSize = [_placeholder sizeWithFont:self._placeholderLabel.font
                                constrainedToSize:CGSizeMake(frame.size.width, 1000)
                                    lineBreakMode:NSLineBreakByWordWrapping];
    
    if (HAS_TEXT_CONTAINER) {
        NSLayoutManager * layoutManager = self._placeholderLabel.layoutManager;
        [layoutManager glyphRangeForTextContainer:self._placeholderLabel.textContainer];
        CGFloat height = [layoutManager usedRectForTextContainer:self._placeholderLabel.textContainer].size.height;
        
        labelSize.height = height;
    }
    
    
    frame.size.height = labelSize.height;
    
    if (HAS_TEXT_CONTAINER_INSETS(self)) {
        frame.origin.y = Y_PADDING + inset.top;
        frame.origin.x = X_PADDING + inset.left;
    }
    
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
    } else if ([keyPath isEqualToString:kExclusionPaths]) {
        self._placeholderLabel.textContainer.exclusionPaths = [change objectForKey:NSKeyValueChangeNewKey];
        [self resizePlaceholderFrame];
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
    [self removeObserver:self forKeyPath:kExclusionPaths];
}

@end

