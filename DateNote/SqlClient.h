//
//  SqlClient.h
//  DateNote
//
//  Created by Jackal Wang on 2015/7/15.
//  Copyright (c) 2015年 EC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqlClient : NSObject

-(void)initDataBase;
-(void)initTempData;
-(void)resetData;
-(NSString *)getTemplateColor;

-(void)insertDetailOneDayEventStartWith:(NSDate *)startTime tilte:(NSString *)title description:(NSString *)description img_url:(NSString *)img_url mt_id:(NSString *)mt_id repeat:(NSString *)repeat;
-(void)insertOneDayEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description;
-(void)insertDayEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id;
-(void)insertWeekEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id;
-(void)insertMonthEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id;
-(void)insertYearEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id;
-(NSString *)getNewDateWith:(NSDate *)startTime day:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;

//templateList
-(NSMutableArray *)getTemplateList;
-(NSMutableArray *)getTemplateListByID:(NSString *)t_id;
-(NSMutableArray *)getNewBornTemplateList;

//templateEventList
-(NSMutableArray *)getTemplateEventListByTID:(NSString *)t_id;

//myEvent
+(NSMutableArray *)getMyEventFrom:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg mt_id:(NSString *)mt_id;
+(NSMutableArray *)getMyEventFrom:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg;
+(NSMutableArray *)getMyPastEvent:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg mt_id:(NSString *)mt_id;
+(NSMutableArray *)getMyPastEvent:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg;
+(NSMutableArray *)getMyEventByDay:(NSDate *)time;
+(NSMutableArray *)getMyEventFrom:(NSDate *)startTime to:(NSDate *)endTime;
+(NSMutableArray *)getMyEventByEventID:(NSString *)me_id;
-(void) deleteMyEventByMyEventID:(NSString *)me_id;
-(void) deleteMyEventByMyTemplateID:(NSString *)mt_id;
-(void) deleteMyEventByRecycleID:(NSString *)r_id;


//myTemplate
+(NSMutableArray *)getMyTemplate;
-(void)insertNewBornTemplateEventWithStartTime:(NSDate *)startTime templateTitle:(NSString *)templateTitle;
-(void)insertTemplateEventWithStartTime:(NSDate *)startTime templateTitle:(NSString *)templateTitle templateId:(NSString *)templateId;
@end
