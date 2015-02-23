# EruTextValidation
This is a component for validating text easily in iOS applications. Aim is to separate text validation logic from controllers and reuse wherever possible.


# Usage

## Input Validation
You can validate user input as-they-type.

- Make text field to accept only integers.
```objective-c
[self.numericField.validator.inputRules.rules addRule:[RUITextValidationRule ruleForIntegerOnly]];
```
- Make text field to accept only alphanumeric characters.
```objective-c
[self.alphanumericField.validator.inputRules.rules addRule:[RUITextValidationRule ruleForAlphanumericOnly]];
```

## Validation Before Submitting To Server/Database
You can add rules to validate text before sending to server.
- Don't submit unless ```idNo``` is at least 10 characters.
```objective-c
[self.idNoField.validator.submitRules addRule:[[RUITextValidationRule alloc] initWithBlock:^BOOL(NSString *string) {
    return [string length] >= 10;
}]];
```
There is no point sending a pre-mature ```idNo``` to server afterall. Don't even enable submit button if ```readyToSubmit``` is NO.

## Validating Forms

You can validate a form with multiple text fields/views easily with ```RUIFormValidator```. In your view controller, follow these steps:
- Have a ```RUIFormValidator``` property.
```
@property (strong, nonatomic) RUIFormValidator *formValidator;
```

- In ```viewDidLoad```, initialize with text/form validators.
```objective-c
// Add input rules.
[self.idNoField.validator.inputRules.rules addRule:[RUITextValidationRule ruleForIntegerOnly]];
[self.nameField.validator.inputRules.rules addRule:[RUITextValidationRule ruleForLettersOnly]];

// Add submit rules.
[self.idNoField.validator.submitRules addRule:[[RUITextValidationRule alloc] initWithBlock:^BOOL(NSString *string) {
    return [string length] >= 10;
}]];

// Initialize form validator.
NSArray *textValidators = @[self.numericField.validator, self.alphanumericField.validator, self.idNoField.validator];
self.formValidator = [[RUIFormValidator alloc] initWithTextValidators:textValidators];
self.formValidator.delegate = self;
```

- Conform to ```RUIFormValidatorDelegate```.
```objective-c
- (void)formValidator:(RUIFormValidator *)formValidator isReadyToSubmit:(BOOL)readyToSubmit
{
    self.submitButton.enabled = readyToSubmit;
}
```

With this, you can control user input and decide when to submit. It is not wise to bother server with trash values, so always validate as user types, and validate before submit.
