//
//  DatePickerView.h
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 04.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCBasePickerView.h"

/**
 *  This subclass presents date picker.
 *  Value signal in this subclass sends selected date on picker dismissal.
 */
@interface i2KEPCDatePickerView : i2KEPCBasePickerView

@property (nonatomic, readonly, weak) UIDatePicker *datePicker;

/**
 *  Designated initializer.
 *
 *  @param title                Title to display.
 *  @param currentDate          Date to be selected initially.
 *  @param minimumDate          Minimum date for picker.
 *  @param maximumDate          Maximum date for picker.
 *  @param datePickerMode       Date picker mode.
 *  @param locale				Locale for date picker.
 *
 *  @return Initialized picker view.
 */
- (instancetype)initWithTitle:(NSString *)title
				  currentDate:(NSDate *)currentDate
				  minimumDate:(NSDate *)minimumDate
				  maximumDate:(NSDate *)maximumDate
				   pickerMode:(UIDatePickerMode)datePickerMode
				 pickerLocale:(NSLocale *)locale;

/**
 *  Shortcut method for presenting date picker.
 *
 *  @param title          Title to display.
 *  @param currentDate    Date to be selected initially.
 *  @param datePickerMode Date picker mode.
 *  @param locale         Locale for date picker.
 *
 *  @return Initialized picker view.
 */
- (instancetype)initWithTitle:(NSString *)title
				  currentDate:(NSDate *)currentDate
				   pickerMode:(UIDatePickerMode)datePickerMode
				 pickerLocale:(NSLocale *)locale;

@end
