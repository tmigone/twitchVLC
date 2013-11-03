//
//  TableViewController.m
//  twitchVLC
//
//  Created by Tomás Migone on 11/2/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

-(id)init
{
    self = [super init];
    list = [[NSMutableArray alloc] init];
    
    return self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [list count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Stream *s = [list objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    
    return [s valueForKey:identifier];
}


-(IBAction)add:(id)sender
{
    list = [twitchLauncher getAvailableStreams];
    [tableView reloadData];
}

@end
