//
//  myEvent.h
//  DateNote
//
//  Created by Brian Huang on 7/19/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myEvent : NSObject

-(NSMutableArray *)getMyEvent :(NSDate *)time :(NSInteger)count :(NSInteger)pg :(NSString *)catid;

    

@end
