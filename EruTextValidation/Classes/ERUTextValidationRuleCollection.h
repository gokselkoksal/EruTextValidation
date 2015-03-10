//
//  ERUTextValidationRuleCollection.h
//  EruTextValidation
//
//  Created by Göksel Köksal on 31/01/15.
//  Copyright (c) 2015 Eru. All rights reserved.
//

#import "ERUTextValidationRule.h"

/**
 Collection for ERUTextValidation objects.
 */
@interface ERUTextValidationRuleCollection : NSObject

/**
 @returns an instance of this class with given rules.
 @param rules
 */
- (instancetype)initWithRules:(NSArray *)rules;

/**
 Adds given rule to collection.
 @param rule Rule to add.
 */
- (void)addRule:(id<ERUTextValidationRule>)rule;

/**
 Adds given rules to collection.
 @param rules Rules to add. (of type id<ERUTextValidationRule>)
 */
- (void)addRules:(NSArray *)rules;

/**
 Removes given rule from collection.
 @param rule Rule to remove.
 */
- (void)removeRule:(id<ERUTextValidationRule>)rule;

/**
 Removes given rules from collection.
 @param rules Rules to remove. (of type id<ERUTextValidationRule>)
 */
- (void)removeRules:(NSArray *)rules;

/**
 Removes all rules from collection.
 */
- (void)removeAllRules;

/**
 Returns all rules in the collection.
 */
- (NSArray *)rules;

/**
 @return rule at index.
 @param index Index of rule.
 */
- (id<ERUTextValidationRule>)ruleAtIndex:(NSUInteger)index;

/**
 Validates given text.
 @param text Text to validate.
 @return YES if text is valid.
 */
- (BOOL)validateText:(NSString *)text;

/**
 Validates given text.
 @param text Text to validate.
 @param failedRule Failed rule.
 @return YES if text is valid.
 */
- (BOOL)validateText:(NSString *)text failedRule:(out id<ERUTextValidationRule> *)failedRule;

@end