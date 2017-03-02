//
//  XLTextViewCell.m
//  Pods
//
//  Created by Aki Xavier on 02/03/2017.
//
//
#import <PureLayout/PureLayout.h>
#import "XLFormBaseCell+Deselect.h"
#import "XLTextViewCell.h"

@interface XLTextViewCell()

@property (strong, nonatomic) UITextView *textView;

@end

@implementation XLTextViewCell

- (void)configure {
    [super configure];
    [self.contentView addSubview:self.textView];
    [self.textView autoPinEdgesToSuperviewMargins];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.userInteractionEnabled = NO;
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textView.textColor = [UIColor grayColor];
    }
    return _textView;
}

- (void)update {
    [super update];
    self.textView.text = self.rowDescriptor.value;
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
    [self deselect:controller];
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    textView.text = rowDescriptor.value;
    textView.contentInset = UIEdgeInsetsZero;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIEdgeInsets insets = cell.layoutMargins;
    CGSize newSize = [textView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - insets.right - insets.left, MAXFLOAT)];
    double height = newSize.height + insets.top + insets.bottom;
    return height + 8;
}

@end
