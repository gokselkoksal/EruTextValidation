//
//  UITextView+ERUValidation.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 19/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUTextValidator.h"

/**
 Category on UITextView to support validation.
 */
@interface UITextView (ERUValidation)

/**
 Validator object which will validate input and determine submit state of this text field.
 @note This property is lazily created. When you set/use it, it will automatically set delegate of text view to validator object.
 */
@property (strong, nonatomic) ERUTextValidator *validator;

@end