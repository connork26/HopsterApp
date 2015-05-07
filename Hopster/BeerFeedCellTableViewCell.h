//
//  beerFeedCellTableViewCell.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/8/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerFeedCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *beerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@end
