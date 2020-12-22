//
//  WWViewController.m
//  DeviceHelper
//
//  Created by waitwalker on 12/22/2020.
//  Copyright (c) 2020 waitwalker. All rights reserved.
//

#import "WWViewController.h"
#import <DeviceHelper/DeviceManager.h>


@interface WWViewController ()

@end

@implementation WWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    DeviceType deviceType = [DeviceManager sharedManager].deviceType;
    NSLog(@"设备类型:%ld", deviceType);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
