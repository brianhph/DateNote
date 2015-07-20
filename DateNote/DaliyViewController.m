//
//  DaliyViewController.m
//  DateNote
//
//  Created by Man-Chun Hsieh on 7/13/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "DaliyViewController.h"
#import "DaliyCell.h"
#import "UIImageView+AFNetworking.h"

@interface DaliyViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *filter;

@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSMutableArray *events_filter;
@property (strong, nonatomic) NSArray *month_en;
@property (strong, nonatomic) NSArray *category;

@end

@implementation DaliyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.month_en = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    self.events=[[NSMutableArray alloc]init];
    self.events_filter=[[NSMutableArray alloc]init];
    self.events =@[@{@"me_id" : @"1", @"mt_id" : @"1", @"e_title" : @"煮紅豆湯", @"e_detail_url" : @"http://www.yahoo.com", @"e_time" : @"2015-07-25 12:00:00", @"r_id" : @"1",@"desc" : @"快喝紅豆湯,快喝紅豆湯,快喝紅豆湯,紅豆兩湯匙,砂糖半匙,一杯水,電鍋跳起來就可以喝了", @"img_url" : @"http://img1.groupon.com.tw/fi/9(1091).jpg", @"color": @"#FF3799",@"t_name":@"女孩月事"},
  @{@"me_id" : @"2", @"mt_id" : @"2", @"e_title" : @"Y! Summer Party", @"e_detail_url" : @"http://www.yahoo.com", @"e_time" : @"2015-07-26 14:00:00", @"r_id" : @"2",@"desc" : @"帶門票, 午餐券, 停車票, 住宿券, 照相機, 防曬油, 泳衣", @"img_url" : @"https://c2.staticflickr.com/8/7277/7772597482_a587f7278b.jpg", @"color": @"#47cccc",@"t_name":@"一起去郊遊"},
  @{@"me_id" : @"4", @"mt_id" : @"4", @"e_title" : @"寶寶預產期", @"e_detail_url" : @"http://www.yahoo.com", @"e_time" : @"2015-08-21 14:00:00", @"r_id" : @"2",@"desc" : @"寶貝要來報到囉", @"img_url" : @"http://healthy.bayvoice.net/wp-content/uploads/sites/5/2014/08/14072294350202.jpg", @"color": @"#ff7f50",@"t_name":@"新手爸媽日記"},
  @{@"me_id" : @"3", @"mt_id" : @"3", @"e_title" : @"煮紅豆湯", @"e_detail_url" : @"http://www.yahoo.com", @"e_time" : @"2015-08-25 12:00:00", @"r_id" : @"3",@"desc" : @"快喝紅豆湯,快喝紅豆湯,快喝紅豆湯,紅豆兩湯匙,砂糖半匙,一杯水,電鍋跳起來就可以喝了", @"img_url" : @"http://img1.groupon.com.tw/fi/9(1091).jpg", @"color": @"#FF3799",@"t_name":@"女孩月事"},
  @{@"me_id" : @"5", @"mt_id" : @"5", @"e_title" : @"去郭元益拿喜餅", @"e_detail_url" : @"http://www.yahoo.com", @"e_time" : @"2015-09-21 08:00:00", @"r_id" : @"3",@"desc" : @"baby 滿月餅 給同事", @"img_url" : @"http://denwell.com/Uploads/104%E8%81%AF%E5%90%8D%E5%9B%8D%E9%A4%85-755X495-2.jpg", @"color": @"#ff7f50",@"t_name":@"新手爸媽日記"}];

    self.events_filter =self.events;
    
    // set filter
    [self setFilterTitle];

    self.contentView.dataSource = self;
    self.contentView.delegate = self;
}

-(void) setFilterTitle{
    
    self.category =@[@"全部分類", @"新手爸媽日記",@"女孩月事",@"一起去郊遊"];
    NSArray *category_color = @[@"#2e85ff",@"#ff7f50", @"#FF3799",@"#47cccc"];
    [self.filter removeSegmentAtIndex:0 animated:NO]; // remove default value
    [self.filter removeSegmentAtIndex:0 animated:NO]; // remove default value
    for(int i=0;i<self.category.count;i++){
        [self.filter insertSegmentWithTitle:self.category[i] atIndex:i animated:NO];
        [[[self.filter subviews] objectAtIndex:i] setTintColor:[self colorFromHexString:category_color[i]]];
    }
    self.filter.selectedSegmentIndex=0;
}

-(void)filterInit{


    
}

- (IBAction)changeFilter:(UISegmentedControl *)sender {
    self.events = self.events_filter;
    if([sender selectedSegmentIndex]>0){
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int i =0; i< self.self.events.count; i++) {
            if(self.events[i][@"t_name"]==self.category[[sender selectedSegmentIndex]]){
                [temp addObject:self.events[i]];
            }
        }
        self.events = temp;
        temp = nil;
    }
    [self.contentView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //取消選取
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DaliyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDaliyCell" forIndexPath:indexPath];
   // NSLog(@"%@", self.events[indexPath.row]);

    // title
    cell.titleLable.text = self.events[indexPath.row][@"e_title"];
    // desc
    cell.descriptionLabel.text = self.events[indexPath.row][@"desc"];
    
    // month day hour min
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self.events[indexPath.row][@"e_time"]];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date]; // Get necessary date components
    cell.dateLabel.text = [NSString stringWithFormat:@"%d", [components day]];
    cell.monthLabel.text = self.month_en[[components month]-1];//[NSString stringWithFormat:@"%d", [components month]];
    cell.hourminLabel.text = [NSString stringWithFormat:@"%d:%02d", [components hour],[components minute]];

    // reminder
     NSDate *currentDate = [dateFormatter dateFromString:self.events[indexPath.row][@"e_time"]];
    cell.reminderLabel.text = [self convertTimeToAgo:currentDate];
    
    // color
    cell.dotView.backgroundColor = [self colorFromHexString:self.events[indexPath.row][@"color"]];
    cell.colorView.backgroundColor = [self colorFromHexString:self.events[indexPath.row][@"color"]];
    
    // image url
    NSString *imageUrl= self.events[indexPath.row][@"img_url"];
    [cell.img setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    // template name
    cell.templateNameLabel.text = [NSString stringWithFormat:@"#%@", self.events[indexPath.row][@"t_name"]];
    
    return cell;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (NSString *)convertTimeToAgo:(NSDate *)createdDate
{
    NSTimeInterval time_get = [createdDate timeIntervalSince1970];
    NSTimeInterval time_now = [[NSDate date] timeIntervalSince1970];
    
    double difference = time_get - time_now;
    NSMutableArray *periods = [NSMutableArray arrayWithObjects:@"sec", @"min", @"hr", @"day", @"week", @"month", @"year", @"decade", nil];
    NSArray *lengths = [NSArray arrayWithObjects:@60, @60, @24, @7, @4.35, @12, @10, nil];
    int j = 0;
    for(j=0; difference >= [[lengths objectAtIndex:j] doubleValue]; j++){
        difference /= [[lengths objectAtIndex:j] doubleValue];
    }
    difference = roundl(difference);
    if(difference != 1){
        [periods insertObject:[[periods objectAtIndex:j] stringByAppendingString:@"s"] atIndex:j];
    }
    return [NSString stringWithFormat:@"%li %@", (long)difference, [periods objectAtIndex:j]];
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
