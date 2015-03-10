//
//  NSString+ERUValidation.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "NSString+ERUValidation.h"

static NSString *const kMinusSign = @"-";
static NSString *const kRegexInteger = @"^([0-9]*)";
static NSString *const kRegexFloatWithoutSeparator = @"^(([0-9]*)((\\%@)([0-9]*))?)";
static NSString *const kRegexEmail =
@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";

static NSString *decimalSeparator = nil;

@implementation NSString (ERUValidation)

+ (NSString *)eru_decimalSeparator
{
    if (!decimalSeparator)
    {
        decimalSeparator = kERUDefaultDecimalSeparator;
    }
    
    return decimalSeparator;
}

+ (void)eru_setDecimalSeparator:(NSString *)aDecimalSeparator
{
    decimalSeparator = aDecimalSeparator;
}

- (BOOL)eru_isUnsignedInteger
{
    return [self eru_matchesRegexPattern:kRegexInteger];
}

- (BOOL)eru_isInteger
{
    BOOL isInteger = [self eru_isUnsignedInteger];
    
    if (!isInteger && [self hasPrefix:kMinusSign])
    {
        isInteger = [[self substringFromIndex:1] eru_isUnsignedInteger];
    }
    
    return isInteger;
}

- (BOOL)eru_isUnsignedFloat
{
    return [self eru_matchesRegexPattern:[[self class] regexForFloat]];
}

- (BOOL)eru_isFloat
{
    BOOL isFloat = [self eru_isUnsignedFloat];
    
    if (!isFloat && [self hasPrefix:kMinusSign])
    {
        isFloat = [[self substringFromIndex:1] eru_isUnsignedFloat];
    }
    
    return isFloat;
}

- (BOOL)eru_isNumeric
{
    return [self eru_isInteger] || [self eru_isFloat];
}

- (BOOL)eru_isAlphanumeric
{
    return [self eru_matchesCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
}

- (BOOL)eru_isLetters
{
    return [self eru_matchesCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (BOOL)eru_matchesCharacterSet:(NSCharacterSet *)characterSet
{
    if ([self length] == 0)
    {
        return NO;
    }
    
    return [[self stringByTrimmingCharactersInSet:characterSet] length] == 0;
}

- (BOOL)eru_matchesRegexPattern:(NSString *)regexPattern
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    return !error ? [self eru_matchesRegex:regex] : NO;
}

- (BOOL)eru_matchesRegex:(NSRegularExpression *)regex
{
    if ([self length] == 0)
    {
        return NO;
    }
    
    NSRange stringRange = NSMakeRange(0, [self length]);
    NSRange matchRange = [regex rangeOfFirstMatchInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    return matchRange.location == stringRange.location && matchRange.length == stringRange.length;
}

- (BOOL)eru_isValidEmail
{
    return [self eru_matchesRegexPattern:kRegexEmail];
}

#pragma mark - Helpers

+ (NSString *)regexForFloat
{
    return [NSString stringWithFormat:kRegexFloatWithoutSeparator, decimalSeparator];
}

@end
