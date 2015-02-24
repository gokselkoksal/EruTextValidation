//
//  RTVTextValidator.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 16/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "RTVTextValidationRule.h"
#import "RTVTextValidationRuleCollection.h"

@protocol RTVTextValidatorDelegate;

/**
 Text validator to use in fields.
 */
@interface RTVTextValidator : NSObject <UITextFieldDelegate, UITextViewDelegate>

/**
 Delegate object for validator.
 */
@property (weak, nonatomic) id<RTVTextValidatorDelegate> delegate;

/**
 Rule collection to be used when validating input to a field.
 */
@property (strong, nonatomic, readonly) RTVTextValidationRuleCollection *inputRules;

/**
 Rule collection to be used when validating a field before submit.
 */
@property (strong, nonatomic, readonly) RTVTextValidationRuleCollection *submitRules;

/**
 Failed submit rule, if any.
 */
@property (strong, nonatomic, readonly) RTVTextValidationRule *failedSubmitRule;

/**
 Submit state of this validator. Should not be submitted to server if this property is NO.
 */
@property (assign, nonatomic, readonly) BOOL readyToSubmit;

@end

/**
 This protocol should be adopted by an object which needs notifications about text validators.
 */
@protocol RTVTextValidatorDelegate <NSObject>

/**
 Gets called upon readyToSubmit state changes.
 @param textValidator Text validator who is responsible for this action.
 @param readyToSubmit Current readyToSubmit state.
 */
- (void)textValidator:(RTVTextValidator *)textValidator isReadyToSubmit:(BOOL)readyToSubmit;

@end
