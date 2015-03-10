//
//  ERUStringTests.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 25/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+ERUValidation.h"

static NSString *const kERUFloatRegex = @"^(([0-9]*)((\\.)([0-9]*))?)";

@interface ERUStringTests : XCTestCase

@end

@implementation ERUStringTests

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
    XCTAssertTrue([[NSString eru_decimalSeparator] isEqualToString:kERUDefaultDecimalSeparator]);
    [NSString eru_setDecimalSeparator:@"?"];
    XCTAssertFalse([[NSString eru_decimalSeparator] isEqualToString:kERUDefaultDecimalSeparator]);
    XCTAssertTrue([[NSString eru_decimalSeparator] isEqualToString:@"?"]);
}

- (void)testInteger
{
    XCTAssertTrue([@"0" eru_isInteger]);
    XCTAssertTrue([@"123" eru_isInteger]);
    XCTAssertTrue([@"999999" eru_isInteger]);
    XCTAssertTrue([@"-123" eru_isInteger]);
    XCTAssertTrue([@"-999999" eru_isInteger]);
    
    XCTAssertFalse([@"" eru_isInteger]);
    XCTAssertFalse([@" " eru_isInteger]);
    XCTAssertFalse([@"asd" eru_isInteger]);
    XCTAssertFalse([@"a123" eru_isInteger]);
    XCTAssertFalse([@"123a" eru_isInteger]);
    XCTAssertFalse([@"1-23" eru_isInteger]);
    XCTAssertFalse([@"1,23" eru_isInteger]);
}

- (void)testUnsignedInteger
{
    XCTAssertTrue([@"0" eru_isUnsignedInteger]);
    XCTAssertTrue([@"123" eru_isUnsignedInteger]);
    XCTAssertTrue([@"999999" eru_isUnsignedInteger]);
    
    XCTAssertFalse([@"-123" eru_isUnsignedInteger]);
    XCTAssertFalse([@"-999999" eru_isUnsignedInteger]);
    XCTAssertFalse([@"" eru_isUnsignedInteger]);
    XCTAssertFalse([@" " eru_isUnsignedInteger]);
    XCTAssertFalse([@"asd" eru_isUnsignedInteger]);
    XCTAssertFalse([@"a123" eru_isUnsignedInteger]);
    XCTAssertFalse([@"123a" eru_isUnsignedInteger]);
    XCTAssertFalse([@"1-23" eru_isUnsignedInteger]);
    XCTAssertFalse([@"1,23" eru_isUnsignedInteger]);
}

- (void)testFloat
{
    [NSString eru_setDecimalSeparator:@"."];
    
    XCTAssertTrue([@"0" eru_isFloat]);
    XCTAssertTrue([@"123.123" eru_isFloat]);
    XCTAssertTrue([@"999999.2" eru_isFloat]);
    XCTAssertTrue([@"-123" eru_isFloat]);
    XCTAssertTrue([@"-123.22" eru_isFloat]);
    XCTAssertTrue([@"-999999" eru_isFloat]);
    
    XCTAssertFalse([@"" eru_isFloat]);
    XCTAssertFalse([@" " eru_isFloat]);
    XCTAssertFalse([@"asd" eru_isFloat]);
    XCTAssertFalse([@"a123" eru_isFloat]);
    XCTAssertFalse([@"123a" eru_isFloat]);
    XCTAssertFalse([@"1-23" eru_isFloat]);
    XCTAssertFalse([@"1,23" eru_isFloat]);
}

- (void)testUnsignedFloat
{
    [NSString eru_setDecimalSeparator:@"."];
    
    XCTAssertTrue([@"0" eru_isUnsignedFloat]);
    XCTAssertTrue([@"123.123" eru_isUnsignedFloat]);
    XCTAssertTrue([@"999999.2" eru_isUnsignedFloat]);
    
    XCTAssertFalse([@"-123" eru_isUnsignedFloat]);
    XCTAssertFalse([@"-123.22" eru_isUnsignedFloat]);
    XCTAssertFalse([@"-999999" eru_isUnsignedFloat]);
    XCTAssertFalse([@"" eru_isUnsignedFloat]);
    XCTAssertFalse([@" " eru_isUnsignedFloat]);
    XCTAssertFalse([@"asd" eru_isUnsignedFloat]);
    XCTAssertFalse([@"a123" eru_isUnsignedFloat]);
    XCTAssertFalse([@"123a" eru_isUnsignedFloat]);
    XCTAssertFalse([@"-1-23" eru_isUnsignedFloat]);
    XCTAssertFalse([@"1,23" eru_isUnsignedFloat]);
}

- (void)testIsNumeric
{
    XCTAssertTrue([@"0" eru_isNumeric]);
    XCTAssertTrue([@"123" eru_isNumeric]);
    XCTAssertTrue([@"999999" eru_isNumeric]);
    XCTAssertTrue([@"123.123" eru_isNumeric]);
    XCTAssertTrue([@"999999.2" eru_isNumeric]);
    XCTAssertTrue([@"-123" eru_isNumeric]);
    XCTAssertTrue([@"-123.22" eru_isNumeric]);
    XCTAssertTrue([@"-999999" eru_isNumeric]);
    
    XCTAssertFalse([@"" eru_isNumeric]);
    XCTAssertFalse([@" " eru_isNumeric]);
    XCTAssertFalse([@"asd" eru_isNumeric]);
    XCTAssertFalse([@"a123" eru_isNumeric]);
    XCTAssertFalse([@"123a" eru_isNumeric]);
    XCTAssertFalse([@"1-23" eru_isNumeric]);
    XCTAssertFalse([@"1,23" eru_isNumeric]);
}

- (void)testIsLetters
{
    XCTAssertTrue([@"a" eru_isLetters]);
    XCTAssertTrue([@"A" eru_isLetters]);
    XCTAssertTrue([@"CurabiturBlanditTempusPorttitor" eru_isLetters]);
    
    XCTAssertFalse([@"Etiam porta sem malesuada magna mollis euismod." eru_isLetters]);
    XCTAssertFalse([@"CurabiturBlanditTempusPorttitor1" eru_isLetters]);
    XCTAssertFalse([@"123" eru_isLetters]);
    XCTAssertFalse([@"./,?* " eru_isLetters]);
}

- (void)testIsAlphanumeric
{
    XCTAssertTrue([@"a" eru_isAlphanumeric]);
    XCTAssertTrue([@"A" eru_isAlphanumeric]);
    XCTAssertTrue([@"CurabiturBlanditTempusPorttitor" eru_isAlphanumeric]);
    XCTAssertTrue([@"a123" eru_isAlphanumeric]);
    XCTAssertTrue([@"A123" eru_isAlphanumeric]);
    XCTAssertTrue([@"Curabitur123BlanditTempusPorttitor" eru_isAlphanumeric]);
    XCTAssertTrue([@"123" eru_isAlphanumeric]);
    
    XCTAssertFalse([@"Etiam porta sem malesuada magna mollis euismod." eru_isLetters]);
    XCTAssertFalse([@"CurabiturBlanditTempusPorttitor?" eru_isLetters]);
    XCTAssertFalse([@"./,?* " eru_isLetters]);
}

- (void)testEmail
{
    XCTAssertTrue([@"goksel@me.com" eru_isValidEmail]);
    XCTAssertTrue([@"gokselslongmailaddress@somelongdomain.com" eru_isValidEmail]);
    
    XCTAssertFalse([@"gokselslongmailaddress@somelongdomain" eru_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@@somelongdomain.com" eru_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@some/longdomain.com" eru_isValidEmail]);
    XCTAssertFalse([@"gokselslongmailaddress@somelongdomain." eru_isValidEmail]);
    XCTAssertFalse([@"email" eru_isValidEmail]);
}

- (void)testMatchesRegexPattern
{
    XCTAssertTrue([@"0" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertTrue([@"123.123" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertTrue([@"999999.2" eru_matchesRegexPattern:kERUFloatRegex]);
    
    XCTAssertFalse([@"-123" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"-123.22" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"-999999" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@" " eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"asd" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"a123" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"123a" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"-1-23" eru_matchesRegexPattern:kERUFloatRegex]);
    XCTAssertFalse([@"1,23" eru_matchesRegexPattern:kERUFloatRegex]);
}

- (void)testMatchesRegex
{
    XCTAssertTrue([@"0" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertTrue([@"123.123" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertTrue([@"999999.2" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    
    XCTAssertFalse([@"-123" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"-123.22" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"-999999" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@" " eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"asd" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"a123" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"123a" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"-1-23" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
    XCTAssertFalse([@"1,23" eru_matchesRegex:[self regexWithPattern:kERUFloatRegex]]);
}

- (void)testMatchesCharacterSet
{
    NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
    
    XCTAssertTrue([@" " eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertTrue([@"   " eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertTrue([@"            " eru_matchesCharacterSet:whitespaceSet]);
    
    XCTAssertFalse([@"" eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"A " eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"A   " eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"Some sample sentence" eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"." eru_matchesCharacterSet:whitespaceSet]);
    XCTAssertFalse([@"/ . ?" eru_matchesCharacterSet:whitespaceSet]);
}

#pragma mark - Helpers

- (NSRegularExpression *)regexWithPattern:(NSString *)regexPattern
{
    return [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:nil];
}

@end
