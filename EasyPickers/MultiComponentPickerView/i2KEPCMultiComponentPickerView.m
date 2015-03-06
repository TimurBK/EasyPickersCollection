//
//  MultiComponentPickerView.m
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 28.02.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCMultiComponentPickerView.h"
#import <ReactiveCocoa.h>

@interface i2KEPCMultiComponentPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIPickerView *valuePicker;
@property (nonatomic, strong) NSArray *valuesArray;

@end

@implementation i2KEPCMultiComponentPickerView

- (instancetype)initWithTitle:(NSString *)title
				  valuesArray:(NSArray *)valuesArray
		  initialValueIndexes:(NSArray *)initialValueIndexes
{
	NSAssert([valuesArray count] == [initialValueIndexes count],
			 @"Values array count should be equal to initialValueIndexes count");
	self = [super initWithTitle:title];
	if (self) {
		self.valuesArray = valuesArray;
		[initialValueIndexes enumerateObjectsUsingBlock:^(NSNumber *selectedIndex, NSUInteger idx, BOOL *stop) {
			[self.valuePicker selectRow:[selectedIndex integerValue] inComponent:idx animated:NO];
		}];
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
	NSMutableArray *indexesArray = [NSMutableArray array];
	NSMutableArray *valuesArray = [NSMutableArray array];
	NSInteger componentsCount = [self.valuePicker numberOfComponents];
	for (NSInteger idx = 0; idx < componentsCount; idx++) {
		[indexesArray addObject:@([self.valuePicker selectedRowInComponent:idx])];
		id value = self.valuesArray[idx][[self.valuePicker selectedRowInComponent:idx]];
		if (value != nil) {
			[valuesArray addObject:value];
		}
	}
	return RACTuplePack(indexesArray, valuesArray);
}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return [self.valuesArray count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.valuesArray[component] count];
}

#pragma mark UIPickerViewDelegate Implementation

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *value = [self.valuesArray[component] objectAtIndex:row];
	return value;
}

@end
