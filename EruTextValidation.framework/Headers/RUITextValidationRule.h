//
//  WLTTextFieldValidator.h
//  EruUIKit
//
//  Created by Göksel Köksal on 07/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "NSString+RUIValidation.h"

/**
 Validation block to be used when validating text.
 */
typedef BOOL(^RUITextValidationBlock)(NSString *string);

/**
 Protocol to be adopted when defining text validation rules.
 */
@protocol RUITextValidationRule <NSObject>

/**
 Validation block to be used when validating text.
 */
@property (copy, nonatomic, readonly) RUITextValidationBlock validationBlock;

/**
 Error message to be displayed when validation fails for this rule.
 */
@property (strong, nonatomic, readonly) NSString *errorMessage;

/**
 Validates text using validation block.
 @param text Text to validate.
 @return YES if text is valid.
 */
- (BOOL)validateText:(NSString *)text;

@end

/**
 Wrapper for a text validation rule.
 */
@interface RUITextValidationRule : NSObject <RUITextValidationRule>

/**
 @return an instance of this class.
 @param block Validation block to be used when validating text.
 */
- (instancetype)initWithBlock:(RUITextValidationBlock)block;

/**
 @return an instance of this class.
 @param block Validation block to be used when validating text.
 @param errorMessage Error message to be displayed upon failure.
 */
- (instancetype)initWithBlock:(RUITextValidationBlock)block
                 errorMessage:(NSString *)errorMessage;

@end

/**
 Category for commonly used validation rules.
 */
@interface RUITextValidationRule (RUIFactory)

/**
 @return rule to accept only integers. (e.g 1000, 23423)
 */
+ (instancetype)ruleForIntegerOnly;

/**
 @return rule to accept only numeric. (e.g 23452, 235.42)
 */
+ (instancetype)ruleForNumericOnly;

/**
 @return rule to accept only alphanumeric characters. (e.g 24AD43, 23klo134)
 */
+ (instancetype)ruleForAlphanumericOnly;

/**
 @return rule to accept only letters. (e.g LETTERS, Some other sample)
 */
+ (instancetype)ruleForLettersOnly;

/**
 @return rule to accept strings with max length.
 @param maxLength Maximum length to accept.
 */
+ (instancetype)ruleForMaxLength:(NSUInteger)maxLength;

/**
 @return rule to accept strings with min and max length.
 @param minLength Minimum length of string to accept.
 @note This should not be used as an input rule as it won't accept anything initially.
 */
+ (instancetype)ruleForMinLength:(NSUInteger)minLength;

/**
 @return rule to accept strings with min and max length.
 @param minLength Minimum length of string to accept.
 @param maxLength Maximum length of string to accept.
 @note This should not be used as an input rule as it won't accept anything initially.
 */
+ (instancetype)ruleForMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength;

@end
