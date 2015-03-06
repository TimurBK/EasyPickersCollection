//
//  ViewController.m
//  EasyPickersSample
//
//  Created by Timur Kuchkarov on 06.03.15.
//  Copyright (c) 2015 i-2K. All rights reserved.
//

#import "ViewController.h"
#import "i2KEPCSingleComponentPickerView.h"
#import "i2KEPCMultiComponentPickerView.h"
#import <ReactiveCocoa.h>

#import "i2KEPCDatePickerView.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *datePickerButton;
@property (nonatomic, weak) IBOutlet UIButton *singlePickerButton;
@property (nonatomic, weak) IBOutlet UIButton *singlePickerWithDelegateButton;
@property (nonatomic, weak) IBOutlet UIButton *multiPickerButton;
@property (nonatomic, weak) IBOutlet UIButton *multiPickerWithDelegateButton;

@property (nonatomic, weak) i2KEPCSingleComponentPickerView *singleComponentPicker;
@property (nonatomic, weak) i2KEPCMultiComponentPickerView *multiComponentPicker;

@property (nonatomic, strong) NSArray *singleComponentPickerValues;
@property (nonatomic, strong) NSArray *multiComponentPickerValues;

@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, strong) NSString *selectedValueSingle;
@property (nonatomic, assign) NSInteger selectedIndexSingle;

@property (nonatomic, strong) NSString *selectedValueSingleDelegated;
@property (nonatomic, assign) NSInteger selectedIndexSingleDelegated;

@property (nonatomic, strong) NSArray *selectedValuesMulti;
@property (nonatomic, strong) NSArray *selectedIndexesMulti;

@property (nonatomic, strong) NSMutableArray *selectedValuesMultiDelegated;
@property (nonatomic, strong) NSMutableArray *selectedIndexesMultiDelegated;

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *singleComponentLabel;
@property (nonatomic, weak) IBOutlet UILabel *delegatedSingleComponentLabel;
@property (nonatomic, weak) IBOutlet UILabel *multiComponentLabel;
@property (nonatomic, weak) IBOutlet UILabel *delegatedMultiComponentLabel;

@end

@implementation ViewController

- (void)configureButtons
{
	@weakify(self);
	self.datePickerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
		return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			@strongify(self);
			i2KEPCDatePickerView *datePicker = [[i2KEPCDatePickerView alloc] initWithTitle:@"Nice title"
																			   currentDate:[NSDate date]
																				pickerMode:UIDatePickerModeDate
																			  pickerLocale:[NSLocale currentLocale]];

			RAC(self, selectedDate) = [datePicker valueSignal];

			[datePicker showPicker];

			[subscriber sendCompleted];
			return nil;
		}];
	}];

	self.singlePickerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
		return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			i2KEPCSingleComponentPickerView *singleComponentPickerView = [[i2KEPCSingleComponentPickerView alloc]
					initWithTitle:@"Values"
					  valuesArray:@[ @"Qwerty", @"Asdf", @"Password", @"Admin", @"Test" ]
				initialValueIndex:self.selectedIndexSingle];

			[[singleComponentPickerView valueSignal] subscribeNext:^(RACTuple *x) {
				@strongify(self);
				self.selectedIndexSingle = [x.first integerValue];
				self.selectedValueSingle = x.second;
			}];

			[singleComponentPickerView showPicker];

			[subscriber sendCompleted];
			return nil;
		}];
	}];

	self.singlePickerWithDelegateButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
		return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
			@strongify(self);
			i2KEPCSingleComponentPickerView *singlePickerWithDelegate =
				[[i2KEPCSingleComponentPickerView alloc] initWithTitle:@"Delegated" dataSource:self delegate:self];

			self.singleComponentPicker = singlePickerWithDelegate;
			[singlePickerWithDelegate showPicker];
			[singlePickerWithDelegate.valuePicker selectRow:self.selectedIndexSingleDelegated
												inComponent:0
												   animated:NO];

			[[singlePickerWithDelegate valueSignal] subscribeNext:^(RACTuple *x) {
				@strongify(self);
				NSInteger row = [x.first integerValue];
				self.selectedValueSingleDelegated = self.singleComponentPickerValues[row];
				self.selectedIndexSingleDelegated = row;
			}];

			[subscriber sendCompleted];
			return nil;
		}];
	}];

	self.multiPickerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
		return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {

			i2KEPCMultiComponentPickerView *picker = [[i2KEPCMultiComponentPickerView alloc]
					  initWithTitle:@"Multi picker"
						valuesArray:
							@[ @[ @"Test11", @"Test12", @"Test13", @"Test14" ], @[ @"Test21", @"Test22", @"Test23" ] ]
				initialValueIndexes:self.selectedIndexesMulti];

			[[picker valueSignal] subscribeNext:^(RACTuple *x) {
				@strongify(self);
				self.selectedIndexesMulti = [x.first mutableCopy];
				self.selectedValuesMulti = [x.second mutableCopy];
			}];

			[picker showPicker];

			[subscriber sendCompleted];
			return nil;
		}];
	}];

	self.multiPickerWithDelegateButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
		return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {

			i2KEPCMultiComponentPickerView *picker =
				[[i2KEPCMultiComponentPickerView alloc] initWithTitle:@"Delegated multi" dataSource:self delegate:self];
			self.multiComponentPicker = picker;
			[picker showPicker];

			[self.selectedIndexesMultiDelegated
				enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
					[picker.valuePicker selectRow:[obj integerValue] inComponent:idx animated:NO];
				}];

			[[picker valueSignal] subscribeNext:^(RACTuple *x) {
				@strongify(self);
				self.selectedIndexesMultiDelegated = [x.first mutableCopy];

				NSMutableString *string = [NSMutableString stringWithFormat:@"MD:"];
				[self.selectedIndexesMultiDelegated
					enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
						[string appendFormat:@"[%@, %@]%@, ", @(idx), obj,
											 self.multiComponentPickerValues[idx][[obj integerValue]]];
					}];
				self.delegatedMultiComponentLabel.text = string;
			}];
			[subscriber sendCompleted];
			return nil;
		}];
	}];
}

- (void)configureLabels
{
	@weakify(self);

	RAC(self.singleComponentLabel, text) = [RACObserve(self, selectedValueSingle) map:^id(NSString *value) {
		@strongify(self);
		return [NSString stringWithFormat:@"Single:[%@]%@", @(self.selectedIndexSingle), self.selectedValueSingle];
	}];

	RAC(self.dateLabel, text) = [RACObserve(self, selectedDate) map:^id(NSDate *value) { return [value description]; }];

	RAC(self.delegatedSingleComponentLabel, text) = [RACObserve(self, selectedIndexSingleDelegated) map:^id(id value) {
		return [NSString stringWithFormat:@"Single delegated:[%@]%@", @(self.selectedIndexSingleDelegated),
										  self.selectedValueSingleDelegated];
	}];

	RAC(self.multiComponentLabel, text) = [RACObserve(self, selectedValuesMulti) map:^id(id value) {
		@strongify(self);
		NSMutableString *string = [NSMutableString stringWithFormat:@"Multi: "];
		[self.selectedIndexesMulti enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
			[string appendFormat:@"[%@, %@]%@, ", @(idx), obj, self.selectedValuesMulti[idx]];
		}];
		return string;
	}];
}

- (void)configureInitialValues
{
	self.singleComponentPickerValues = @[ @"String1", @"String2", @"String3", @"String4" ];
	self.multiComponentPickerValues =
		@[ @[ @"Obj11", @"Obj12", @"Obj13" ], @[ @"Obj21", @"Obj22" ], @[ @"Obj31", @"Obj32", @"Obj33", @"Obj34" ] ];
	self.selectedIndexSingle = 1;
	self.selectedIndexSingleDelegated = 2;
	self.selectedIndexesMulti = @[ @1, @0 ];
	self.selectedIndexesMultiDelegated = [@[ @1, @0, @2 ] mutableCopy];
	self.selectedValuesMultiDelegated = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self configureInitialValues];
	[self configureLabels];
	[self configureButtons];
}

#pragma mark - UIPickerViewDataSource Implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	if (pickerView == self.multiComponentPicker.valuePicker) {
		return [self.multiComponentPickerValues count];
	}
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerView == self.singleComponentPicker.valuePicker) {
		return [self.singleComponentPickerValues count];
	} else if (pickerView == self.multiComponentPicker.valuePicker) {
		return [self.multiComponentPickerValues[component] count];
	}
	return 0;
}

#pragma mark UIPickerViewDelegate Implementation

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView == self.singleComponentPicker.valuePicker) {
		return self.singleComponentPickerValues[row];
	} else if (pickerView == self.multiComponentPicker.valuePicker) {
		return self.multiComponentPickerValues[component][row];
	}
	return @"----------";
}

@end
