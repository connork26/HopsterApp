//
//  BeerDetailsViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/13/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerDetailsViewController.h"

@interface BeerDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *abvLabel;
@property (nonatomic) Beer * beer;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@end

@implementation BeerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * abv = [NSString stringWithFormat:@"%@ %% abv", [self.beer getValueForAttribute:@"abv"]];
    
    self.titleLabel.text = self.beer.name;
    self.breweryLabel.text = [self.beer getValueForAttribute:@"breweryName"];
    self.styleLabel.text = [self.beer getValueForAttribute:@"styleName"];
    self.abvLabel.text = abv;
    self.detailsLabel.text = [self.beer getValueForAttribute:@"description"];
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
