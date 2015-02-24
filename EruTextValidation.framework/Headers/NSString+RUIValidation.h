//
//  NSString+RUIValidation.h
//  EruUIKit
//
//  Created by Göksel Köksal on 08/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Category on NSString for additional validation methods.
 */
@interface NSString (RUIValidation)

/**
 Decimal separator used for validations.
 */
+ (NSString *)rui_decimalSeparator;

/**
 Sets decimal separator to be used in validations.
 @param decimalSeparator Decimal separator to set.
 */
+ (void)rui_setDecimalSeparator:(NSString *)decimalSeparator;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)rui_isUnsignedInteger;

/**
 @return YES if string is an integer.
 */
- (BOOL)rui_isInteger;

/**
 @return YES if string is an unsigned integer.
 */
- (BOOL)rui_isUnsignedFloat;

/**
 @return YES if string is a floating point number.
 */
- (BOOL)rui_isFloat;

/**
 @return YES if string is numeric.
 */
- (BOOL)rui_isNumeric;

/**
 @return YES if string is an unsigned floating point number.
 */
- (BOOL)rui_isLetters;

/**
 @return YES if string is alphanumeric.
 */
- (BOOL)rui_isAlphanumeric;

/**
 @return YES if string is empty.
 */
- (BOOL)rui_isEmpty;

/**
 @return YES if string as a WHOLE matches given regex.
 @param regex Regular expression to match.
 */
- (BOOL)rui_matchesRegex:(NSRegularExpression *)regex;

/**
 @return YES if string as a WHOLE matches given regex pattern. If pattern is invalid, method returns NO.
 @param regexPattern Regular expression pattern to match.
 @note NSRegularExpression will be created with NSRegularExpressionCaseInsensitive option.
 */
- (BOOL)rui_matchesRegexPattern:(NSString *)regexPattern;

/**
 @return YES if string as a WHOLE matches the given character set.
 @param characterSet Character set to match.
 */
- (BOOL)rui_matchesCharacterSet:(NSCharacterSet *)characterSet;

@end
