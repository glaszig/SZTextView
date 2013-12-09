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

- (void)testPlaceholderTextViewSuperViewAfterInit
{
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

@end
