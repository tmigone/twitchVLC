//
//  AppDelegate.h
//  twitchVLC
//
//  Created by Tomás Migone on 10/17/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "twitchLauncher.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

-(IBAction)buttonPress:(id)sender;

@end
