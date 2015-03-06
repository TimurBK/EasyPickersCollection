//
//  DatePickerView.m
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 04.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCDatePickerView.h"

@interface i2KEPCDatePickerView ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation i2KEPCDatePickerView

- (instancetype)initWithTitle:(NSString *)title
				  currentDate:(NSDate *)currentDate
				  minimumDate:(NSDate *)minimumDate
				  maximumDate:(NSDate *)maximumDate
				   pickerMode:(UIDatePickerMode)datePickerMode
				 pickerLocale:(NSLocale *)locale
{
	self = [super initWithTitle:title];
	if (self) {
		if (!currentDate) {
			currentDate = [NSDate date];
		}
		self.datePicker.minimumDate = minimumDate;
		self.datePicker.maximumDate = maximumDate;
		self.datePicker.date = currentDate;
		self.datePicker.datePickerMode = datePickerMode;
		self.datePicker.locale = locale;
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)title
				  currentDate:(NSDate *)currentDate
				   pickerMode:(UIDatePickerMode)datePickerMode
				 pickerLocale:(NSLocale *)locale
{
	return [self initWithTitle:title
				   currentDate:currentDate
				   minimumDate:[NSDate distantPast]
				   maximumDate:[NSDate distantFuture]
					pickerMode:datePickerMode
				  pickerLocale:locale];
}

- (id)valueToSend
{
	return self.datePicker.date;
}

@end
