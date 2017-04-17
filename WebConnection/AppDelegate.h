//
//  AppDelegate.h
//  WebConnection
//
//  Created by Prasanna on 12/04/17.
//  Copyright © 2017 Prasanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)showAlertViewWithMessage:(NSString *)message WithTitle:(NSString *)title cancelButton:(NSString *)cancelButton;


@end

