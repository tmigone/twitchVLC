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
    twitchLauncher *launcher = [[twitchLauncher alloc] init];
    [launcher defaultValues];
    [launcher getJSON];
    [launcher getM3U8];
    [launcher parseM3U8];
    //[launcher launchVLC];
    
}

@end

@implementation twitchLauncher
-(void)defaultValues
{
    channelName = @"idrajit";
}

-(void)getJSON
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", @"http://api.twitch.tv/api/channels/", channelName, @"/access_token"];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    if(jsonData != nil)
    {
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil)
        {
            token = result[@"token"];
            signature = result[@"sig"];
        }
    }
}

-(void)getM3U8
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"http://usher.twitch.tv/api/channel/hls/", channelName, @".m3u8?token=", token, @"&sig=", signature];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    
    NSData *pageContents = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    NSString *path=@"/Users/tomi/Desktop/test.m3u8";
    [pageContents writeToFile:path options:NSDataWritingAtomic error:&error];
    
}

-(void)parseM3U8
{
    NSString * fileContents = [NSString stringWithContentsOfFile:@"/Users/tomi/Desktop/test.m3u8" encoding:NSUTF8StringEncoding error:nil];
    
    //id variable = [M3U8Parser m3u8SegmentInfoListFromPlanString:fileContents baseURL:nil];
    
}
-(void)launchVLC
{
    [[NSWorkspace sharedWorkspace] openFile:@"/Users/tomi/Desktop/test.m3u8" withApplication:@"VLC"];
}

@end
