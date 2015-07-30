//
//  SqlClient.m
//  DateNote
//
//  Created by Jackal Wang on 2015/7/15.
//  Copyright (c) 2015年 EC. All rights reserved.
//

#import "SqlClient.h"
#import "SqlData.h"

NSString * const colorList[] = {
    @"#c1deb4", @"#f6cbd6", @"#c0a8f0", @"#0a8fab", @"#e5ea91", @"#ffa500", @"#eae3aa", @"#94cd4b",@"#c1deb4", @"#f6cbd6", @"#c0a8f0", @"#0a8fab", @"#e5ea91", @"#ffa500", @"#eae3aa", @"#94cd4b"
};

@interface SqlClient ()

@end

@implementation SqlClient

-(void)insertDetailOneDayEventStartWith:(NSDate *)startTime tilte:(NSString *)title description:(NSString *)description img_url:(NSString *)img_url mt_id:(NSString *)mt_id repeat:(NSString *)repeat{
    NSString *date = [self getNewDateWith:startTime day:0 month:0 year:0];
    
//    NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:nil];
    
    NSDictionary *tempDic = @{@"mt_id": mt_id,@"r_id": @"0",@"e_title": title,@"e_time": date,@"e_detail_url": @"detail_url",@"desc": description,@"img_url": img_url};
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    
    [SqlData insertMyEvent:inputDic];
}

-(void)insertOneDayEventStartWith:(NSDate *)startTime tilte:(NSString *)title description:(NSString *)description{
    NSString *date = [self getNewDateWith:startTime day:0 month:0 year:0];
    
    NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:nil];
    
    [SqlData insertMyEvent:inputDic];
}

-(void)insertDayEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id{
    for (int i=0; i<100; i++) {
        
        NSString *date = [self getNewDateWith:startTime day:i month:0 year:0];
        
        NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:r_id];
        
        [SqlData insertMyEvent:inputDic];
    }
}

-(void)insertWeekEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id{
    for (int i=0; i<100; i++) {
        
        NSString *date = [self getNewDateWith:startTime day:i*7 month:0 year:0];
        
        NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:r_id];
        
        [SqlData insertMyEvent:inputDic];
    }
}

-(void)insertMonthEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id{
    for (int i=0; i<100; i++) {
        
        NSString *date = [self getNewDateWith:startTime day:0 month:i year:0];
        
        NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:r_id];
        
        [SqlData insertMyEvent:inputDic];
    }
    
}

-(void)insertYearEventStartWith:(NSDate *)startTime title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id{
    for (int i=0; i<100; i++) {
        
        NSString *date = [self getNewDateWith:startTime day:0 month:0 year:i];
        
        NSMutableDictionary *inputDic = [self createMyEventDic:date title:title description:description r_id:r_id];
        
        [SqlData insertMyEvent:inputDic];
    }
    
}

-(NSMutableDictionary *)createMyEventDic:(NSString *)date title:(NSString *)title description:(NSString *)description r_id:(NSString *)r_id{
    NSDictionary *tempDic = @{@"mt_id": @"0",@"r_id": @"0",@"e_title": @"title",@"e_time": @"time",@"e_detail_url": @"detail_url",@"desc": @"desc",@"img_url": @"img_url"};
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    
    if (date != nil) {
        [inputDic setObject:date forKey:@"e_time"];
    }
    
    if (title != nil) {
        [inputDic setObject:title forKey:@"e_title"];
    }
    
    if (description != nil) {
        [inputDic setObject:description forKey:@"desc"];
    }
    
    if (r_id != nil) {
        [inputDic setObject:r_id forKey:@"r_id"];
    }
    
    return inputDic;
    
}

-(NSString *)getNewDateWith:(NSDate *)startTime day:(NSInteger)day month:(NSInteger)month year:(NSInteger)year{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    if (day > 0 ) {
        [offsetComponents setDay:day];
    }
    
    if (month > 0 ) {
        [offsetComponents setMonth:month];
    }
    
    if (year > 0 ) {
        [offsetComponents setYear:year];
    }
    
    //NSString to NSDate
    // NSDate *date = [dateFormatter dateFromString:startTime];
    // NSLog(@"origin Date = %@", date);
    
    NSDate *newDate = [gregorian dateByAddingComponents:offsetComponents toDate:startTime options:0];
    
    //NSDate to NSString
    NSString *strDate = [dateFormatter stringFromDate:newDate];
    //NSLog(@"new Data = %@", strDate);
    
    return strDate;
}


-(NSMutableArray *)getTemplateList{
    NSMutableArray *result = [SqlData select:@"templateList"];
    
    return result;
}

-(NSMutableArray *)getNewBornTemplateList{
    NSMutableArray *result = [SqlData getTemplateListByID:@"1"];
    
    return result;
}

-(NSString *)getTemplateColor{
    NSMutableArray *result = [SqlData select:@"myTemplate"];
    NSString *color = colorList[result.count];
    return color;
}

-(void)insertNewBornTemplateEventWithStartTime:(NSDate *)startTime templateTitle:(NSString *)templateTitle{
    //    myTemplate
    NSMutableArray *result = [SqlData select:@"myTemplate"];
    NSString *color = [self getTemplateColor];
    NSDictionary *tempDic = @{@"template_id": @"1",@"t_name": templateTitle,@"color": color};
    
    NSMutableArray *dbCheck = [self getTemplateEventListByTID:[tempDic objectForKey:@"template_id"]];
    
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    //    NSLog(@"myTemplate = %@",result);
    [SqlData insertMyTemplate:inputDic];
    
    NSInteger mt_id = [SqlData getLastInsertRowID];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 10:00:00"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *dateString = [dateFormatter stringFromDate:startTime];
    //    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    //設定出生日期
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    //    NSLog(@"today = %@",[dateFormatter stringFromDate:date]);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    for (int i=0; i<dbCheck.count; i++) {
        //拿每筆template event list
        NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:dbCheck[i]];
        [inputDic setObject:[NSString stringWithFormat:@"%ld", mt_id] forKey:@"mt_id"];
        [inputDic setObject:@"0" forKey:@"r_id"];
        
        [offsetComponents setMonth:[inputDic[@"period"] intValue]];
        [offsetComponents setHour:0];
        NSDate *newEndTime = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
        
        //        NSLog(@"date = %@",[dateFormatter stringFromDate:newEndTime]);
        [inputDic setObject:[dateFormatter stringFromDate:newEndTime] forKey:@"e_time"];
        
        [SqlData insertMyEvent:inputDic];
    }
}

-(void)insertTemplateEventWithStartTime:(NSDate *)startTime templateTitle:(NSString *)templateTitle templateId:(NSString *)templateId{
    //    myTemplate
    NSMutableArray *result = [SqlData select:@"myTemplate"];
    NSString *color = [self getTemplateColor];
    NSDictionary *tempDic = @{@"template_id": templateId,@"t_name": templateTitle,@"color": color};
    
    NSMutableArray *dbCheck = [self getTemplateEventListByTID:[tempDic objectForKey:@"template_id"]];
    
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    //    NSLog(@"myTemplate = %@",result);
    [SqlData insertMyTemplate:inputDic];
    
    NSInteger mt_id = [SqlData getLastInsertRowID];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 10:00:00"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *dateString = [dateFormatter stringFromDate:startTime];
    //    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    //設定出生日期
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    //    NSLog(@"today = %@",[dateFormatter stringFromDate:date]);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    for (int i=0; i<dbCheck.count; i++) {
        //拿每筆template event list
        NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:dbCheck[i]];
        [inputDic setObject:[NSString stringWithFormat:@"%d", mt_id] forKey:@"mt_id"];
        [inputDic setObject:@"0" forKey:@"r_id"];
        
        NSString *unit = inputDic[@"unit"];
        
        if ([unit isEqualToString:@"day"]) {
            [offsetComponents setDay:[inputDic[@"period"] intValue]];
        }
        
        if ([unit isEqualToString:@"month"]) {
            [offsetComponents setMonth:[inputDic[@"period"] intValue]];
        }
        
        if ([unit isEqualToString:@"year"]) {
            [offsetComponents setYear:[inputDic[@"period"] intValue]];
        }
        
        [offsetComponents setHour:0];
        NSDate *newEndTime = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
        
        //        NSLog(@"date = %@",[dateFormatter stringFromDate:newEndTime]);
        [inputDic setObject:[dateFormatter stringFromDate:newEndTime] forKey:@"e_time"];
        
        [SqlData insertMyEvent:inputDic];
    }
}


-(NSMutableArray *)getTemplateListByID:(NSString *)t_id{
    NSMutableArray *result = [SqlData getTemplateListByID:t_id];
    
    return result;
}

-(NSMutableArray *)getTemplateEventListByTID:(NSString *)t_id{
    NSMutableArray *result = [SqlData getTemplateEventListByTID:t_id];
    
    return result;
}

+(NSMutableArray *)getMyEventFrom:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg mt_id:(NSString *)mt_id{
    
    NSString *timeStr = [SqlClient getStringFromDate:time];
    
    NSMutableArray *result = [SqlData getMyEventFrom:timeStr count:count pg:pg my_id:mt_id];
    return result;
}
+(NSMutableArray *)getMyEventFrom:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg {
    
    NSString *timeStr = [SqlClient getStringFromDate:time];
    
    NSMutableArray *result = [SqlData getMyEventFrom:timeStr count:count pg:pg];
    return result;
}

+(NSMutableArray *)getMyPastEvent:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg mt_id:(NSString *)mt_id{
    
    NSString *timeStr = [SqlClient getStringFromDate:time];
    
    NSMutableArray *result = [SqlData getMyPastEvent:timeStr count:count pg:pg mt_id:mt_id];
    
    return result;
}

+(NSMutableArray *)getMyPastEvent:(NSDate *)time count:(NSInteger)count pg:(NSInteger)pg {
    NSString *timeStr = [SqlClient getStringFromDate:time];
    NSMutableArray *result = [SqlData getMyPastEvent:timeStr count:count pg:pg];
    
    return result;
}

+(NSMutableArray *)getMyTemplate{
    NSMutableArray *result = [SqlData select:@"myTemplate"];
    
    return result;
}

+(NSMutableArray *)getMyEventByDay:(NSDate *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString *startTime = [dateFormatter stringFromDate:time];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd 23:59:59"];
    NSString *endTime = [dateFormatter stringFromDate:time];
    
    NSMutableArray *result = [SqlData getMyEventFrom:startTime to:endTime];
    return result;
}

+(NSMutableArray *)getMyEventFrom:(NSDate *)startTime to:(NSDate *)endTime{
    NSString *startStr = [SqlClient getStringFromDate:startTime];
    NSString *endStr = [SqlClient getStringFromDate:endTime];
    NSMutableArray *result = [SqlData getMyEventFrom:startStr to:endStr];
    
    return result;
}

+ (NSString *)getStringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    return [formatter stringFromDate:date];
}

+(NSMutableArray *)getMyEventByEventID:(NSString *)me_id{
    NSMutableArray *result = [SqlData getMyEventByEventID:me_id];
    
    return result;
}

-(void) deleteMyEventByMyEventID:(NSString *)me_id{
    [SqlData deleteMyEventByMyEventID:me_id];
}
-(void) deleteMyEventByMyTemplateID:(NSString *)mt_id{
    [SqlData deleteMyEventByMyTemplateID:mt_id];
}
-(void) deleteMyEventByRecycleID:(NSString *)r_id{
    [SqlData deleteMyEventByRecycleID:r_id];
}

-(void)initDataBase{
    //    [sqlData dropTable:@"myEvent"];
    //    [sqlData dropTable:@"myTemplate"];
    //    [sqlData dropTable:@"templateEventList"];
    //    [sqlData dropTable:@"templateList"];
    
    //範例
    //    NSDate *nowDate = [NSDate date];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    //    NSMutableArray *result = [self getMyEvent:[dateFormatter stringFromDate:nowDate] :3 :0 :@"1"];
    //    NSLog(@"getMyEvent pg0 = %@",result);
    //    NSLog(@"getMyEvent pg1 = %@",[self getMyEvent:[dateFormatter stringFromDate:nowDate] :3 :1 :@"1"]);
    //
    //    NSLog(@"getMyPastEvent = %@",[self getMyPastEvent:[dateFormatter stringFromDate:nowDate] :5 :0 :@"1"]);
    //
    //    NSLog(@"getMyTemplate = %@",[self getMyTemplate]);
    //
    //    NSLog(@"getMyEventByDay = %@",[self getMyEventByDay:@"2015-07-12"]);
    //
    //    NSLog(@"getMyEventByPeriod = %@",[self getMyEventByPeriod:@"2015-07-12 00:00:00" :@"2016-05-12 23:59:59"]);
    
    
    NSMutableArray *dbCheck = self.getTemplateList;
    NSLog(@"row count = %lu", (unsigned long)dbCheck.count);
    if (dbCheck.count == 0){
        NSLog(@"---------------------------------");
        //建立第一個template list
        NSDictionary *tempDic = @{@"mt_id": @"0",@"r_id": @"0",@"e_title": @"",@"e_time": @"",@"e_detail_url": @"",@"desc": @"",@"img_url": @""};
        NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
        [inputDic setObject:@"小孩出生" forKey:@"t_name"];
        [SqlData insertTemplateList:inputDic];
        
        //        NSMutableArray *result = [SqlData select:@"templateList"];
        //        NSLog(@"templateList = %@",result);
        //建立第一個template list
        
        //建立template event
        tempDic = @{@"template_id": @"1",@"recycle": @"1",@"e_title": @"B型肝炎遺傳工程疫苗第二劑",@"desc": @"",@"e_detail_url": @"",@"unit": @"month",@"period": @"1",@"img_url": @""};
        inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"五合一疫苗(白喉破傷風非細胞性百日咳、b型嗜血桿菌及不活化小兒麻痺混合疫苗)第一劑" forKey:@"e_title"];
        [inputDic setObject:@"2" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"五合一疫苗(白喉破傷風非細胞性百日咳、b型嗜血桿菌及不活化小兒麻痺混合疫苗)第二劑" forKey:@"e_title"];
        [inputDic setObject:@"4" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"B型肝炎遺傳工程疫苗第三劑,五合一疫苗(白喉破傷風非細胞性百日咳、b型嗜血桿菌及不活化小兒麻痺混合疫苗)第三劑" forKey:@"e_title"];
        [inputDic setObject:@"6" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"6個月的副食品" forKey:@"e_title"];
        [inputDic setObject:@"每天一餐，吃的量不強求" forKey:@"desc"];
        [inputDic setObject:@"http://qqmei0904.pixnet.net/blog/post/183054209-%E5%89%AF%E9%A3%9F%E5%93%81%E9%A3%9F%E8%AD%9C%E8%88%87%E9%A3%9F%E7%94%A8%E9%80%B2%E5%BA%A6%E7%B8%BD%E6%95%B4%E7%90%86" forKey:@"e_detail_url"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"7個月的副食品" forKey:@"e_title"];
        [inputDic setObject:@"若寶寶一餐副食品可以吃到80ml左右，那麼即可增加為一天餵食兩次" forKey:@"desc"];
        [inputDic setObject:@"7" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"8個月的副食品" forKey:@"e_title"];
        [inputDic setObject:@"一天吃四餐" forKey:@"desc"];
        [inputDic setObject:@"8" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"9個月的副食品" forKey:@"e_title"];
        [inputDic setObject:@"一天吃四餐" forKey:@"desc"];
        [inputDic setObject:@"9" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        [inputDic setObject:@"" forKey:@"desc"];
        [inputDic setObject:@"" forKey:@"e_detail_url"];
        
        [inputDic setObject:@"麻疹腮腺炎德國麻疹混合疫苗第一劑,水痘疫苗一劑" forKey:@"e_title"];
        [inputDic setObject:@"12" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"日本腦炎疫苗第一劑" forKey:@"e_title"];
        [inputDic setObject:@"15" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"五合一疫苗(白喉破傷風非細胞性百日咳、b型嗜血桿菌及不活化小兒麻痺混合疫苗)第四劑" forKey:@"e_title"];
        [inputDic setObject:@"18" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        [inputDic setObject:@"日本腦炎疫苗第三劑" forKey:@"e_title"];
        [inputDic setObject:@"27" forKey:@"period"];
        [SqlData insertTemplateEventList:inputDic];
        
        //        result = [SqlData select:@"templateEventList"];
        //        NSLog(@"templateEventList = %@",result);
        
        //建立template event
    }
    
}

-(void)initTempData{
    
    NSMutableArray *dbCheck = [self getTemplateListByID:@"1"];
    //    NSLog(@"bbbbb = %@",dbCheck[0]);
    
    NSDictionary *dic = dbCheck[0];
    
    NSString *myTemplateName = [dic objectForKey:@"t_name"];
    //    NSLog(@"name = %@",myTemplateName);
    
    dbCheck = [self getTemplateEventListByTID:[dic objectForKey:@"template_id"]];
    //    NSLog(@"getTemplateEventListByTID = %@",dbCheck);
    
    //    myTemplate
    NSMutableArray *result = [SqlData select:@"myTemplate"];
    NSString *color = colorList[result.count];
    NSDictionary *tempDic = @{@"template_id": @"1",@"t_name": myTemplateName,@"color": color};
    NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:tempDic];
    NSLog(@"myTemplate = %@",result);
    [SqlData insertMyTemplate:inputDic];
    //清資料
    //    [sqlData dropTable:@"myTemplate"];
    //    [sqlData dropTable:@"myEvent"];
    
    NSInteger mt_id = [SqlData getLastInsertRowID];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    //    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    //設定出生日期為2015-05-12 10:00:00
    NSDate *date = [dateFormatter dateFromString:@"2015-05-12 10:00:00"];
    
    //    NSLog(@"today = %@",[dateFormatter stringFromDate:date]);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    
    for (int i=0; i<dbCheck.count; i++) {
        //拿每筆template event list
        NSMutableDictionary *inputDic = [[NSMutableDictionary alloc] initWithDictionary:dbCheck[i]];
        [inputDic setObject:[NSString stringWithFormat:@"%ld", mt_id] forKey:@"mt_id"];
        [inputDic setObject:@"0" forKey:@"r_id"];
        
        [offsetComponents setMonth:[inputDic[@"period"] intValue]];
        [offsetComponents setHour:0];
        NSDate *newEndTime = [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
        
        NSLog(@"date = %@",[dateFormatter stringFromDate:newEndTime]);
        [inputDic setObject:[dateFormatter stringFromDate:newEndTime] forKey:@"e_time"];
        
        [SqlData insertMyEvent:inputDic];
    }
    
    //    dbCheck = [sqlData select:@"templateEventList"];
    //    NSLog(@"my event list = %@",self.getMyEvent);
    
    
    [SqlData closeDatabase];
}


@end