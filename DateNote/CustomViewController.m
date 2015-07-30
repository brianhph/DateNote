//
//  CustomViewController.m
//  DateNote
//
//  Created by Man-Chun Hsieh on 7/20/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "CustomViewController.h"
#import "DetailViewController.h"
#import "HomeViewController.h"
#import "SqlClient.h"

@interface CustomViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray* _titleSelectionData;
    NSInteger *pickerRow;
    NSInteger *mt_id;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *nav;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStartDate];
    [self setupEndDate];
    [self setupTemplate];
    [self setupRepeat];
    
    // set nav
    //    self.nav.title = self.template[@"t_name"];
    self.nav.title = @"new event";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;
    
    // 左邊 Filter
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Template"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(onCancelButton)];
    
    // 右邊 Filter
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"完成"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(onDoneButton)];
    
    _templatePicker.dataSource = self;
    _templatePicker.delegate = self;
    _repeatPicker.dataSource = self;
    _repeatPicker.delegate = self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)setupRepeat {
    _repeatPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    _repeatPicker.showsSelectionIndicator = YES;
    repeat = [[NSArray alloc] initWithObjects:@"單次", @"每天", @"每週", @"每月", @"每年", nil];
    
    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowRepeatSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil] animated:YES];
    
    [_repeatPicker selectRow:16 inComponent:0 animated:YES];
    [self.e_repeat setInputView:_repeatPicker];
    [self.e_repeat setInputAccessoryView:toolBar];
}

- (void)setupTemplate {
    _templatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    _templatePicker.showsSelectionIndicator = YES;
    plurk = [[NSArray alloc] initWithObjects:@"小孩出生", @"健身", @"女孩月事", nil];
    
    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowTemplateSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil] animated:YES];
    
    [_templatePicker selectRow:16 inComponent:0 animated:YES];
    [self.e_template setInputView:_templatePicker];
    [self.e_template setInputAccessoryView:toolBar];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    //第一組選項由0開始
    switch (component) {
        case 0:
            if (pickerView == _repeatPicker){
                return [repeat count];
            }
            return [plurk count];
            break;
            
            //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            if (pickerView == _repeatPicker){
                return [repeat objectAtIndex:row];
            }
            return [plurk objectAtIndex:row];
            break;
            
            //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行）
        default:
            return @"Error";
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    pickerRow = row;
}

-(void)ShowTemplateSelectedDate{
    self.e_template.text = [NSString stringWithFormat:@"%@", [plurk objectAtIndex:pickerRow]];
    NSLog(@"template row = %lo",(long)pickerRow);
    mt_id = (long)pickerRow + 1;
    NSLog(@"mtid=%lo",(long)mt_id);
    [self.e_template resignFirstResponder];
}

-(void)ShowRepeatSelectedDate{
    self.e_repeat.text = [NSString stringWithFormat:@"%@", [repeat objectAtIndex:pickerRow]];
    [self.e_repeat resignFirstResponder];
}

- (void)setupStartDate {
    dataPicker = [[UIDatePicker alloc] init];
    dataPicker.datePickerMode = UIDatePickerModeDate;
    
    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowStartSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil] animated:YES];
    
    [self.startDate setInputView:dataPicker];
    [self.startDate setInputAccessoryView:toolBar];
}

- (void)setupEndDate {
    dataPicker = [[UIDatePicker alloc] init];
    dataPicker.datePickerMode = UIDatePickerModeTime;
    
    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowEndSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space, doneBtn, nil] animated:YES];
    
    [self.startTime setInputView:dataPicker];
    [self.startTime setInputAccessoryView:toolBar];
}

- (void) onCancelButton{
    [self disMissViewFromLeft];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)disMissViewFromLeft{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
}

- (void) onDoneButton{
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd 10:00:00"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    //    NSDate *birthday = [dateFormatter dateFromString:self.template[@"start_time"]];
    //
    //    SqlClient *sqlClient = [[SqlClient alloc] init];
    //    [sqlClient insertTemplateEventWithStartTime:birthday templateTitle:self.template[@"t_name"] templateId:self.template[@"t_id"]];
    //    [self presentViewFromRight];
    //    HomeViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];  //記得要用storyboard id 傳過去
    //    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [self presentViewController:nvc animated:NO completion:nil];
    
    
    NSString *dateString = [NSString stringWithFormat:@"%@ %@:00", self.startDate.text,self.startTime.text];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDate *e_time = [dateFormatter dateFromString:dateString];
    NSLog(@"title=%@",self.e_title.text);
    NSLog(@"desc=%@",self.e_desc.text);
    NSLog(@"img_url=%@",self.img_url.text);
    NSString *mt_id_str = [NSString stringWithFormat: @"%ld", (long)mt_id];
    NSLog(@"mt_id=%@",mt_id_str);
    NSLog(@"date=%@",dateString);
    
    SqlClient *client = [[SqlClient alloc] init];
    [client insertDetailOneDayEventStartWith:e_time tilte:self.e_title.text description:self.e_desc.text img_url:self.img_url.text mt_id:mt_id_str repeat:@"0"];
    
    [self presentViewFromRight];
    HomeViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];  //記得要用storyboard id 傳過去
    //    vc.template = self.template;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:NO completion:nil];
}

-(void)presentViewFromRight{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
}


-(void)ShowStartSelectedDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.startDate.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:dataPicker.date]];
    [self.startDate resignFirstResponder];
}

-(void)ShowEndSelectedDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    self.startTime.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:dataPicker.date]];
    [self.startTime resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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