# EruTextValidation

This is a component for validating text easily in iOS applications. Aim is to separate text validation logic from controllers and reuse wherever possible.

# Usage

- Download and build the project using ```EruTextValidationBuilder``` target. This will generate the framework in repo's root directory.
- Add ```EruTextValidation.framework``` to your project.
- In prefix header or wherever needed, import with ```#import <EruTextValidation/EruTextValidation.h>```.

**Pre iOS 8**: You need to add classes under ```Classes``` and ```Categories``` folder to your project manually.

## Input Validation
You can validate user input as-they-type.

- Make text field to accept only integers.
```objective-c
[self.numericField.validator.inputRules addRule:[ERUTextValidationRule ruleForIntegerOnly]];
```
- Make text field to accept only alphanumeric characters.
```objective-c
[self.alphanumericField.validator.inputRules addRule:[ERUTextValidationRule ruleForAlphanumericOnly]];
```

## Validation Before Submitting To Server/Database
You can add rules to validate text before sending to server.
- Don't submit unless ```idNo``` is at least 10 characters.
```objective-c
[self.idNoField.validator.submitRules addRule:[[ERUTextValidationRule alloc] initWithBlock:^BOOL(NSString *string) {
    return [string length] >= 10;
}]];
```
- Don't submit unless ```email``` is not valid.
```objective-c
[self.emailField.validator.submitRules addRule:[ERUTextValidationRule ruleForEmail]];
```
There is no point sending a pre-mature ```idNo``` or ```email``` to server afterall. Don't even enable submit button if ```readyToSubmit``` is NO.

## Validating Forms

You can validate a form with multiple text fields/views easily with ```ERUFormValidator```. In your view controller, follow these steps:
- Have a ```ERUFormValidator``` property.
```
@property (strong, nonatomic) ERUFormValidator *formValidator;
```

- In ```viewDidLoad```, initialize with text/form validators.
```objective-c
// Add input rules.
[self.idNoField.validator.inputRules.rules addRule:[ERUTextValidationRule ruleForIntegerOnly]];
[self.nameField.validator.inputRules.rules addRule:[ERUTextValidationRule ruleForLettersOnly]];

// Add submit rules.
[self.idNoField.validator.submitRules addRule:[[ERUTextValidationRule alloc] initWithBlock:^BOOL(NSString *string) {
    return [string length] >= 10;
}]];
[self.emailField.validator.submitRules addRule:[ERUTextValidationRule ruleForEmail]];

// Initialize form validator.
NSArray *textValidators = @[self.numericField.validator, self.alphanumericField.validator, self.idNoField.validator, self.emailField.validator];
self.formValidator = [[ERUFormValidator alloc] initWithTextValidators:textValidators];
self.formValidator.delegate = self;
```

- Conform to ```ERUFormValidatorDelegate```.
```objective-c
- (void)formValidator:(ERUFormValidator *)formValidator isReadyToSubmit:(BOOL)readyToSubmit
{
    // This will be called after every user input and readyToSubmit will be YES if all submitRules are validated.
    self.submitButton.enabled = readyToSubmit;
}
```

With this, you can control user input and decide when to submit. It is not wise to bother server with trash values, so always validate as user types, and validate before submit.

# License
```
Copyright 2015 Göksel Köksal

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
