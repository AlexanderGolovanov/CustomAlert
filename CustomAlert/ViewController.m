//
//  ViewController.m
//  CustomAlert
//
//  Created by admin on 30.05.17.
//  Copyright © 2017 ag. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
    
}

- (IBAction)showModal:(id)sender {
    CustomAlertView *alertView=[CustomAlertView alertWithTitle:@"Information" message:@"This is sample message placeholder"];
    [alertView setTitleFont:[UIFont boldSystemFontOfSize:24]];
    [alertView setHeaderBackgroudColor:[UIColor colorWithRed:52 / 255.0 green:152 / 255.0 blue:219 / 255.0 alpha:1.0]];
    [alertView setMessageColor:[UIColor whiteColor]];
    alertView.alertBackgroundColor = [UIColor colorWithRed:41 / 255.0 green:128 / 255.0 blue:185 / 255.0 alpha:1.0];
    alertView.titleColor = [UIColor whiteColor];
    alertView.separatorColor = [UIColor whiteColor];
    [alertView addButtonWithTitle:@"Cancel" foregroundColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] withActionBlock:^{
        NSLog(@"Cancel");
    }];
    [alertView addButtonWithTitle:@"Ok" foregroundColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]  withActionBlock:^{
        NSLog(@"Ok");
    }];

    
    [alertView show];
    
}
- (IBAction)showAnotherModal:(id)sender {
    CustomAlertView *alertView=[CustomAlertView alertWithTitle:@"Error" message:@"This is sample message placeholder"];
    [alertView setTitleFont:[UIFont boldSystemFontOfSize:30]];
    [alertView setTitleColor:[UIColor darkGrayColor]];
    [alertView setMessageColor:[UIColor greenColor]]; 
    

    
    [alertView show];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
