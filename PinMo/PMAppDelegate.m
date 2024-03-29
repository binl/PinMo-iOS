//
//  PMAppDelegate.m
//  PinMo
//
//  Created by Bin Liu on 13-9-21.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "PMAppDelegate.h"
#import "PMUserGeoManager.h"
@implementation PMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8], UITextAttributeTextColor,
                                                           [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8],UITextAttributeTextShadowColor,
                                                           //[NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                                           [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0], UITextAttributeFont, nil]];
    
    UIImage *barButtonImage = [[UIImage imageNamed:@"navBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:200.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:0.8], UITextAttributeTextColor,
                                                          [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8],UITextAttributeTextShadowColor,
                                                          [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:17.0], UITextAttributeFont, nil]
                                                forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];

    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
    tabBarItem1.title = @"";
    tabBarItem2.title = @"";
    tabBarItem3.title = @"";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"explore_icon_selected.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"explore_icon.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"track_icon_selected.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"track_icon.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"history_icon.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"history_icon.png"]];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    
    [PMUserGeoManager sharedInstance];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
