//
//  TableViewController.h
//  twitchVLC
//
//  Created by Tomás Migone on 11/2/13.
//  Copyright (c) 2013 Tomás Migone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "stream.h"
#import "twitchLauncher.h"

@interface TableViewController : NSObject <NSTableViewDataSource>
{
@private
    IBOutlet NSTableView *tableView;
    NSMutableArray *list;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

@end
