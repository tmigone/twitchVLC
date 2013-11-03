//
//  twitchLauncher.h
//  twitchVLC
//
//  Created by Tomás Migone on 10/17/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stream.h"

@interface twitchLauncher : NSObject

@property   NSString *channelName;
@property   NSString *token;
@property   NSString *signature;
@property   NSString *tempM3U8;
@property   NSMutableArray *list;


-(id)initWithdefaultValues;


+(NSMutableArray*)getAvailableStreams;
-(NSError*)getStreamParameters;
-(NSError*)getM3U8;

-(void)parseM3U8;
-(void)launchVLC;

@end
