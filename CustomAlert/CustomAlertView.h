//
//  CustomAlertView.h
//  CustomAlert
//
//  Created by admin on 30.05.17.
//  Copyright © 2017 ag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomAlertView : UIView

@property (nonatomic, strong, nonnull) UIFont *titleFont;
@property (nonatomic, strong, nonnull) UIFont *messageFont;
@property (nonatomic, strong, nonnull) UIColor *titleColor;
@property (nonatomic, strong, nonnull) UIColor *messageColor;
@property (nonatomic, strong, nonnull) UIColor *headerBackgroudColor;
@property (nonatomic, strong, nonnull) UIColor *alertBackgroundColor;
@property (nonatomic, strong, nonnull) UIColor *separatorColor;

+ (nonnull instancetype)alertWithTitle:(nonnull NSString *)title message:(nonnull NSString *)message;
- (void)show;

- (void)addButtonWithTitle:(nonnull NSString *)title withActionBlock:(void(^_Nullable)(void))action;
- (void)addButtonWithTitle:(nonnull NSString *)title foregroundColor:(nonnull UIColor *)foregroundColor backgroundColor:(nonnull UIColor *)backgroundColor withActionBlock:(void(^_Nullable)(void))action;

@end
