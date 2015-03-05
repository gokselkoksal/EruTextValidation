//
//  RTVStringTests.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 25/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+RTVValidation.h"

static NSString *const kRTVFloatRegex = @"^(([0-9]*)((\\.)([0-9]*))?)";

@interface RTVStringTests : XCTestCase

@end

@implementation RTVStringTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDecimalSeparator
{
    XCTAssertTrue([[NSString rtv_decimalSeparator] isEqualToString:kRTVDefaultDecimalSeparator]);
    [NSString rtv_setDecimalSeparator:@"?"];
    XCTAssertFalse([[NSString rtv_decimalSeparator] isEqualToString:kRTVDefaultDecimalSeparator]);
    XCTAssertTrue([[NSString rtv_decimalSeparator] isEqualToString:@"?"]);
}

- (void)testInteger
{
    XCTAssertTrue([@"0" rtv_isInteger]);
    XCTAssertTrue([@"123" rtv_isInteger]);
    XCTAssertTrue([@"999999" rtv_isInteger]);
    XCTAssertTrue([@"-123" rtv_isInteger]);
    XCTAssertTrue([@"-999999" rtv_isInteger]);
    
    XCTAssertFalse([@"" rtv_isInteger]);
    XCTAssertFalse([@" " rtv_isInteger]);
    XCTAssertFalse([@"asd" rtv_isInteger]);
    XCTAssertFalse([@"a123" rtv_isInteger]);
    XCTAssertFalse([@"123a" rtv_isInteger]);
    XCTAssertFalse([@"1-23" rtv_isInteger]);
    XCTAssertFalse([@"1,23" rtv_isInteger]);
}

- (void)testUnsignedInteger
{
    XCTAssertTrue([@"0" rtv_isUnsignedInteger]);
    XCTAssertTrue([@"123" rtv_isUnsignedInteger]);
    XCTAssertTrue([@"999999" rtv_isUnsignedInteger]);
    
    XCTAssertFalse([@"-123" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"-999999" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"" rtv_isUnsignedInteger]);
    XCTAssertFalse([@" " rtv_isUnsignedInteger]);
    XCTAssertFalse([@"asd" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"a123" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"123a" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"1-23" rtv_isUnsignedInteger]);
    XCTAssertFalse([@"1,23" rtv_isUnsignedInteger]);
}

- (void)testFloat
{
    [NSString rtv_setDecimalSeparator:@"."];
    
    XCTAssertTrue([@"0" rtv_isFloat]);
    XCTAssertTrue([@"123.123" rtv_isFloat]);
    XCTAssertTrue([@"999999.2" rtv_isFloat]);
    XCTAssertTrue([@"-123" rtv_isFloat]);
    XCTAssertTrue([@"-123.22" rtv_isFloat]);
    XCTAssertTrue([@"-999999" rtv_isFloat]);
    
    XCTAssertFalse([@"" rtv_isFloat]);
    XCTAssertFalse([@" " rtv_isFloat]);
    XCTAssertFalse([@"asd" rtv_isFloat]);
    XCTAssertFalse([@"a123" rtv_isFloat]);
    XCTAssertFalse([@"123a" rtv_isFloat]);
    XCTAssertFalse([@"1-23" rtv_isFloat]);
    XCTAssertFalse([@"1,23" rtv_isFloat]);
}

- (void)testUnsignedFloat
{
    [NSString rtv_setDecimalSeparator:@"."];
    
    XCTAssertTrue([@"0" rtv_isUnsignedFloat]);
    XCTAssertTrue([@"123.123" rtv_isUnsignedFloat]);
    XCTAssertTrue([@"999999.2" rtv_isUnsignedFloat]);
    
    XCTAssertFalse([@"-123" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"-123.22" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"-999999" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"" rtv_isUnsignedFloat]);
    XCTAssertFalse([@" " rtv_isUnsignedFloat]);
    XCTAssertFalse([@"asd" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"a123" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"123a" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"-1-23" rtv_isUnsignedFloat]);
    XCTAssertFalse([@"1,23" rtv_isUnsignedFloat]);
}

- (void)testIsNumeric
{
    XCTAssertTrue([@"0" rtv_isNumeric]);
    XCTAssertTrue([@"123" rtv_isNumeric]);
    XCTAssertTrue([@"999999" rtv_isNumeric]);
    XCTAssertTrue([@"123.123" rtv_isNumeric]);
    XCTAssertTrue([@"999999.2" rtv_isNumeric]);
    XCTAssertTrue([@"-123" rtv_isNumeric]);
    XCTAssertTrue([@"-123.22" rtv_isNumeric]);
    XCTAssertTrue([@"-999999" rtv_isNumeric]);
    
    XCTAssertFalse([@"" rtv_isNumeric]);
    XCTAssertFalse([@" " rtv_isNumeric]);
    XCTAssertFalse([@"asd" rtv_isNumeric]);
    XCTAssertFalse([@"a123" rtv_isNumeric]);
    XCTAssertFalse([@"123a" rtv_isNumeric]);
    XCTAssertFalse([@"1-23" rtv_isNumeric]);
    XCTAssertFalse([@"1,23" rtv_isNumeric]);
}

- (void)testIsLetters
{
    XCTAssertTrue([@"a" rtv_isLetters]);
    XCTAssertTrue([@"A" rtv_isLetters]);
    XCTAssertTrue([@"CurabiturBlanditTempusPorttitor" rtv_isLetters]);
    
    XCTAssertFalse([@"Etiam porta sem malesuada magna mollis euismod." rtv_isLetters]);
    XCTAssertFalse([@"CurabiturBlanditTempusPorttitor1" rtv_isLetters]);
    XCTAssertFalse([@"123" rtv_isLetters]);
    XCTAssertFalse([@"./,?* " rtv_isLetters]);
}

- (void)testIsAlphanumeric
{
    XCTAssertTrue([@"a" rtv_isAlphanumeric]);
    XCTAssertTrue([@"A" rtv_isAlphanumeric]);
    XCTAssertTrue([@"CurabiturBlanditTempusPorttitor" rtv_isAlphanumeric]);
    XCTAssertTrue([@"a123" rtv_isAlphanumeric]);
    XCTAssertTrue([@"A123" rtv_isAlphanumeric]);
    XCTAssertTrue([@"Curabitur123BlanditTempusPorttitor" rtv_isAlphanumeric]);
    XCTAssertTrue([@"123" rtv_isAlphanumeric]);
    
    XCTAssertFalse([@"Etiam porta sem malesuada magna mollis euismod." rtv_isLetters]);
    XCTAssertFalse([@"CurabiturBlanditTempusPorttitor?" rtv_isLetters]);
    XCTAssertFalse([@"./,?* " rtv_isLetters]);
}

- (void)testEmail
{
    XCTAssertTrue([@"goksel@me.com" rtv_isValidEmail]);
    XCTAssertTrue([@"gokselslongmailaddress@somelongdomain.com" rtv_isValidEmail]);
    
    XCTAssertFalse([@"gokselslongmailaddress@somelongdomain" rtv_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@@somelongdomain.com" rtv_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@some/longdomain.com" rtv_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@somelongdomain." rtv_isValidEmail]);
    XCTAssertFalse([@"email" rtv_isValidEmail]);
}

- (void)testMatchesRegexPattern
{
    XCTAssertTrue([@"0" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertTrue([@"123.123" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertTrue([@"999999.2" rtv_matchesRegexPattern:kRTVFloatRegex]);
    
    XCTAssertFalse([@"-123" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"-123.22" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"-999999" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@" " rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"asd" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"a123" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"123a" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"-1-23" rtv_matchesRegexPattern:kRTVFloatRegex]);
    XCTAssertFalse([@"1,23" rtv_matchesRegexPattern:kRTVFloatRegex]);
}

- (void)testMatchesRegex
{
    XCTAssertTrue([@"0" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertTrue([@"123.123" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertTrue([@"999999.2" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    
    XCTAssertFalse([@"-123" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"-123.22" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"-999999" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@" " rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"asd" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"a123" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"123a" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"-1-23" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
    XCTAssertFalse([@"1,23" rtv_matchesRegex:[self regexWithPattern:kRTVFloatRegex]]);
}

- (void)testMatchesCharacterSet
{
    NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
    
    XCTAssertTrue([@" " rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertTrue([@"   " rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertTrue([@"            " rtv_matchesCharacterSet:whitespaceSet]);
    
    XCTAssertFalse([@"" rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"A " rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"A   " rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"Some sample sentence" rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"." rtv_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"/ . ?" rtv_matchesCharacterSet:whitespaceSet]);
}

#pragma mark - Helpers

- (NSRegularExpression *)regexWithPattern:(NSString *)regexPattern
{
    return [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
}

@end
