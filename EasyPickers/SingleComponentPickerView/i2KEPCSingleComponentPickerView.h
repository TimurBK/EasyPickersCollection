//
//  SingleComponentPickerView.h
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 02.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCBasePickerView.h"

@interface i2KEPCSingleComponentPickerView : i2KEPCBasePickerView

@property (nonatomic, readonly, weak) UIPickerView *valuePicker;

/**
 *  Value signal in this subclass sends tuple with first element representing selected row and second element
 *  representing selected title on picker dismissal if delegate is not set or nil if set.
 */

/**
 *  Initialize picker with it acting as data source and delegate.
 *
 *  @param title                Title to show above picker.
 *  @param valuesArray          Array of NSStrings.
 *  @param initialValueIndex    Initial selected index.
 *
 *  @return Initialized picker ready for presenting.
 */
- (instancetype)initWithTitle:(NSString *)title
				  valuesArray:(NSArray *)valuesArray
			initialValueIndex:(NSUInteger)initialValueIndex;

/**
 *  Initialize picker for presentation and
 *
 *  @param title             Title to show above picker.
 *  @param dataSource        Picker data source.
 *  @param delegate          Picker delegate.
 *
 *  @return Initialized picker ready for presenting.
 */
- (instancetype)initWithTitle:(NSString *)title
				   dataSource:(id<UIPickerViewDataSource>)dataSource
					 delegate:(id<UIPickerViewDelegate>)delegate;

@end
