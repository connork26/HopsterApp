//
//  BarDetailsViewController.m
//  Hopster
//
//  Created by student on 5/1/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//


#import "BarDetailsViewController.h"

@interface BarDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondaryAddrLabel;
@property (nonatomic) Bar * bar;
@end

//static NSString * cellIdent = @"barCell";

@implementation BarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.bar.name;
    
    /*
     secondaryAddress = [secondaryAddress stringByAppendingString: [self.bar getValueForAttribute:@"city"] ];
     secondaryAddress = [secondaryAddress stringByAppendingString: @", "];
     secondaryAddress = [secondaryAddress stringByAppendingString: [self.bar getValueForAttribute:@"stateAbrv"] ];
     secondaryAddress = [secondaryAddress stringByAppendingString: @" "];
     secondaryAddress = [secondaryAddress stringByAppendingString: [self.bar getValueForAttribute:@"zipcode"] ];
     secondaryAddress = [secondaryAddress stringByAppendingString: @" "];
     */
    
    NSString * firstpart = [self.bar getValueForAttribute:@"city"];
    //    secondaryAddress = [secondaryAddress stringByAppendingString: @", "];
    NSString * secondpart = [self.bar getValueForAttribute:@"stateAbrv"];
    //    secondaryAddress = [secondaryAddress stringByAppendingString: @" "];
    NSString * thirdpart = [self.bar getValueForAttribute:@"zipcode"];
    //    secondaryAddress = [secondaryAddress stringByAppendingString: @" "];
    NSString * secondaryAddress = [NSString stringWithFormat:@"%@, %@ %@", firstpart, secondpart, thirdpart];
    
    
    
    //    NSLog(@"secondary address: %@", secondaryAddress);
    
    //    barLabel.text = [self.bar];
    
    //self.barLabel.text = [self.bar getValueForAttribute:@"name"];
    self.barLabel.text = self.bar.name;
    self.addrLabel.text = [self.bar getValueForAttribute:@"streetAddress"];
    self.secondaryAddrLabel.text = secondaryAddress;
    self.descriptionLabel.text = [self.bar getValueForAttribute:@"description"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setBar:(Bar *) inBar {
    _bar = inBar;
    NSLog(@"Bar set: %@", self.bar.name);
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
