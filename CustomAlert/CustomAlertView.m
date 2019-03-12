//
//  CustomAlertView.m
//  CustomAlert
//
//  Created by admin on 30.05.17.
//  Copyright © 2017 ag. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView()

@property (nonatomic, strong) UIView *alertBackground;
@property (nonatomic, strong) UIVisualEffectView *backgroundVisualEffectView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *buttonsBorder;
@property (nonatomic, strong) UIView *betweenBtnBorder;
@property (nonatomic, strong) NSMutableArray *alertButtons;

@end

@implementation CustomAlertView

@synthesize titleFont = _titleFont;
@synthesize titleColor = _titleColor;

@synthesize messageFont=_messageFont;
@synthesize messageColor=_messageColor;
@synthesize headerBackgroudColor=_headerBackgroudColor;
@synthesize alertBackgroundColor = _alertBackgroundColor;
@synthesize separatorColor = _separatorColor;

+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message{
    
    CustomAlertView *alertView = [[super alloc] init];
    
    if (alertView) {
        alertView.titleLabel.text=title;
        alertView.messageLabel.text=message;
    }
    return alertView;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        self.backgroundColor=[UIColor clearColor];
        
        self.alertBackground=[UIView new];
        self.alertBackground.frame=self.bounds;
        self.alertBackground.backgroundColor=[UIColor colorWithWhite:0.0f alpha:0.30];
        [self addSubview:self.alertBackground];
        
        
        self.alertView=[UIView new];
        self.alertView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.alertView];
        self.alertView.layer.cornerRadius=10;
        self.alertView.clipsToBounds=YES;
        self.alertView.translatesAutoresizingMaskIntoConstraints=NO;
     
        self.titleView=[UIView new];
        self.titleView.backgroundColor=self.headerBackgroudColor;
        [self addSubview:self.alertView];
        self.titleView.clipsToBounds=YES;
        self.titleView.translatesAutoresizingMaskIntoConstraints=NO;
        [self.alertView addSubview:self.titleView];

        
        self.titleLabel=[UILabel new];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=self.titleFont;
        self.titleLabel.textColor=self.titleColor;
        [self.titleView addSubview:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        
        self.messageLabel=[UILabel new];
        self.messageLabel.textAlignment=NSTextAlignmentCenter;
        self.messageLabel.font=[UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        self.messageLabel.numberOfLines=0;
        self.messageLabel.lineBreakMode=NSLineBreakByWordWrapping;
        [self addSubview:self.messageLabel];
        self.messageLabel.translatesAutoresizingMaskIntoConstraints=NO;

        
        self.buttonsBorder=[UIView new];
        self.buttonsBorder.backgroundColor=[UIColor colorWithWhite:10.0f/255.0f alpha:0.2];
        [self addSubview:self.buttonsBorder];
        self.buttonsBorder.translatesAutoresizingMaskIntoConstraints=NO;
        
        self.alertButtons=[NSMutableArray new];
        self.alpha=0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
        
    }
    return self;
}

- (void)orientationChanged:(NSNotification *)notification{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    self.alertBackground.frame=self.bounds;
    [self updateConstraints];
    [self layoutIfNeeded];

}

-(void)addButtonWithTitle:(NSString *)title withActionBlock:(void (^)(void))action{
    [self addButtonWithTitle:title foregroundColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] withActionBlock:action];
    
}

-(void)addButtonWithTitle:(NSString *)title foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor withActionBlock:(void (^)(void))action{
    
    if (self.alertButtons.count < 2) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:foregroundColor forState:UIControlStateNormal];
        [button setBackgroundColor:backgroundColor];
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=self.alertButtons.count;
        [self.alertView addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints=NO;
        button.clipsToBounds=YES;
        [self.alertButtons addObject:@{@"button" : button,
                                       @"action" : action}];
    }
    
}

-(void)show{
    
    if (self.alertButtons.count == 0) {
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        doneButton.translatesAutoresizingMaskIntoConstraints=NO;
        [doneButton setTitle:@"Ok" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        doneButton.tag=self.alertButtons.count;
        doneButton.clipsToBounds=YES;
        [self.alertView addSubview:doneButton];
        [self.alertButtons addObject:@{@"button" : doneButton,
                                       @"action" : @0}];
    }
    else if (self.alertButtons.count > 1){
        
        self.betweenBtnBorder=[UIView new];
        self.betweenBtnBorder.backgroundColor = self.separatorColor; //[UIColor colorWithWhite:10.0f/255.0f alpha:0.2];
        self.betweenBtnBorder.translatesAutoresizingMaskIntoConstraints=NO;
        [self.alertView addSubview:self.betweenBtnBorder];

        
    }
//    if (1==0){
//        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        self.backgroundVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        self.backgroundVisualEffectView.frame = self.bounds;
//        self.alertBackground.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
//        [self insertSubview:self.backgroundVisualEffectView belowSubview:self.alertView];      
//
//    }
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    // Adding Alert
    [window addSubview:self];
    [window bringSubviewToFront:self];
   
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
   
     
    } completion:^(BOOL finished) {
       
    }];
}


- (void) dismiss {
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.backgroundVisualEffectView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
- (void)handleButton:(id)sender {
    
    NSDictionary *btnDict = [self.alertButtons objectAtIndex:[sender tag]];
    
    if (btnDict != nil) {
        if ([btnDict objectForKey:@"action"] != nil && ![[btnDict objectForKey:@"action"] isEqual:@0]) {
            void (^block)(void) = [btnDict objectForKey:@"action"];
            if (block)
                block();
        }
    }
    
    [self dismiss];
}

-(UIFont *)titleFont{
    if (!_titleFont){
        _titleFont= [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];        
    }
    return _titleFont;
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    self.titleLabel.font=_titleFont;
}

-(UIColor *)titleColor{
    if (!_titleColor){
        _titleColor=[UIColor blackColor];
    }
    return _titleColor;
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor=titleColor;
    self.titleLabel.textColor=_titleColor;
}

-(UIFont *)messageFont{
    if (!_messageFont){
        _messageFont= [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
    }
    return _messageFont;
}

-(void)setMessageFont:(UIFont *)messageFont{
    _messageFont=messageFont;
    self.messageLabel.font=_messageFont;
}

-(UIColor *)messageColor{
    if (!_messageColor){
        _messageColor=[UIColor blackColor];
    }
    return _messageColor;
}

-(void)setMessageColor:(UIColor *)messageColor{
    _messageColor=messageColor;
    self.messageLabel.textColor=_messageColor;
}

-(UIColor *)headerBackgroudColor{
    if (!_headerBackgroudColor){
        _headerBackgroudColor=[UIColor whiteColor];
    }
    return _headerBackgroudColor;
}

-(void)setHeaderBackgroudColor:(UIColor *)titleBackgroudColor{
    _headerBackgroudColor=titleBackgroudColor;
    self.titleView.backgroundColor=titleBackgroudColor;
}

- (void)setAlertBackgroundColor:(UIColor *)alertBackgroundColor {
    _alertBackgroundColor = alertBackgroundColor;
    self.alertView.backgroundColor = alertBackgroundColor;
    if ([self.headerBackgroudColor isEqual:[UIColor whiteColor]]) {
        self.headerBackgroudColor = alertBackgroundColor;
    }
}

- (UIColor *)alertBackgroundColor {
    if (!_alertBackgroundColor) {
        _alertBackgroundColor = [UIColor clearColor];
    }
    return _alertBackgroundColor;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    _buttonsBorder.backgroundColor = separatorColor;
    _betweenBtnBorder.backgroundColor = separatorColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor colorWithWhite:10.0f/255.0f alpha:0.2];
    }
    return _separatorColor;
}

-(void)updateConstraints{
   
    //Body
    NSLayoutConstraint *centerYAlertView=[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *trailingAlertView=[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    
    NSLayoutConstraint *leadingAlertView=[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    
    NSLayoutConstraint *heightAlertView=[NSLayoutConstraint constraintWithItem:self.alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:120];
    heightAlertView.priority=800;
    
    //TitleView
    
    NSLayoutConstraint *trailingTitleView=[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *leadingTitleView=[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topTitleView=[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    
    //Title Label
    NSLayoutConstraint *heightTitle=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30];
    
    NSLayoutConstraint *trailingTitle=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    
    NSLayoutConstraint *leadingTitle=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    
    NSLayoutConstraint *topTitle=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    
    NSLayoutConstraint *bottomTitle=[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    
    
    //Message
    NSLayoutConstraint *trailingMessage=[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    
    NSLayoutConstraint *leadingMessage=[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    
    NSLayoutConstraint *topMessage=[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
    
    NSLayoutConstraint *bottomMessage=[NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.alertView attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
    
    NSLayoutConstraint *heightMessage = [NSLayoutConstraint constraintWithItem:self.messageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    
    
    //Buttons
    
    NSLayoutConstraint *heightButtonsBorder=[NSLayoutConstraint constraintWithItem:self.buttonsBorder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1];

    NSLayoutConstraint *bottomButtonsBorder=[NSLayoutConstraint constraintWithItem:self.buttonsBorder attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeBottom multiplier:1 constant:-40];
    
    NSLayoutConstraint *widthButtonsBorder=[NSLayoutConstraint constraintWithItem:self.buttonsBorder attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    NSLayoutConstraint *centerXButtonsBorder=[NSLayoutConstraint constraintWithItem:self.buttonsBorder attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [self addConstraints:@[centerYAlertView,trailingAlertView,leadingAlertView,trailingTitle,leadingTitle,topTitle, heightMessage, trailingMessage,leadingMessage,topMessage,bottomMessage,heightButtonsBorder, bottomButtonsBorder, widthButtonsBorder, centerXButtonsBorder,bottomTitle, topTitleView,leadingTitleView,trailingTitleView]];
    
 
    for (NSDictionary *btnDict in self.alertButtons){
        
        UIButton *btn= [btnDict objectForKey:@"button"];
        
        NSLayoutConstraint *heightButton=[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:40];

        
        NSLayoutConstraint *widthButton=[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeWidth multiplier:(CGFloat)1/self.alertButtons.count constant:((self.alertButtons.count>1)?-1:0)];

        NSLayoutConstraint *bottomButton=[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        
        if (self.alertButtons.count>=1){
            
            if ([self.alertButtons indexOfObject:btnDict]==0){
                NSLayoutConstraint *leadingButton=[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
                [self addConstraint:leadingButton];
                
            }else {
                NSLayoutConstraint *trailingButton=[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
                [self addConstraint:trailingButton];
            }

        }

        
        [self addConstraints:@[bottomButton, widthButton]];
        
        [btn addConstraints:@[heightButton]];
    }
    
    if (self.alertButtons.count>1){
        //Between Buttons Border
        NSLayoutConstraint *heightBBBorder=[NSLayoutConstraint constraintWithItem:self.betweenBtnBorder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:36];
        
        NSLayoutConstraint *widthBBBorder=[NSLayoutConstraint constraintWithItem:self.betweenBtnBorder attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:1];
        
        NSLayoutConstraint *centerXBBBorder=[NSLayoutConstraint constraintWithItem:self.betweenBtnBorder attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        
        NSLayoutConstraint *bottomBBBorder=[NSLayoutConstraint constraintWithItem:self.betweenBtnBorder attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.alertView attribute:NSLayoutAttributeBottom multiplier:1 constant:-2];
        
        [self.betweenBtnBorder addConstraints:@[heightBBBorder,widthBBBorder]];
        
        [self addConstraints:@[bottomBBBorder, centerXBBBorder]];
    }
    
    
    [self.alertView addConstraints:@[heightAlertView]];
    [self.titleLabel addConstraints:@[heightTitle]];
 
     
    [super updateConstraints];

}

-(void)dealloc{
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
@end
