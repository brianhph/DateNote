//
//  myEvent.m
//  DateNote
//
//  Created by Brian Huang on 7/19/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "myEvent.h"
#import "SqlData.h"

@implementation myEvent

-(NSMutableArray *)getMyEvent :(NSDate *)time :(NSInteger)count :(NSInteger)pg :(NSString *)catid {
    NSString *cmd = @"select * from myEvent";
    NSMutableArray *result = [SqlData select:cmd];
    
    return result;
}

@end
