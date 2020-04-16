//
//  AppDelegate.m
//  MyQrCode
//
//  Created by Zhang on 2020/4/16.
//  Copyright © 2020 June. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[HomeViewController alloc] init];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
