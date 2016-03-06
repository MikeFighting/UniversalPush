//
//  ViewController.m
//  UniversalPush
//
//  Created by robot on 3/6/16.
//  Copyright © 2016 itemei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic,strong) NSArray* neededToPushArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat buttonX = 50;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, 100, self.view.frame.size.width - 2 * buttonX, 50)];
    button.backgroundColor = [UIColor darkGrayColor];
    [button setTitle:@"PUSH TO ANY CONTROLLER" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pushButtonAction:   ) forControlEvents:UIControlEventTouchUpInside];
    
    [self initDataSource];

  
    
}
- (void)pushButtonAction:(UIButton *)sender {
    
    NSInteger randowInteger = arc4random()%2;
    [self pusAnyViewControllerWithDictionary:self.neededToPushArray[randowInteger]];
    
}

- (void)initDataSource{

    NSDictionary *tempDicOne = @{@"class":@"ZHPossiableOneController",@"property":@{@"possiableOneLabel":@"I am possiable one"}};
    NSDictionary *tempDicTwo = @{@"class":@"ZHPossiableTwoController",@"property":@{@"possiableTwoLabel":@"I am possiable two"}};
    self.neededToPushArray = @[tempDicOne,tempDicTwo];

}
- (void)pusAnyViewControllerWithDictionary:(NSDictionary *)parameterDictionary{

    // Try to get the class needed to push.
    NSString *classNameString = parameterDictionary[@"class"];
    
    const char *classNameCString = [classNameString cStringUsingEncoding:NSUTF8StringEncoding];
    Class NeededPushClass = objc_getClass(classNameCString);
    
    
    // The class is not exist.
    if (!NeededPushClass) {
        
        NeededPushClass = objc_allocateClassPair([NSObject class], classNameCString, 0);
        objc_registerClassPair(NeededPushClass);
        
    }else{
    
        
        id pushClass = [[NeededPushClass alloc]init];
        NSDictionary *parameterDict = parameterDictionary[@"property"];
        [parameterDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([self checkInstance:pushClass isExistProperty:key]) {
                
                [pushClass setValue:obj forKey:key];

            }
            
        }];
     [self.navigationController pushViewController:pushClass animated:YES];
    }
   
    
}
- (BOOL)checkInstance:(id)instance isExistProperty:(NSString *)propertyName{

    BOOL isExist = NO;
    unsigned int propertyCount;
    // get all the properties of the class
    objc_property_t *propertyList = class_copyPropertyList([instance class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        
        objc_property_t property = propertyList[i];
        // get the property name
        const char *propertyCName = property_getName(property);
        
        NSString *temppropertyName = [[NSString alloc]initWithUTF8String:propertyCName];
        if ([temppropertyName isEqualToString:propertyName]) {
            
            isExist = YES;
        }
        
    }
    return isExist;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
