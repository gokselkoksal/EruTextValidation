//
//  ERUTextFieldValidator.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 07/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "ERUTextValidationRule.h"
#import "NSString+ERUValidation.h"

#pragma mark - ERUTextValidatorRule

@implementation ERUTextValidationRule

@synthesize validationBlock = _validationBlock;
@synthesize errorMessage = _errorMessage;

- (instancetype)initWithBlock:(ERUTextValidationBlock)block
{
    return [self initWithBlock:block errorMessage:nil];
}

- (instancetype)initWithBlock:(ERUTextValidationBlock)block errorMessage:(NSString *)errorMessage
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

#pragma mark - ERUTextValidationRule+ERUFactory

@implementation ERUTextValidationRule (ERUFactory)

+ (instancetype)ruleForIntegerOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string eru_isInteger];
    }];
}

+ (instancetype)ruleForNumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string eru_isNumeric];
    }];
}

+ (instancetype)ruleForAlphanumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string eru_isAlphanumeric];
    }];
}

+ (instancetype)ruleForLettersOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string eru_isLetters];
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
        return [string eru_isValidEmail];
    }];
}

@end
