//
//  ZHPossiableOneController.m
//  UniversalPush
//
//  Created by robot on 3/6/16.
//  Copyright © 2016 itemei. All rights reserved.
//

#import "ZHPossiableOneController.h"

@interface ZHPossiableOneController ()

@end

@implementation ZHPossiableOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    
    tempLabel.backgroundColor = [UIColor yellowColor];
    tempLabel.text = self.possiableOneLabel;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tempLabel];
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
