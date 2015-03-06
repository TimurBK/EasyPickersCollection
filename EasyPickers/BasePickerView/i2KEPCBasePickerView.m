//
//  BasePickerView.m
//  EasyPickersCollection
//
//  Created by Timur Kuchkarov on 02.02.14.
//  Copyright (c) 2014 Timur Kuchkarov. All rights reserved.
//

#import "i2KEPCBasePickerView.h"
#import <ReactiveCocoa.h>
#import "RACEXTScope.h"

@interface i2KEPCBasePickerView ()

@property (nonatomic, weak) IBOutlet UIButton *completeButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UIView *backgroundDimmingView;
@property (nonatomic, strong) RACSubject *valueSubject;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;

@end

@implementation i2KEPCBasePickerView

- (instancetype)initWithTitle:(NSString *)title
{
	self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];

	if (self) {
		[self.titleLabel setText:title];
		self.valueSubject = [RACSubject subject];
		@weakify(self);
		self.completeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
			return [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
				@strongify(self);
				[self hidePicker];
				[subscriber sendCompleted];
				return nil;
			}];
		}];
	}
	return self;
}

- (id)valueToSend
{
	return nil;
}

- (void)showPicker
{
	UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];

	self.backgroundDimmingView = [[UIView alloc] initWithFrame:mainWindow.frame];
	[self.backgroundDimmingView
		addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)]];
	[self.backgroundDimmingView setBackgroundColor:[UIColor colorWithRed:0. green:0. blue:0. alpha:0.3]];

	[self.backgroundDimmingView addSubview:self];
	self.center = self.backgroundDimmingView.center;

	[mainWindow addSubview:self.backgroundDimmingView];
	self.backgroundDimmingView.center = mainWindow.center;
}

- (void)hidePicker
{
	[self.valueSubject sendNext:[self valueToSend]];
	[self dismissPicker];
}

- (RACSignal *)valueSignal
{
	return self.valueSubject;
}

- (void)dismissPicker
{
	[self.backgroundDimmingView removeFromSuperview];
	[self removeFromSuperview];
}

- (UIImage *)backgroundImage
{
	return self.backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
	self.backgroundImageView.image = backgroundImage;
	if (backgroundImage != nil) {
		self.backgroundColor = [UIColor clearColor];
	} else {
		self.backgroundColor = [UIColor whiteColor];
	}
}

- (UIImage *)confirmButtonImage
{
	return [self.completeButton imageForState:UIControlStateNormal];
}

- (void)setConfirmButtonImage:(UIImage *)confirmButtonImage
{
	[self.completeButton setImage:confirmButtonImage forState:UIControlStateNormal];
}

- (UIImage *)selectedConfirmButtonImage
{
	return [self.completeButton imageForState:UIControlStateSelected];
}

- (void)setSelectedConfirmButtonImage:(UIImage *)selectedConfirmButtonImage
{
	[self.completeButton setImage:selectedConfirmButtonImage forState:UIControlStateSelected];
}

- (UIImage *)highlightedConfirmButtonImage
{
	return [self.completeButton imageForState:UIControlStateHighlighted];
}

- (void)setHighlightedConfirmButtonImage:(UIImage *)highlightedConfirmButtonImage
{
	[self.completeButton setImage:highlightedConfirmButtonImage forState:UIControlStateHighlighted];
}

@end
