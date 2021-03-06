//
//  NSString+ERUValidation.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kERUDefaultDecimalSeparator = @",";

/**
 Category on NSString for additional validation methods.
 */
@interface NSString (ERUValidation)

/**
 Decimal separator used for validations.
 */
+ (NSString *)eru_decimalSeparator;

/**
 Sets decimal separator to be used in validations.
 @param decimalSeparator Decimal separator to set.
 */
+ (void)eru_setDecimalSeparator:(NSString *)decimalSeparator;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)eru_isUnsignedInteger;

/**
 @return YES if string is an integer.
 */
- (BOOL)eru_isInteger;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)eru_isUnsignedFloat;

/**
 @return YES if string is a floating point number.
 */
- (BOOL)eru_isFloat;

/**
 @return YES if string is numeric.
 */
- (BOOL)eru_isNumeric;

/**
 @return YES if string is an unsigned floating point number.
 */
- (BOOL)eru_isLetters;

/**
 @return YES if string is alphanumeric.
 */
- (BOOL)eru_isAlphanumeric;

/**
 @return YES if string as a WHOLE matches given regex.
 @param regex Regular expression to match.
 */
- (BOOL)eru_matchesRegex:(NSRegularExpression *)regex;

/**
 @return YES if string as a WHOLE matches given regex pattern. If pattern is invalid, method returns NO.
 @param regexPattern Regular expression pattern to match.
 @note NSRegularExpression will be created with NSRegularExpressionCaseInsensitive option.
 */
- (BOOL)eru_matchesRegexPattern:(NSString *)regexPattern;

/**
 @return YES if string as a WHOLE matches the given character set.
 @param characterSet Character set to match.
 */
- (BOOL)eru_matchesCharacterSet:(NSCharacterSet *)characterSet;

/**
 @return YES if string is a valid email address.
 */
- (BOOL)eru_isValidEmail;

@end
