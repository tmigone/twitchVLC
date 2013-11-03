//
//  twitchLauncher.m
//  twitchVLC
//
//  Created by Tomás Migone on 10/17/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import "twitchLauncher.h"

@implementation twitchLauncher


-(id)initWithdefaultValues
{
    self = [super init];
    
    self.list = [[NSMutableArray alloc] init];
    self.channelName = nil;
    self.token = nil;
    self.signature = nil;
    
    self.tempM3U8 = nil;

    
    return self;
    
}

+(NSMutableArray*)getAvailableStreams
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@", @"https://api.twitch.tv/kraken/search/streams?limit=15&q=%22starcraft%22"];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *result;
    NSError *error = nil;
    
    NSMutableArray* list = [[NSMutableArray alloc] init];
    
    if(jsonData != nil)
    {
        result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        for(int i = 0; i<14; i++)
        {
            Stream *s = [[Stream alloc] init];
            [s setName:result[@"streams"][i][@"channel"][@"name"]];
            [s setViewerCount:(NSInteger)result[@"streams"][i][@"viewers"]];
            [list addObject:s];
        }

    }
    
    return list;
}

-(NSError*)getStreamParameters
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", @"http://api.twitch.tv/api/channels/", self.channelName, @"/access_token"];
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *result;
    NSError *error = nil;

    if(jsonData != nil)
    {
        result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if(error==nil)
        {
            self.token=result[@"token"];
            self.signature=result[@"sig"];
        }
    }
    
    return error;
}



-(NSError*)getM3U8
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"http://usher.twitch.tv/api/channel/hls/", self.channelName, @".m3u8?token=", self.token, @"&sig=", self.signature];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSData *pageContents = [NSData dataWithContentsOfURL:url];
    
    NSError *error = nil;
    
    if(pageContents!=nil)
    {
        self.tempM3U8 = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.m3u8"];

        
        //NSString *path = [NSString stringWithFormat:@"%@%@%@", ];//@"/Users/tomi/Desktop/test.m3u8";
        [pageContents writeToFile:self.tempM3U8 options:NSDataWritingAtomic error:&error];
    }
    
    return error;
}

/*
-(void)parseM3U8
{
    NSString * fileContents = [NSString stringWithContentsOfFile:@"/Users/tomi/Desktop/test.m3u8" encoding:NSUTF8StringEncoding error:nil];
    
    //id variable = [M3U8Parser m3u8SegmentInfoListFromPlanString:fileContents baseURL:nil];
    
}

 */
-(void)launchVLC
{
    [[NSWorkspace sharedWorkspace] openFile:self.tempM3U8 withApplication:@"VLC"];
}




@end
