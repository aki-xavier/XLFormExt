#import <XLForm/XLForm.h>

@interface XLFormViewController(Ext)

- (XLFormDescriptor *)createFormWithTitle:(NSString *)title andJSON:(NSArray *)sections;
- (XLFormDescriptor *)createFormWithTitle:(NSString *)title andJSON:(NSArray *)sections andSectionTitles:(NSArray *)sectionTitles;
- (void)deselectTag:(NSString *)tag;

@end