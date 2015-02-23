//
//  UITextField+RUIValidation.m
//  EruUIKit
//
//  Created by Göksel Köksal on 19/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "UITextField+RUIValidation.h"
#import <objc/runtime.h>

@implementation UITextField (RUIValidation)

- (RUITextValidator *)validator
{
    RUITextValidator *validator = [self associatedValidator];
    if (!validator)
    {
        validator = [[RUITextValidator alloc] init];
        [self setAssociatedValidator:validator];
        self.delegate = validator;
    }
    
    return validator;
}

- (void)setValidator:(RUITextValidator *)validator
{
    [self setAssociatedValidator:validator];
    self.delegate = validator;
}

- (RUITextValidator *)associatedValidator
{
    return objc_getAssociatedObject(self, @selector(validator));
}

- (void)setAssociatedValidator:(RUITextValidator *)validator
{
    objc_setAssociatedObject(self, @selector(validator), validator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
