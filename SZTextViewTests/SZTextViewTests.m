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
    UILabel *placeholderLabel;
}

@end

@implementation SZTextViewTests

- (void)setUp
{
    [super setUp];
    textView = [[SZTextView alloc] init];
    placeholderLabel = [textView valueForKey:@"_placeholderLabel"];
}

- (void)tearDown
{
    placeholderLabel = nil;
    textView = nil;
    [super tearDown];
}

- (void)testPlaceholderLabelSuperViewAfterInit
{
    STAssertNotNil(placeholderLabel.superview, @"should initially have a superview");
    STAssertEqualObjects(placeholderLabel.superview, textView, @"placeholder superview should be the text view itself");
}

- (void)testPlaceholderLabelChangeSuperviewAfterSetText
{
    textView.text = @"Foobar";
    STAssertNil(placeholderLabel.superview, nil);

    textView.text = nil;
    STAssertNotNil(placeholderLabel.superview, nil);
}

- (void)testPlaceholderLabelShouldInheritFont
{
    textView.font = [UIFont systemFontOfSize:20.0];
    STAssertEqualObjects(placeholderLabel.font, textView.font, @"label and text view should have equal fonts");
    
}

@end
