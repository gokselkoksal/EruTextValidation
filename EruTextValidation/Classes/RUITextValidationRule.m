//
//  RUITextFieldValidator.m
//  EruUIKit
//
//  Created by Göksel Köksal on 07/11/14.
//  Copyright (c) 2014 Eru. All rights reserved.
//

#import "RUITextValidationRule.h"
#import "NSString+RUIValidation.h"

#pragma mark - RUITextValidatorRule

@implementation RUITextValidationRule

@synthesize validationBlock = _validationBlock;
@synthesize errorMessage = _errorMessage;

- (instancetype)initWithBlock:(RUITextValidationBlock)block
{
    return [self initWithBlock:block errorMessage:nil];
}

- (instancetype)initWithBlock:(RUITextValidationBlock)block errorMessage:(NSString *)errorMessage
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

#pragma mark - RUITextValidationRule+RUIFactory

@implementation RUITextValidationRule (RUIFactory)

+ (instancetype)ruleForIntegerOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rui_isInteger];
    }];
}

+ (instancetype)ruleForNumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rui_isNumeric];
    }];
}

+ (instancetype)ruleForAlphanumericOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rui_isAlphanumeric];
    }];
}

+ (instancetype)ruleForLettersOnly
{
    return [[self alloc] initWithBlock:^BOOL(NSString *string) {
        return [string rui_isLetters];
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

@end
