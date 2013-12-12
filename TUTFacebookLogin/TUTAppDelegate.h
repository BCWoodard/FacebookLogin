//
//  TUTAppDelegate.h
//  TUTFacebookLogin
//
//  Created by Brad Woodard on 12/12/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

//  ************         NOTES         ************   //
//  I want TUTAppDelegate to maintain a FBSession object
//  that is accessible during an active session. To do this
//  I do the following:
//  1.  Import FacebookSDK
//  2.  Declare a public FBSession object called fbSession
//
//  ************************************************   //

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h> // 1

@interface TUTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow  *window;
@property (strong, nonatomic) FBSession *fbSession; // 2

@end
