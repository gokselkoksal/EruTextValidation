//
//  ERUFormValidator.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 01/01/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUFormValidator.h"
#import "ERUTextValidator.h"

@interface ERUFormValidator () <ERUTextValidatorDelegate>

@end

@implementation ERUFormValidator

#pragma mark - Lifecycle

- (instancetype)initWithTextValidators:(NSArray *)textValidators
{
    self = [super init];
    
    if (self)
    {
        _textValidators = textValidators;
        [_textValidators enumerateObjectsUsingBlock:^(ERUTextValidator *textValidator, NSUInteger idx, BOOL *stop) {
            textValidator.delegate = self;
        }];
    }
    
    return self;
}

#pragma mark - Public methods

- (BOOL)isReadyToSubmit
{
    __block BOOL readyToSubmit = YES;
    
    [self.textValidators enumerateObjectsUsingBlock:^(ERUTextValidator *textValidator, NSUInteger index, BOOL *stop) {
        
        readyToSubmit = textValidator.readyToSubmit;
        
        if (!readyToSubmit)
        {
            *stop = YES;
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(formValidator:isReadyToSubmit:)])
    {
        [self.delegate formValidator:self isReadyToSubmit:readyToSubmit];
    }
    
    return readyToSubmit;
}

#pragma mark - ERUTextValidatorDelegate

- (void)textValidator:(ERUTextValidator *)textValidator isReadyToSubmit:(BOOL)readyToSubmit
{
    [self isReadyToSubmit];
}

@end
