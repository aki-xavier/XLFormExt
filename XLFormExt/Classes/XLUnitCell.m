#import "XLUnitCell.h"
#import "XLFormBaseCell+Deselect.h"

#import <PureLayout/PureLayout.h>

@interface XLUnitCell()

@end

@implementation XLUnitCell

-(void)highlight {
	[super highlight];
	self.textField.textColor = self.tintColor;
}

-(void)unhighlight {
	[super unhighlight];
	[self.formViewController updateFormRow:self.rowDescriptor];
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	}
	return _titleLabel;
}

- (UITextField *)textField {
	if (!_textField) {
		_textField = [[UITextField alloc] init];
		_textField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_textField.textAlignment = NSTextAlignmentRight;
		_textField.keyboardType = UIKeyboardTypeDecimalPad;
		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_textField.delegate = self;
	}
	return _textField;
}

- (UILabel *)unitLabel {
	if (!_unitLabel) {
		_unitLabel = [[UILabel alloc] init];
		_unitLabel.textColor = [UIColor grayColor];
		_unitLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	}
	return _unitLabel;
}

- (void)update {
	[super update];
	self.titleLabel.text = self.rowDescriptor.title;
	self.textField.text = self.rowDescriptor.value ? [self.rowDescriptor.value displayText] : self.rowDescriptor.noValueDisplayText;
	self.textField.textColor = [UIColor grayColor];
	self.unitLabel.text = self.unit;
	if ([self.editable integerValue] == 0) {
		self.textField.enabled = NO;
	} else {
		self.textField.enabled = YES;
	}
}

- (void)configure {
	[super configure];
	[self.contentView addSubview:self.titleLabel];
	[self.contentView addSubview:self.textField];
	[self.contentView addSubview:self.unitLabel];
	self.editable = @(1);
	[self setupConstraints];
}

- (void)setupConstraints {
	double width = [UIScreen mainScreen].bounds.size.width;
	[self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
	[self.textField autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
	[self.unitLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

	[self.titleLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
	[self.unitLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
	[self.textField autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.unitLabel withOffset: -8];
	[self.textField autoSetDimension:ALDimensionWidth toSize:width / 2];
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
	[self deselect:controller];
	if ([self.editable integerValue] == 1) {
		[self.textField becomeFirstResponder];
	}
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	return [self.formViewController textFieldShouldClear:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	return [self.formViewController textFieldShouldReturn:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return [self.formViewController textFieldShouldBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	return [self.formViewController textFieldShouldEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.formViewController beginEditing:self.rowDescriptor];
	[self.formViewController textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self textFieldDidChange:textField];
	[self.formViewController endEditing:self.rowDescriptor];
	[self.formViewController textFieldDidEndEditing:textField];
}


#pragma mark - Helper

- (void)textFieldDidChange:(UITextField *)textField {
	if([self.textField.text length] > 0) {
		self.rowDescriptor.value = @([self.textField.text doubleValue]);
	} else {
		self.rowDescriptor.value = nil;
	}
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
	return 44;
}

@end