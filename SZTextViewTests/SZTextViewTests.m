//
//  SZTextViewTests.m
//  SZTextViewTests
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import "SZTextViewTests.h"
#import "SZTextView.h"

@interface SZTextViewTests () {
    SZTextView *textView;
    UITextView *placeholderTextView;
}

@end

@implementation SZTextViewTests

- (void)setUp
{
    [super setUp];
    textView = [[SZTextView alloc] init];
    placeholderTextView = [textView valueForKey:@"_placeholderTextView"];
}

- (void)tearDown
{
    placeholderTextView = nil;
    textView = nil;
    [super tearDown];
}

- (void)testPlaceholderTextViewSuperViewUponBecomingFirstResponder
{
    [textView becomeFirstResponder];

    STAssertNotNil(placeholderTextView.superview, @"should initially have a superview");
    STAssertEqualObjects(placeholderTextView.superview, textView, @"placeholder superview should be the text view itself");
}

- (void)testPlaceholderTextViewChangeSuperviewAfterSetText
{
    textView.text = @"Foobar";
    STAssertNil(placeholderTextView.superview, @"Placeholder should not have a superview if the containing text view has input");

    textView.text = nil;
    NSLog(@"superview: %@", placeholderTextView.superview);
    STAssertNotNil(placeholderTextView.superview, @"Placeholder should have a superview if the containing text view has no input");
}

- (void)testPlaceholderTextViewShouldInheritFont
{
    textView.font = [UIFont systemFontOfSize:20.0];
    STAssertEqualObjects(placeholderTextView.font, textView.font, @"label and text view should have equal fonts");
    
}

- (void)testAttributedPlaceholderText
{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"SZTextView"];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,2)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2,4)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(6,4)];

    textView.attributedPlaceholder = placeholder;
    STAssertEqualObjects(textView.attributedPlaceholder.string, @"SZTextView", @"-attributedPlaceholder string should be set");
    STAssertEqualObjects(textView.placeholder, @"SZTextView", @"-placeholder should return a non-attributed copy of -attributedPlacholder");

    textView.placeholder = @"AnotherPlaceholder";
    STAssertEqualObjects(textView.attributedPlaceholder.string, @"AnotherPlaceholder", @"setting a non-attributed placeholder after setting an attributed placholder should copy the text");
}

- (void)testNonAttributedPlaceholderText
{
    textView.placeholder = @"SZTextView";

    STAssertEqualObjects(textView.placeholder, @"SZTextView", @"-placeholder should be set");
    STAssertEqualObjects(textView.attributedPlaceholder.string, @"SZTextView", @"-attributedPlaceholder should equal -placeholder");
}

@end
