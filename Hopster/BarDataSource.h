//
//  BarDataSource.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/12/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadAssistant.h"
#import "Bar.h"

@protocol DataSourceReadyForUseDelegate;

@interface BarDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<DataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataSourceReadyForUse;

-(instancetype) initWithBarsAtURL: (NSString *) url;
-(Bar *) barWithName: (NSString *) name;
-(NSMutableArray *) getAllBars;
-(Bar *) barAtIndex: (NSInteger) index;
-(NSInteger) numberOfBars;

@end

@protocol DataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (BarDataSource *) dataSource;

@end