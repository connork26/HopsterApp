//
//  BeerFeedViewController.h
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"

@protocol BeerTaggedDelegate;

@interface BeerFeedViewController : UITableViewController

@property (nonatomic) id<BeerTaggedDelegate> delegate;


@end

@protocol BeerTaggedDelegate <NSObject>
@required

-(void) beerTagged: (Beer *) taggedBeer;

@end