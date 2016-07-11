#import "XLFormBaseCell+Deselect.h"

@implementation XLFormBaseCell(Deselect)

- (void)deselect:(XLFormViewController *)controller {
	[controller.tableView deselectRowAtIndexPath:[controller.form indexPathOfFormRow:self.rowDescriptor] animated:YES];
}

@end