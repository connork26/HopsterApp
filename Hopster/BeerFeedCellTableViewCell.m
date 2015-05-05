//
//  beerFeedCellTableViewCell.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/8/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerFeedCellTableViewCell.h"

@implementation BeerFeedCellTableViewCell

- (void)awakeFromNib {
    _beerNameLabel = [[UILabel alloc] init];
    _breweryLabel = [[UILabel alloc] init];
    _styleLabel = [[UILabel alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
