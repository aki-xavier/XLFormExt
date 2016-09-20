#import "XLFormViewController+Ext.h"

@implementation XLFormViewController(Ext)

- (BOOL)notNull:(id)value {
	if (value == nil || [value isKindOfClass:[NSNull class]]) {
		return NO;
	} else {
		return YES;
	}
}

- (XLFormDescriptor *)createFormWithTitle:(NSString *)title andJSON:(NSArray *)sections {
	return [self createFormWithTitle:title andJSON:sections andSectionTitles:@[]];
}

- (XLFormDescriptor *)createFormWithTitle:(NSString *)title andJSON:(NSArray *)sections andSectionTitles:(NSArray *)sectionTitles {
	XLFormDescriptor *form;
	XLFormSectionDescriptor *section;
	XLFormRowDescriptor *row;

	form = [XLFormDescriptor formDescriptorWithTitle:title];

	for (int i = 0; i < sections.count; i++) {
		NSArray *rows = sections[i];
		section = [XLFormSectionDescriptor formSection];
		if (sectionTitles.count >= i + 1 && rows.count != 0) {
			if (![sectionTitles[i] isEqualToString:@""]) {
				section.title = sectionTitles[i];
			}
		}
		[form addFormSection:section];
		for (NSDictionary *r in rows) {
			row = [XLFormRowDescriptor formRowDescriptorWithTag:r[@"tag"] rowType:r[@"type"] title:r[@"title"]];
			if ([self notNull:r[@"viewControllerClass"]]) {
				if ([r[@"viewControllerClass"] isKindOfClass:[NSString class]]) {
					row.action.viewControllerClass = NSClassFromString(r[@"viewControllerClass"]);
				} else {
					row.action.viewControllerClass = r[@"viewControllerClass"];
				}
			}
			if ([self notNull:r[@"formSelector"]]) {
				row.action.formSelector = NSSelectorFromString(r[@"formSelector"]);
			}
			if ([self notNull:r[@"cellClass"]]) {
				if ([r[@"cellClass"] isKindOfClass:[NSString class]]) {
					row.cellClass = NSClassFromString(r[@"cellClass"]);
				} else {
					row.cellClass = r[@"cellClass"];
				}
			}
			if ([self notNull:r[@"value"]]) {
				row.value = r[@"value"];
			}
			if ([self notNull:r[@"selectorOptions"]]) {
				row.selectorOptions = r[@"selectorOptions"];
			}
			if ([self notNull:r[@"hidden"]]) {
				row.hidden = r[@"hidden"];
			}
			if ([self notNull:r[@"disabled"]]) {
				row.disabled = r[@"disabled"];
			}
			if ([self notNull:r[@"textAlignment"]]) {
				[row.cellConfigAtConfigure setObject:r[@"textAlignment"] forKey:@"textField.textAlignment"];
			}
			if ([self notNull:r[@"unit"]]) {
				[row.cellConfigAtConfigure setObject:r[@"unit"] forKey:@"unit"];
			}
			if ([self notNull:r[@"editable"]]) {
				[row.cellConfigAtConfigure setObject:r[@"editable"] forKey:@"editable"];
			}
			if ([self notNull:r[@"returnKeyType"]]) {
				[row.cellConfigAtConfigure setObject:r[@"returnKeyType"] forKey:@"textField.returnKeyType"];
			}
			if ([self notNull:r[@"valueTransformer"]]) {
				row.valueTransformer = r[@"valueTransformer"];
			}
			if ([self notNull:r[@"tintColor"]]) {
				[row.cellConfigAtConfigure setObject:r[@"tintColor"] forKey:@"tintColor"];
			}
			if ([self notNull:r[@"textLabelColor"]]) {
				[row.cellConfigAtConfigure setObject:r[@"textLabelColor"] forKey:@"textLabel.textColor"];
			}
			if ([self notNull:r[@"textLabelFont"]]) {
				[row.cellConfigAtConfigure setObject:r[@"textLabelFont"] forKey:@"textLabel.font"];
			}
			if ([self notNull:r[@"detailTextLabelColor"]]) {
				[row.cellConfigAtConfigure setObject:r[@"detailTextLabelColor"] forKey:@"detailTextLabel.textColor"];
			}
			if ([self notNull:r[@"detailTextLabelFont"]]) {
				[row.cellConfigAtConfigure setObject:r[@"detailTextLabelFont"] forKey:@"detailTextLabel.font"];
			}
			if ([self notNull:r[@"textFieldColor"]]) {
				[row.cellConfigAtConfigure setObject:r[@"textFieldColor"] forKey:@"textField.textColor"];
			}
			if ([self notNull:r[@"textFieldFont"]]) {
				[row.cellConfigAtConfigure setObject:r[@"textFieldFont"] forKey:@"textField.font"];
			}
			[section addFormRow:row];
		}
	}

	return form;
}

- (void)deselectTag:(NSString *)tag {
	XLFormRowDescriptor *row = [self.form formRowWithTag:tag];
	[self.tableView deselectRowAtIndexPath:[self.form indexPathOfFormRow:row] animated:YES];
}

@end