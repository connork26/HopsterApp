//
//  MainTabBarController.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/7/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"logout"]){
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"userID"];
        [defaults removeObjectForKey:@"fName"];
        [defaults removeObjectForKey:@"lName"];
        
        [defaults synchronize];
    }
}


@end
