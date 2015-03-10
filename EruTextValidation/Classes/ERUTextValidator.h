//
//  ERUTextValidator.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 16/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUTextValidationRule.h"
#import "ERUTextValidationRuleCollection.h"

@protocol ERUTextValidatorDelegate;

/**
 Text validator to use in fields.
 */
@interface ERUTextValidator : NSObject <UITextFieldDelegate, UITextViewDelegate>

/**
 Delegate object for validator.
 */
@property (weak, nonatomic) id<ERUTextValidatorDelegate> delegate;

/**
 Rule collection to be used when validating input to a field.
 */
@property (strong, nonatomic, readonly) ERUTextValidationRuleCollection *inputRules;

/**
 Rule collection to be used when validating a field before submit.
 */
@property (strong, nonatomic, readonly) ERUTextValidationRuleCollection *submitRules;

/**
 Failed submit rule, if any.
 */
@property (strong, nonatomic, readonly) ERUTextValidationRule *failedSubmitRule;

/**
 Submit state of this validator. Should not be submitted to server if this property is NO.
 */
@property (assign, nonatomic, readonly) BOOL readyToSubmit;

@end

/**
 This protocol should be adopted by an object which needs notifications about text validators.
 */
@protocol ERUTextValidatorDelegate <NSObject>

/**
 Gets called upon readyToSubmit state changes.
 @param textValidator Text validator who is responsible for this action.
 @param readyToSubmit Current readyToSubmit state.
 */
- (void)textValidator:(ERUTextValidator *)textValidator isReadyToSubmit:(BOOL)readyToSubmit;

@end
