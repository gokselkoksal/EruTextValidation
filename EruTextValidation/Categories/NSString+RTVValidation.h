//
//  NSString+RTVValidation.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Category on NSString for additional validation methods.
 */
@interface NSString (RTVValidation)

/**
 Decimal separator used for validations.
 */
+ (NSString *)rtv_decimalSeparator;

/**
 Sets decimal separator to be used in validations.
 @param decimalSeparator Decimal separator to set.
 */
+ (void)rtv_setDecimalSeparator:(NSString *)decimalSeparator;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)rtv_isUnsignedInteger;

/**
 @return YES if string is an integer.
 */
- (BOOL)rtv_isInteger;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)rtv_isUnsignedFloat;

/**
 @return YES if string is a floating point number.
 */
- (BOOL)rtv_isFloat;

/**
 @return YES if string is numeric.
 */
- (BOOL)rtv_isNumeric;

/**
 @return YES if string is an unsigned floating point number.
 */
- (BOOL)rtv_isLetters;

/**
 @return YES if string is alphanumeric.
 */
- (BOOL)rtv_isAlphanumeric;

/**
 @return YES if string is empty.
 */
- (BOOL)rtv_isEmpty;

/**
 @return YES if string as a WHOLE matches given regex.
 @param regex Regular expression to match.
 */
- (BOOL)rtv_matchesRegex:(NSRegularExpression *)regex;

/**
 @return YES if string as a WHOLE matches given regex pattern. If pattern is invalid, method returns NO.
 @param regexPattern Regular expression pattern to match.
 @note NSRegularExpression will be created with NSRegularExpressionCaseInsensitive option.
 */
- (BOOL)rtv_matchesRegexPattern:(NSString *)regexPattern;

/**
 @return YES if string as a WHOLE matches the given character set.
 @param characterSet Character set to match.
 */
- (BOOL)rtv_matchesCharacterSet:(NSCharacterSet *)characterSet;

/**
 @return YES if string is a valid email address.
 */
- (BOOL)rtv_isValidEmail;

@end
