//
//  ERUTextValidator.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 16/02/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUTextValidator.h"
#import "NSString+ERUValidation.h"

@interface ERUTextValidator ()

@property (assign, nonatomic, readwrite) BOOL readyToSubmit;
@property (strong, nonatomic, readwrite) ERUTextValidationRule *failedSubmitRule;

@end

@implementation ERUTextValidator

@synthesize inputRules = _inputRules;
@synthesize submitRules = _submitRules;

- (ERUTextValidationRuleCollection *)inputRules
{
    if (!_inputRules)
    {
        _inputRules = [[ERUTextValidationRuleCollection alloc] init];
    }
    
    return _inputRules;
}

- (ERUTextValidationRuleCollection *)submitRules
{
    if (!_submitRules)
    {
        _submitRules = [[ERUTextValidationRuleCollection alloc] init];
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
        valid = [textToValidate length] == 0 || [self.inputRules validateText:textToValidate];
    }
    
    if (self.submitRules && valid)
    {
        ERUTextValidationRule *failedRule;
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
