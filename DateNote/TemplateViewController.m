//
//  TemplateViewController.m
//  DateNote
//
//  Created by Man-Chun Hsieh on 7/19/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "TemplateViewController.h"
#import "TemplateCell.h"
#import "UIImageView+AFNetworking.h"
#import "CustomViewController.h"

@interface TemplateViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *templates;
@property (weak, nonatomic) IBOutlet UITableView *templateTable;
@property (weak, nonatomic) IBOutlet UINavigationItem *nav;
@end

@implementation TemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.templates = @[@{@"t_name":@"月經紀錄",@"count":@"131k",@"img_url":@"https://lh6.ggpht.com/rJYVwzTDOPzlXlQI8NTnjSpyWaOxO_5XY9fpN5j_8tGLlgehP5g0priDM2rrfJu5SSIP=w300"},@{@"t_name":@"新手爸媽日記",@"count":@"63k",@"img_url":@"http://a1.mzstatic.com/us/r30/Purple5/v4/c7/c6/09/c7c6097f-b1be-8f50-aab1-7b4a6d9ef347/icon350x350.jpeg"},@{@"t_name":@"運動可養成",@"count":@"80k",@"img_url":@"http://a5.mzstatic.com/us/r30/Purple1/v4/c5/95/e9/c595e9ed-3149-7082-4f71-cbc401099774/icon175x175.png"},@{@"t_name":@"10000小時學習計畫",@"count":@"3k",@"img_url":@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRnNI4VxrYbXKeYelrN41kkZ-MSdI2Lfb76YQPHlDZ4kyCg3kcp"}];
    self.templateTable.dataSource = self;
    self.templateTable.delegate = self;
    
    
    // set nav
    self.nav.title = @"Template";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //取消選取
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.templates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTemplateCell" forIndexPath:indexPath];
    // NSLog(@"%@", self.events[indexPath.row]);
    
    // title
    cell.titleLabel.text = self.templates[indexPath.row][@"t_name"];
    
    // count
    cell.count.text = self.templates[indexPath.row][@"count"];
    
    // image url
    NSString *imageUrl= self.templates[indexPath.row][@"img_url"];
    [cell.templateImage setImageWithURL:[NSURL URLWithString:imageUrl]];
    cell.tag = indexPath.row;
    NSLog(@"%ld",indexPath.row);
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TemplateCell *cell = sender; // 轉型
    NSIndexPath *indexPath = [self.templateTable indexPathForCell:cell];
    CustomViewController *dest = segue.destinationViewController; //傳給下一頁
    dest.template = self.templates[indexPath.row];
}


@end
