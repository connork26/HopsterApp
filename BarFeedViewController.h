//
//  BarFeedViewController.h
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@protocol BarTaggedDelegate;

@interface BarFeedViewController : UITableViewController

@property (nonatomic) id<BarTaggedDelegate> delegate;

@end

@protocol BarTaggedDelegate <NSObject>
@required

-(void) barTagged: (Bar *) taggedBar;

@end
