//
//  MultiComponentPickerView.h
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 28.02.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCBasePickerView.h"

@interface i2KEPCMultiComponentPickerView : i2KEPCBasePickerView

@property (nonatomic, readonly, weak) UIPickerView *valuePicker;

/**
 *  Value signal in this subclass sends tuple of arrays where array index represents corresponding component with
 *  first element of tuple representing array of selected rows and second element of tuple representing array of
 *  selected titles on picker dismissal if delegate is not set or nil if set.
 */

/**
 *  Initialize picker
 *
 *  @param title                Title to show above picker.
 *  @param valuesArray          Array of arrays of NSStrings.
 *  @param initialValueIndexes  Initial selected indexes.
 *
 *  @return Initialized picker ready for presenting.
 */
- (instancetype)initWithTitle:(NSString *)title
				  valuesArray:(NSArray *)valuesArray
		  initialValueIndexes:(NSArray *)initialValueIndexes;

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
