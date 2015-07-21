//
//  HomeViewController.m
//  DateNote
//
//  Created by Brian Huang on 7/13/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "HomeViewController.h"
#import "KDCalendarView.h"
#import "myEvent.h"

@interface HomeViewController () <KDCalendarDelegate, KDCalendarDataSource>

@property (weak, nonatomic) IBOutlet KDCalendarView *calendar;
@property (weak, nonatomic) IBOutlet UILabel *displayMonth;
@property (weak, nonatomic) NSArray *dateEvents;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    self.calendar.showsEvents = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDate *today = [[NSDate alloc]init];
    [self.calendar setMonthDisplayed:today];

    [self.calendar setDateSelected:today];
    [self.calendar resetEvents:[myEvent from:[self startDate] to:[self endDate]]];

    [self calendarController:self.calendar didScrollToMonth:today];
}

-(NSDate*)startDate
{
    NSDateComponents *firstday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    [firstday setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    firstday.day = 1;
    
    NSDate *sday = [[NSCalendar currentCalendar] dateFromComponents:firstday];
    
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    offsetDateComponents.month = -6;
    sday = [[NSCalendar currentCalendar]dateByAddingComponents:offsetDateComponents toDate:sday options:0];
    
    return sday;
}

-(NSDate*)endDate
{
    NSDateComponents *firstday = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    [firstday setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    firstday.day = 1;
    
    NSDate *eday = [[NSCalendar currentCalendar] dateFromComponents:firstday];
    
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    offsetDateComponents.year = 1;
    offsetDateComponents.second = -1;
    eday = [[NSCalendar currentCalendar]dateByAddingComponents:offsetDateComponents toDate:eday options:0];
    
    return eday;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarController:(KDCalendarView*)calendarViewController didScrollToMonth:(NSDate*)date
{
    NSDateFormatter* headerFormatter = [[NSDateFormatter alloc] init];
    headerFormatter.dateFormat = @"MMMM, yyyy";
    self.displayMonth.text = [headerFormatter stringFromDate:date];
}

-(void)calendarController:(KDCalendarView*)calendarViewController didSelectDay:(NSDate*)date
{
    self.dateEvents = [myEvent getEventsByDate:date];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
