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

@interface SZTextView ()
@property (strong, nonatomic) UITextView *_placeholderTextView;
@end

static NSString * const kPlaceholderKey = @"placeholder";
static NSString * const kFontKey = @"font";
static NSString * const kTextKey = @"text";
static NSString * const kExclusionPathsKey = @"exclusionPaths";
static NSString * const kTextContainerInsetKey = @"textContainerInset";

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

    CGRect frame = self.bounds;
    self._placeholderTextView = [[UITextView alloc] initWithFrame:frame];
    self._placeholderTextView.opaque = NO;
    self._placeholderTextView.backgroundColor = [UIColor clearColor];
    self._placeholderTextView.textColor = [UIColor lightGrayColor];
    self._placeholderTextView.textAlignment = self.textAlignment;
    self._placeholderTextView.editable = NO;
    self._placeholderTextView.scrollEnabled = NO;
    self._placeholderTextView.userInteractionEnabled = NO;
    self._placeholderTextView.font = self.font;
    self._placeholderTextView.isAccessibilityElement = NO;

    if ([self._placeholderTextView respondsToSelector:@selector(setSelectable:)]) {
        self._placeholderTextView.selectable = NO;
    }

    if (HAS_TEXT_CONTAINER) {
        self._placeholderTextView.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
    }

    if (_placeholder) {
        self._placeholderTextView.text = _placeholder;
    }

    [self addSubview:self._placeholderTextView];
    [self sendSubviewToBack:self._placeholderTextView];
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
        [self.textContainer addObserver:self forKeyPath:kExclusionPathsKey
                                options:NSKeyValueObservingOptionNew context:nil];
    }

    if (HAS_TEXT_CONTAINER_INSETS(self)) {
        [self addObserver:self forKeyPath:kTextContainerInsetKey
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
    CGRect frame = self._placeholderTextView.frame;
    frame.size = self.bounds.size;
    self._placeholderTextView.frame = frame;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kPlaceholderKey]) {
        self._placeholderTextView.text = [change valueForKey:NSKeyValueChangeNewKey];
    }
    else if ([keyPath isEqualToString:kFontKey]) {
        self._placeholderTextView.font = [change valueForKey:NSKeyValueChangeNewKey];
    }
    else if ([keyPath isEqualToString:kTextKey]) {
        NSString *newText = [change valueForKey:NSKeyValueChangeNewKey];
        if (newText.length > 0) {
            [self._placeholderTextView removeFromSuperview];
        } else {
            [self addSubview:self._placeholderTextView];
        }
    } else if ([keyPath isEqualToString:kExclusionPathsKey]) {
        self._placeholderTextView.textContainer.exclusionPaths = [change objectForKey:NSKeyValueChangeNewKey];
        [self resizePlaceholderFrame];
    } else if ([keyPath isEqualToString:kTextContainerInsetKey]) {
        NSValue *value = [change objectForKey:NSKeyValueChangeNewKey];
        self._placeholderTextView.textContainerInset = value.UIEdgeInsetsValue;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    self._placeholderTextView.textColor = placeholderTextColor;
}

- (UIColor *)placeholderTextColor
{
    return self._placeholderTextView.textColor;
}

- (void)textDidChange:(NSNotification *)aNotification
{
    if (self.text.length < 1) {
        [self addSubview:self._placeholderTextView];
        [self sendSubviewToBack:self._placeholderTextView];
    } else {
        [self._placeholderTextView removeFromSuperview];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:kPlaceholderKey];
    [self removeObserver:self forKeyPath:kFontKey];
    [self removeObserver:self forKeyPath:kTextKey];

    if (HAS_TEXT_CONTAINER) {
        [self.textContainer removeObserver:self forKeyPath:kExclusionPathsKey];
    }

    if (HAS_TEXT_CONTAINER_INSETS(self)) {
        [self removeObserver:self forKeyPath:kTextContainerInsetKey];
    }
}

@end

