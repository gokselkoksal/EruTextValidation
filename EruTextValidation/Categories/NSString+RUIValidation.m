//
//  NSString+RUIValidation.h
//  EruUIKit
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "NSString+RUIValidation.h"

static NSString *const kRegexInteger = @"^([0-9]*)";
static NSString *const kRegexFloatWithoutSeparator = @"^(([0-9]*)((\\%@)([0-9]*))?)";
static NSString *const kMinusSign = @"-";
static NSString *const kDefaultDecimalSeparator = @",";

static NSString *decimalSeparator = nil;

@implementation NSString (RUIValidation)

+ (void)initialize
{
    [super initialize];
    decimalSeparator = kDefaultDecimalSeparator;
}

+ (NSString *)rui_decimalSeparator
{
    return decimalSeparator;
}

+ (void)rui_setDecimalSeparator:(NSString *)aDecimalSeparator
{
    decimalSeparator = aDecimalSeparator;
}

+ (NSString *)regexForFloat
{
    return [NSString stringWithFormat:kRegexFloatWithoutSeparator, decimalSeparator];
}

- (BOOL)rui_isUnsignedInteger
{
    return [self rui_matchesRegexPattern:kRegexInteger];
}

- (BOOL)rui_isInteger
{
    BOOL isInteger = [self rui_isUnsignedInteger];
    
    if (!isInteger && [self hasPrefix:kMinusSign])
    {
        isInteger = [[self substringFromIndex:1] rui_isUnsignedInteger];
    }
    
    return isInteger;
}

- (BOOL)rui_isUnsignedFloat
{
    return [self rui_matchesRegexPattern:[[self class] regexForFloat]];
}

- (BOOL)rui_isFloat
{
    BOOL isFloat = [self rui_isUnsignedFloat];
    
    if (!isFloat && [self hasPrefix:kMinusSign])
    {
        isFloat = [[self substringFromIndex:1] rui_isUnsignedFloat];
    }
    
    return isFloat;
}

- (BOOL)rui_isNumeric
{
    return [self rui_isInteger] || [self rui_isFloat];
}

- (BOOL)rui_isAlphanumeric
{
    return [self rui_matchesCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
}

- (BOOL)rui_isLetters
{
    return [self rui_matchesCharacterSet:[NSCharacterSet letterCharacterSet]];
}

- (BOOL)rui_isEmpty
{
    return [self length] == 0;
}

- (BOOL)rui_matchesCharacterSet:(NSCharacterSet *)characterSet
{
    if ([self rui_isEmpty])
    {
        return NO;
    }
    
    return [[self stringByTrimmingCharactersInSet:characterSet] length] == 0;
}

- (BOOL)rui_matchesRegexPattern:(NSString *)regexPattern
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    return !error ? [self rui_matchesRegex:regex] : NO;
}

- (BOOL)rui_matchesRegex:(NSRegularExpression *)regex
{
    if ([self rui_isEmpty])
    {
        return NO;
    }
    
    NSRange stringRange = NSMakeRange(0, [self length]);
    NSRange matchRange = [regex rangeOfFirstMatchInString:self options:NSMatchingReportProgress range:NSMakeRange(0, [self length])];
    return matchRange.location == stringRange.location && matchRange.length == stringRange.length;
}

@end
