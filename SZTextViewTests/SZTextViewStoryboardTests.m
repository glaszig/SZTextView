//
//  SZTextViewTests.m
//  SZTextViewTests
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 glaszig. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SZTextView.h"

@interface SZTextViewStoryboardTests : XCTestCase
{
    SZTextView *textView;
    UITextView *placeholderTextView;
}
@end

@implementation SZTextViewStoryboardTests

- (void)setUp
{
    [super setUp];
    UIWindow *keyWindow = [UIApplication valueForKeyPath:@"sharedApplication.delegate.window"];
    textView = [keyWindow.rootViewController valueForKey:@"textView"];
    NSParameterAssert(textView);
    placeholderTextView = [textView valueForKey:@"_placeholderTextView"];
    NSParameterAssert(textView);
}

- (void)tearDown
{
    placeholderTextView = nil;
    textView = nil;
    [super tearDown];
}

- (void)testPlaceholderColor {
    XCTAssertEqualObjects(placeholderTextView.textColor, [UIColor colorWithRed:0.0f
                                                                         green:0.0f
                                                                          blue:0.0f
                                                                         alpha:0.5f], @"should be set in storyboard");
}

- (void)testPlaceholderText
{
    XCTAssertEqualObjects(placeholderTextView.text, @"Enter lorem ipsum here weofi ahöslfawoeö color. Dolor sit amet multiple.", @"should be set in storyboard");
}

- (void)testPlaceholderFont
{
    XCTAssertEqualObjects(placeholderTextView.font, textView.font, @"label and text view should have equal fonts");
}

- (void)testTextFont
{
    XCTAssertEqualObjects(textView.font, [UIFont fontWithName:@"HelveticaNeue-Light" size:18], @"should be set in storyboard");
}

- (void)testTextAlignment
{
    textView.textAlignment = NSTextAlignmentCenter;
    XCTAssertEqual(placeholderTextView.textAlignment, NSTextAlignmentCenter, @"textAlignment should be in sync");
}

@end
