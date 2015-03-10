//
//  ERUFormValidator.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 01/01/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ERUFormValidatorDelegate;

/**
 A form validator class that uses dependent ERUTextValidator objects and determines a overall readyToSubmit state.
 */
@interface ERUFormValidator : NSObject <UITextFieldDelegate, UITextViewDelegate>

/**
 Delegate of form validator. Most likely your view controller.
 */
@property (weak, nonatomic) id<ERUFormValidatorDelegate> delegate;

/**
 Text validators used by form validator.
 */
@property (strong, nonatomic, readonly) NSArray *textValidators;

/**
 @return an instance with given validators.
 @param textValidators Array of validators. (of type ERUTextValidator)
 */
- (instancetype)initWithTextValidators:(NSArray *)textValidators;

/**
 @return YES if all text validators are ready to submit.
 */
- (BOOL)isReadyToSubmit;

@end

/**
 This protocol should be adapted by a controller that needs notifications about readyToSubmit state of this validator.
 */
@protocol ERUFormValidatorDelegate <NSObject>

@optional

/**
 Gets called when readyToSubmit of a validator changes.
 @param formValidator Form validator object firing this notification.
 @param readyToSubmit readyToSubmit state of this form validator.
 */
- (void)formValidator:(ERUFormValidator *)formValidator isReadyToSubmit:(BOOL)readyToSubmit;

@end
