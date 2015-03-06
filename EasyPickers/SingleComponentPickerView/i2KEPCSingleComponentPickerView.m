//
//  SingleComponentPickerView.m
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 02.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCSingleComponentPickerView.h"
#import <ReactiveCocoa.h>

@interface i2KEPCSingleComponentPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *valuePicker;
@property (nonatomic, strong) NSArray *valuesArray;

@end

@implementation i2KEPCSingleComponentPickerView

- (instancetype)initWithTitle:(NSString *)title
				  valuesArray:(NSArray *)valuesArray
			initialValueIndex:(NSUInteger)initialValueIndex
{
	self = [super initWithTitle:title];
	if (self) {
		self.valuesArray = valuesArray;
		[self.valuePicker selectRow:initialValueIndex inComponent:0 animated:NO];
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)title
				   dataSource:(id<UIPickerViewDataSource>)dataSource
					 delegate:(id<UIPickerViewDelegate>)delegate
{
	self = [super initWithTitle:title];
	if (self) {
		self.valuePicker.dataSource = dataSource;
		self.valuePicker.delegate = delegate;
	}
	return self;
}

- (id)valueToSend
{
	return RACTuplePack(@([self.valuePicker selectedRowInComponent:0]),
						self.valuesArray[[self.valuePicker selectedRowInComponent:0]]);
}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.valuesArray count];
}

#pragma mark UIPickerViewDelegate Implementation

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *value = [self.valuesArray objectAtIndex:row];
	return value;
}

@end
