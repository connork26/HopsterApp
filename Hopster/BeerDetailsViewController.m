//
//  BeerDetailsViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/13/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerDetailsViewController.h"

@interface BeerDetailsViewController ()
@property (nonatomic) Beer * beer;
@end

@implementation BeerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.beer.name;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setBeer:(Beer *) inBeer {
    _beer = inBeer;
    NSLog(@"Beer set: %@", self.beer.name);
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
