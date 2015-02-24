//
//  UITextView+RTVValidation.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 19/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "UITextView+RTVValidation.h"
#import <objc/runtime.h>

@implementation UITextView (RTVValidation)

- (RTVTextValidator *)validator
{
    RTVTextValidator *validator = [self associatedValidator];
    if (!validator)
    {
        validator = [[RTVTextValidator alloc] init];
        [self setAssociatedValidator:validator];
        self.delegate = validator;
    }
    
    return validator;
}

- (void)setValidator:(RTVTextValidator *)validator
{
    [self setAssociatedValidator:validator];
    self.delegate = validator;
}

- (RTVTextValidator *)associatedValidator
{
    return objc_getAssociatedObject(self, @selector(validator));
}

- (void)setAssociatedValidator:(RTVTextValidator *)validator
{
    objc_setAssociatedObject(self, @selector(validator), validator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
