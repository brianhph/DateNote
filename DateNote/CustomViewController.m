//
//  CustomViewController.m
//  DateNote
//
//  Created by Man-Chun Hsieh on 7/20/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *nav;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.template);
    // set nav
    self.nav.title = self.template[@"t_name"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;

    // Do any additional setup after loading the view.
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
