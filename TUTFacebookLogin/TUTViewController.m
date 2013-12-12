//
//  TUTViewController.m
//  TUTFacebookLogin
//
//  Created by Brad Woodard on 12/12/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

//  ************         NOTES         ************   //
//
//  TUTViewController invokes the AppDelegate to
//  manage the fbSession and retrieve a token
//
//  Declare our instance variables in the interface
//  1. Create our connection to TUTAppDelegate
//  2. Connect to the text view
//  3. Connect to the button properties so we can
//  change the title (or others)
//
//  1. viewDidLoad
//  (a) Allocate and initialize our instance of AppDelegate
//  (b) Call update view (see 2)
//  (c) Check to see if we have an active fbSession
//  If not, alloc and init. Once fbSession exists,
//  we check to see if a token is loaded. If so,
//  we need to call updateView to change the text
//  field and the button.
//
//  2. updateView
//  Set the text field and button title based
//  on whether the fbSession is open or not
//
//  3. loginLogout
//  (a) If there is an active fbSession, close it and
//  discard the token.
//  (b) If there isn't an active fbSession, alloc and
//  init, retrieve the token and update the view
//
//  ************************************************  //

#import "TUTViewController.h"
#import "TUTAppDelegate.h"

@interface TUTViewController ()
{
    TUTAppDelegate  *appDelegate;
    __weak IBOutlet UITextView *mTextNoteOrLink;
    __weak IBOutlet UIButton *mLoginLogoutButton;
}

- (IBAction)loginLogout:(id)sender;

@end

@implementation TUTViewController


#pragma mark - 1
- (void)viewDidLoad
{
    // a
    // Alloc & Init our instance of appDelegate
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // b
    [self updateView];
    
    // c
    if (!appDelegate.fbSession.isOpen) {
        appDelegate.fbSession = [[FBSession alloc] init];
        
        if (appDelegate.fbSession.state == FBSessionStateCreatedTokenLoaded) {
            [appDelegate.fbSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                
                // recurse here to update the button and labels
                [self updateView];
            }];
        }
    }
}


#pragma mark - 2
- (void)updateView
{
    if (appDelegate.fbSession.isOpen) {
        [mLoginLogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
        [mTextNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@", appDelegate.fbSession.accessTokenData.accessToken]];

    } else {
        [mLoginLogoutButton setTitle:@"Login" forState:UIControlStateNormal];
        [mTextNoteOrLink setText:@"Login to create a link to fetch account data"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 3
- (IBAction)loginLogout:(id)sender
{
    // a
    if (appDelegate.fbSession.isOpen) {
        [appDelegate.fbSession closeAndClearTokenInformation];
    } else {
    
    // b
        if (appDelegate.fbSession.state != FBSessionStateCreated) {
            appDelegate.fbSession = [[FBSession alloc] init];
        }
        
        [appDelegate.fbSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self updateView];
        }];
    }
}

@end