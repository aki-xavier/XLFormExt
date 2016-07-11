#import <XLForm/XLForm.h>

@interface XLUnitCell : XLFormBaseCell<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UILabel *unitLabel;

@property (copy, nonatomic) NSString *unit;
@property (nonatomic) NSNumber *editable; // 0 or 1

@end