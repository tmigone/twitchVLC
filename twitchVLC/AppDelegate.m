//
//  AppDelegate.m
//  twitchVLC
//
//  Created by Tomás Migone on 10/17/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    

    
}

-(IBAction)buttonPress:(id)sender
{

    twitchLauncher *launcher = [[twitchLauncher alloc] initWithdefaultValues];

    NSError *paramError = [launcher getStreamParameters];
    
    if(paramError == nil)
    {
        NSError *M3U8error = [launcher getM3U8];
        
        if(M3U8error == nil)
        {
            [launcher launchVLC];
        }
        //[launcher parseM3U8];
        //[launcher launchVLC];
    }

    
}

@end
