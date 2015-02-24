//
//  RTVTextFieldValidator.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 07/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "RTVTextValidationRule.h"
#import "NSString+RTVValidation.h"

#pragma mark - RTVTextValidatorRule

@implementation RTVTextValidationRule

@synthesize validationBlock = _validationBlock;
@synthesize errorMessage = _errorMessage;

- (instancetype)initWithBlock:(RTVTextValidationBlock)block
{
    return [self initWithBlock:block errorMessage:nil];
}

- (instancetype)initWithBlock:(RTVTextValidationBlock)block errorMessage:(NSString *)errorMessage
{
    self = [super init];
    
    if (self)
    {
        _validationBlock = [block copy];
        _errorMessage = errorMessage;
    }
    
    return self;
}

- (BOOL)validateText:(NSString *)text
{
    return self.validationBlock(text);
}

@end

#pragma mark - RTVTextValidationRule+RTVFactory

@implementation RTVTextValidationRule (RTVFactory)

+ (instancetype)ruleForIntegerOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rtv_isInteger];
    }];
}

+ (instancetype)ruleForNumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rtv_isNumeric];
    }];
}

+ (instancetype)ruleForAlphanumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rtv_isAlphanumeric];
    }];
}

+ (instancetype)ruleForLettersOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rtv_isLetters];
    }];
}

+ (instancetype)ruleForMaxLength:(NSUInteger)maxLength
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string length] <= maxLength;
    }];
}

+ (instancetype)ruleForMinLength:(NSUInteger)minLength
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string length] >= minLength;
    }];
}

+ (instancetype)ruleForMinLength:(NSUInteger)minLength maxLength:(NSUInteger)maxLength
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        NSUInteger length = [string length];
        return length >= minLength && length <= maxLength;
    }];
}

+ (instancetype)ruleForEmail
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rtv_isValidEmail];
    }];
}

@end
