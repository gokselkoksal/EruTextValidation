//
//  RUIValidator.h
//  EruUIKit
//
//  Created by Göksel Köksal on 01/01/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RUIFormValidatorDelegate;

/**
 A form validator class that uses dependent RUITextValidator objects and determines a overall readyToSubmit state.
 */
@interface RUIFormValidator : NSObject <UITextFieldDelegate, UITextViewDelegate>

/**
 Delegate of form validator. Most likely your view controller.
 */
@property (weak, nonatomic) id<RUIFormValidatorDelegate> delegate;

/**
 Text validators used by form validator.
 */
@property (strong, nonatomic, readonly) NSArray *textValidators;

/**
 @return an instance with given validators.
 @param textValidators Array of validators. (of type RUITextValidator)
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
@protocol RUIFormValidatorDelegate <NSObject>

@optional

/**
 Gets called when readyToSubmit of a validator changes.
 @param formValidator Form validator object firing this notification.
 @param readyToSubmit readyToSubmit state of this form validator.
 */
- (void)formValidator:(RUIFormValidator *)formValidator isReadyToSubmit:(BOOL)readyToSubmit;

@end
