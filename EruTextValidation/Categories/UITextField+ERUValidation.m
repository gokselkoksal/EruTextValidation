//
//  UITextField+ERUValidation.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 19/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "UITextField+ERUValidation.h"
#import <objc/runtime.h>

@implementation UITextField (ERUValidation)

- (ERUTextValidator *)validator
{
    ERUTextValidator *validator = [self associatedValidator];
    if (!validator)
    {
        validator = [[ERUTextValidator alloc] init];
        [self setAssociatedValidator:validator];
        self.delegate = validator;
    }
    
    return validator;
}

- (void)setValidator:(ERUTextValidator *)validator
{
    [self setAssociatedValidator:validator];
    self.delegate = validator;
}

- (ERUTextValidator *)associatedValidator
{
    return objc_getAssociatedObject(self, @selector(validator));
}

- (void)setAssociatedValidator:(ERUTextValidator *)validator
{
    objc_setAssociatedObject(self, @selector(validator), validator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
