//
//  TUTAppDelegate.m
//  TUTFacebookLogin
//
//  Created by Brad Woodard on 12/12/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

//  ************         NOTES         ************   //
//  The native Fb app transitions back to the
//  authenticating application when the user chooses
//  to either login or cancel. The url that is passed
//  back on a successful login contains the token.
//
//  1.  application:openURL:sourceApplication:annotation
//  returns NO if the application can't open. If the
//  app does open, then we implement
//  handleOpenURL:sourceApplication:withSession: so
//  we can parse the returned URL and capture the
//  Fb token from fbSession.
//
//  2.  In applicationDidBecomeActive we want to
//  confirm that the app has launched (a) and fetch
//  data (b). handleDidBecomeActiveWithSession: should
//  only be called after any launching URL has been
//  processed that is why it is called in
//  applicationDidBecomeActive.
//
//  3.  Close the fbSession when the app terminates.
//  ************************************************  //

#import "TUTAppDelegate.h"

@implementation TUTAppDelegate
@synthesize fbSession = _fbSession;

#pragma mark - 1
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:(NSURL *)url
                  sourceApplication:(NSString *)sourceApplication
                        withSession:self.fbSession];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
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

#pragma mark - 2
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActiveWithSession:self.fbSession];
}


#pragma mark - 3
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate.
    [self.fbSession close];
}

@end
