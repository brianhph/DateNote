//
//  HomeViewController.m
//  DateNote
//
//  Created by Brian Huang on 7/13/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "HomeViewController.h"
#import "KDCalendarView.h"

@interface HomeViewController () <KDCalendarDelegate, KDCalendarDataSource>
@property (weak, nonatomic) IBOutlet KDCalendarView *calendar;

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
    [self.calendar setShowsEvents:YES];
    //[self.calendar dateByAddingComponents:components toDate:components options:0];
}

-(NSDate*)startDate
{
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    offsetDateComponents.month = -3;
    NSDate *threeMonthsBeforeDate = [[NSCalendar currentCalendar]dateByAddingComponents:offsetDateComponents toDate:[NSDate date] options:0];
    
    return threeMonthsBeforeDate;
}

-(NSDate*)endDate
{
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    
    offsetDateComponents.year = 2;
    offsetDateComponents.month = 0;
    
    NSDate *yearLaterDate = [[NSCalendar currentCalendar] dateByAddingComponents:offsetDateComponents toDate:[NSDate date] options:0];
    
    return yearLaterDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarController:(KDCalendarView*)calendarViewController didScrollToMonth:(NSDate*)date
{
    NSDateFormatter* headerFormatter = [[NSDateFormatter alloc] init];
    headerFormatter.dateFormat = @"MMMM, yyyy";
    
    
}

-(void)calendarController:(KDCalendarView*)calendarViewController didSelectDay:(NSDate*)date
{
    NSLog(@"update table view");
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
