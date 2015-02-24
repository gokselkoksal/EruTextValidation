//
//  RTVTextValidator.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 16/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "RTVTextValidator.h"
#import "NSString+RTVValidation.h"

@interface RTVTextValidator ()

@property (assign, nonatomic, readwrite) BOOL readyToSubmit;
@property (strong, nonatomic, readwrite) RTVTextValidationRule *failedSubmitRule;

@end

@implementation RTVTextValidator

@synthesize inputRules = _inputRules;
@synthesize submitRules = _submitRules;

- (RTVTextValidationRuleCollection *)inputRules
{
    if (!_inputRules)
    {
        _inputRules = [[RTVTextValidationRuleCollection alloc] init];
    }
    
    return _inputRules;
}

- (RTVTextValidationRuleCollection *)submitRules
{
    if (!_submitRules)
    {
        _submitRules = [[RTVTextValidationRuleCollection alloc] init];
    }
    
    return _submitRules;
}

- (void)setReadyToSubmit:(BOOL)readyToSubmit
{
    if (_readyToSubmit == readyToSubmit)
    {
        return;
    }
    
    _readyToSubmit = readyToSubmit;
    
    if (_readyToSubmit)
    {
        self.failedSubmitRule = nil;
    }
    
    if ([self.delegate respondsToSelector:@selector(textValidator:isReadyToSubmit:)])
    {
        [self.delegate textValidator:self isReadyToSubmit:_readyToSubmit];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self validateText:[textField.text stringByReplacingCharactersInRange:range withString:string]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return [self validateText:[textView.text stringByReplacingCharactersInRange:range withString:text]];
}

- (BOOL)validateText:(NSString *)textToValidate
{
    BOOL valid = YES;
    
    if (self.inputRules)
    {
        valid = [textToValidate rtv_isEmpty] || [self.inputRules validateText:textToValidate];
    }
    
    if (self.submitRules && valid)
    {
        RTVTextValidationRule *failedRule;
        self.readyToSubmit = [self.submitRules validateText:textToValidate failedRule:&failedRule];
        self.failedSubmitRule = failedRule;
    }
    else if (valid)
    {
        self.readyToSubmit = YES;
    }
    
    return valid;
}

@end
