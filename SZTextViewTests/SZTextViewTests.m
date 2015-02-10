//
//  SZTextViewTests.m
//  SZTextViewTests
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SZTextView.h"

@interface SZTextViewTests : XCTestCase
{
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

    XCTAssertNotNil(placeholderTextView.superview, @"should initially have a superview");
    XCTAssertEqualObjects(placeholderTextView.superview, textView, @"placeholder superview should be the text view itself");
}

- (void)testPlaceholderTextViewChangeSuperviewAfterSetText
{
    textView.text = @"Foobar";
    XCTAssertNil(placeholderTextView.superview, @"Placeholder should not have a superview if the containing text view has input");

    textView.text = nil;
    NSLog(@"superview: %@", placeholderTextView.superview);
    XCTAssertNotNil(placeholderTextView.superview, @"Placeholder should have a superview if the containing text view has no input");
}

- (void)testPlaceholderTextViewShouldInheritFont
{
    textView.font = [UIFont systemFontOfSize:20.0];
    XCTAssertEqualObjects(placeholderTextView.font, textView.font, @"label and text view should have equal fonts");
    
}

- (void)testAttributedPlaceholderText
{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"SZTextView"];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,2)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2,4)];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(6,4)];

    textView.attributedPlaceholder = placeholder;
    XCTAssertEqualObjects(textView.attributedPlaceholder.string, @"SZTextView", @"-attributedPlaceholder string should be set");
    XCTAssertEqualObjects(textView.placeholder, @"SZTextView", @"-placeholder should return a non-attributed copy of -attributedPlacholder");

    textView.placeholder = @"AnotherPlaceholder";
    XCTAssertEqualObjects(textView.attributedPlaceholder.string, @"AnotherPlaceholder", @"setting a non-attributed placeholder after setting an attributed placholder should copy the text");
}

- (void)testCopiesAttributedPlaceholder
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blueColor]};
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:@"SZTextView"
                                                                                      attributes:attributes];

    textView.attributedPlaceholder = mutableString;
    [mutableString setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                           range:NSMakeRange(0, mutableString.length)];

    XCTAssertFalse([textView.attributedPlaceholder isEqualToAttributedString:mutableString], @"attributed placeholder should get copied");
}

- (void)testAttributedTextSetterTogglesVisibility
{
    textView.text = @"foo";
    textView.attributedText = [[NSAttributedString alloc] initWithString:@""];
    XCTAssertNotNil(placeholderTextView.superview, @"placeholder text view should have superview, be visible");

    textView.text = @"foo";
    textView.attributedText = [[NSAttributedString alloc] initWithString:@"foo bar"];
    XCTAssertNil(placeholderTextView.superview, @"placeholder text view should not have superview, be hidden");
}

- (void)testCopiesPlaceholder
{
    NSMutableString *mutableString = [@"SZTextView" mutableCopy];
    textView.placeholder = mutableString;

    [mutableString appendString:@"mutated"];

    XCTAssertEqualObjects(textView.placeholder, @"SZTextView");
}

- (void)testNonAttributedPlaceholderText
{
    textView.placeholder = @"SZTextView";

    XCTAssertEqualObjects(textView.placeholder, @"SZTextView", @"-placeholder should be set");
    XCTAssertEqualObjects(textView.attributedPlaceholder.string, @"SZTextView", @"-attributedPlaceholder should equal -placeholder");
}

@end
