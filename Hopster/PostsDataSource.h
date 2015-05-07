//
//  PostsDataSource.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/29/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadAssistant.h"
#import "Post.h"

@protocol DataSourceReadyForUseDelegate;

@interface PostsDataSource : NSObject<WebDataReadyDelegate>


@property (nonatomic) id<DataSourceReadyForUseDelegate> delegate;

@property (nonatomic) BOOL dataSourceReadyForUse;

-(instancetype) initWithPostsAtURL: (NSString *) url;
-(NSMutableArray *) getAllPosts;
-(Post *) postAtIndex: (NSInteger) index;
-(NSInteger) numberOfPosts;

@end

@protocol DataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (PostsDataSource *) dataSource;

@end
