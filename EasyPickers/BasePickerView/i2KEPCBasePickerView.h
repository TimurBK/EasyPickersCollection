//
//  BasePickerView.h
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 02.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface i2KEPCBasePickerView : UIView

/**
 *  Init picker with title.
 *
 *  @param title Title to display above values.
 *
 *  @return Initialized picker ready for display.
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 *  Presents picker.
 */
- (void)showPicker;

/**
 *  Dismisses current picker.
 */
- (void)dismissPicker;

/**
 *  This signal sends selected value on picker dismissal or nil if delegate is set for subclasses.
 *
 *  @return Signal which sends selected value on picker dismissal.
 */
- (RACSignal *)valueSignal;

/**
 *  Background image of picker view.
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 *  Confirm button image for Normal state.
 */
@property (nonatomic, strong) UIImage *confirmButtonImage;

/**
 *  Selected state image for confirm button.
 */
@property (nonatomic, strong) UIImage *selectedConfirmButtonImage;

/**
 *  Highlighted state image for confirm button.
 */
@property (nonatomic, strong) UIImage *highlightedConfirmButtonImage;

@end

@interface i2KEPCBasePickerView (Subclassing)

/**
 *  This method is called when confirm button is tapped. Gets current value if available and sends it via `valueSignal`.
 *
 *  @return Currently selected value, depending on subclass, nil by default.
 */
- (id)valueToSend;

@end
