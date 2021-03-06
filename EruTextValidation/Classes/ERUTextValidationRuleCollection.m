//
//  ERUTextValidationRuleCollection.m
//  EruTextValidation
//
//  Created by Göksel Köksal on 31/01/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUTextValidationRuleCollection.h"

#pragma mark - ERUTextValidationRuleCollection

@interface ERUTextValidationRuleCollection ()

@property (strong, nonatomic, readwrite) NSMutableArray *validationRules;

@end

@implementation ERUTextValidationRuleCollection

- (instancetype)initWithRules:(NSArray *)rules
{
    self = [super init];
    
    if (self)
    {
        _validationRules = [rules mutableCopy];
    }
    
    return self;
}

- (NSMutableArray *)validationRules
{
    if (!_validationRules)
    {
        _validationRules = [NSMutableArray array];
    }
    
    return _validationRules;
}

- (void)addRule:(id<ERUTextValidationRule>)rule
{
    [self.validationRules addObject:rule];
}

- (void)addRules:(NSArray *)rules
{
    [rules enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        if ([object conformsToProtocol:@protocol(ERUTextValidationRule)])
        {
            [self.validationRules addObject:object];
        }
    }];
}

- (void)removeRule:(id<ERUTextValidationRule>)rule
{
    [self.validationRules removeObject:rule];
}

- (void)removeRules:(NSArray *)rules
{
    [self.validationRules removeObjectsInArray:rules];
}

- (void)removeAllRules
{
    [self.validationRules removeAllObjects];
}

- (NSArray *)rules
{
    return [self.validationRules copy];
}

- (id<ERUTextValidationRule>)ruleAtIndex:(NSUInteger)index
{
    if (index < [self.validationRules count])
    {
        return self.validationRules[index];
    }
    else
    {
        return nil;
    }
}

- (BOOL)validateText:(NSString *)text
{
    return [self validateText:text failedRule:nil];
}

- (BOOL)validateText:(NSString *)text failedRule:(out __autoreleasing id<ERUTextValidationRule> *)failedRule
{
    __block BOOL succeeded = YES;
    
    [self.validationRules enumerateObjectsUsingBlock:^(id<ERUTextValidationRule> rule, NSUInteger idx, BOOL *stop) {
        
        if (![rule validateText:text])
        {
            *stop = YES;
            succeeded = NO;
            
            if (failedRule)
            {
                *failedRule = rule;
            }
        }
    }];
    
    return succeeded;
}

@end
