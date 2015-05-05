//
//  BeerDataSource.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/7/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadAssistant.h"
#import "Beer.h"

@protocol DataSourceReadyForUseDelegate;

@interface BeerDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<DataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataSourceReadyForUse;

-(instancetype) initWithBeersAtURL: (NSString *) url;
-(Beer *) beerWithName: (NSString *) name;
-(NSMutableArray *) getAllBeers;
-(Beer *) beerAtIndex: (NSInteger) index;
-(NSInteger) numberOfBeers;

@end

@protocol DataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (BeerDataSource *) dataSource;

@end
