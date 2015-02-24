//
//  NSString+RTVValidation.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "NSString+RTVValidation.h"

static NSString *const kRegexInteger = @"^([0-9]*)";
static NSString *const kRegexFloatWithoutSeparator = @"^(([0-9]*)((\\%@)([0-9]*))?)";
static NSString *const kMinusSign = @"-";
static NSString *const kDefaultDecimalSeparator = @",";

static NSString *decimalSeparator = nil;

@implementation NSString (RTVValidation)

+ (void)initialize
{
    [super initialize];
    decimalSeparator = kDefaultDecimalSeparator;
}

+ (NSString *)rtv_decimalSeparator
{
    return decimalSeparator;
}

+ (void)rtv_setDecimalSeparator:(NSString *)aDecimalSeparator
{
    decimalSeparator = aDecimalSeparator;
}

+ (NSString *)regexForFloat
{
    return [NSString stringWithFormat:kRegexFloatWithoutSeparator, decimalSeparator];
}

- (BOOL)rtv_isUnsignedInteger
{
    return [self rtv_matchesRegexPattern:kRegexInteger];
}

- (BOOL)rtv_isInteger
{
    BOOL isInteger = [self rtv_isUnsignedInteger];
    
    if (!isInteger && [self hasPrefix:kMinusSign])
    {
        isInteger = [[self substringFromIndex:1] rtv_isUnsignedInteger];
    }
    
    return isInteger;
}

- (BOOL)rtv_isUnsignedFloat
{
    return [self rtv_matchesRegexPattern:[[self class] regexForFloat]];
}

- (BOOL)rtv_isFloat
{
    BOOL isFloat = [self rtv_isUnsignedFloat];
    
    if (!isFloat && [self hasPrefix:kMinusSign])
    {
        isFloat = [[self substringFromIndex:1] rtv_isUnsignedFloat];
    }
    
    return isFloat;
}

- (BOOL)rtv_isNumeric
{
    return [self rtv_isInteger] || [self rtv_isFloat];
}

- (BOOL)rtv_isAlphanumeric
{
    return [self rtv_matchesCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
}

- (BOOL)rtv_isLetters
{
    return [self rtv_matchesCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (BOOL)rtv_isEmpty
{
    return [self length] == 0;
}

- (BOOL)rtv_matchesCharacterSet:(NSCharacterSet *)characterSet
{
    if ([self rtv_isEmpty])
    {
        return NO;
    }
    
    return [[self stringByTrimmingCharactersInSet:characterSet] length] == 0;
}

- (BOOL)rtv_matchesRegexPattern:(NSString *)regexPattern
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    return !error ? [self rtv_matchesRegex:regex] : NO;
}

- (BOOL)rtv_matchesRegex:(NSRegularExpression *)regex
{
    if ([self rtv_isEmpty])
    {
        return NO;
    }
    
    NSRange stringRange = NSMakeRange(0, [self length]);
    NSRange matchRange = [regex rangeOfFirstMatchInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    return matchRange.location == stringRange.location && matchRange.length == stringRange.length;
}

@end