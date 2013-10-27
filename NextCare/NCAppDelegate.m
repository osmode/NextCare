//
//  NCAppDelegate.m
//  NextCare
//
//  Created by Omar Metwally on 10/24/13.
//  Copyright (c) 2013 Novartis Hackathon. All rights reserved.
//

#import "NCAppDelegate.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"
#import "RegisterViewController.h"
#import "ToDoTableViewController.h"
#import "TeamListTableViewController.h"


@implementation NCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LoginViewController *lvc = [[LoginViewController alloc] init];
    DashboardViewController *dvc = [[DashboardViewController alloc] init];
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    ToDoTableViewController *ttvc = [[ToDoTableViewController alloc] init];
    TeamListTableViewController *tltvc = [[TeamListTableViewController alloc] init];
    
    UINavigationController *loginNavController = [[UINavigationController alloc] initWithRootViewController:lvc];
    //UINavigationController *dashboardNavController = [[UINavigationController alloc] initWithRootViewController:dvc];
    //UINavigationController *registerNavController = [[UINavigationController alloc] initWithRootViewController:rvc];
    UINavigationController *ttvcNavController = [[UINavigationController alloc] initWithRootViewController:ttvc];
    UINavigationController *teamNavController = [[UINavigationController alloc] initWithRootViewController:tltvc];

    UITabBarItem *loginButton = [lvc tabBarItem];
    //UITabBarItem *dashboardButton = [dvc tabBarItem];
    //UITabBarItem *registerButton = [rvc tabBarItem];
    UITabBarItem *todoButton = [ttvc tabBarItem];
    UITabBarItem *teamButton = [tltvc tabBarItem];
    
    [loginButton setTitle:@"Login"];
    [loginButton setImage:[UIImage imageNamed:@"home.png"]];
    //[dashboardButton setTitle:@"Dashboard"];
    //[dashboardButton setImage:[UIImage imageNamed:@"tracker.png"]];
    //[registerButton setTitle:@"Register"];
    [todoButton setTitle:@"Todo List"];
    [todoButton setImage:[UIImage imageNamed:@"diary.png"]];
    [teamButton setTitle:@"Team"];
    [teamButton setImage:[UIImage imageNamed:@"diary.png"]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    NSArray *viewControllers = [NSArray arrayWithObjects: loginNavController, ttvcNavController, teamNavController, nil];
    [tabBarController setViewControllers:viewControllers];
    
    [[self window] setRootViewController:tabBarController];
    
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
