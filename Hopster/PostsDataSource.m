//
//  PostsDataSource.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/29/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "PostsDataSource.h"
#import "Post.h"

@interface PostsDataSource(){
    BOOL debug;
}

@property (nonatomic) DownloadAssistant * downloadAssistant;
@property (nonatomic) NSData * postData;
@property (nonatomic) NSMutableArray * allPosts;

@end

@implementation PostsDataSource

-(instancetype)initWithPostsAtURL:(NSString *)url {
    if ((self = [super init]) == nil)
        return nil;
    
    debug = YES;
    
    _downloadAssistant = [[DownloadAssistant alloc] init];
    
    self.downloadAssistant.delegate = self;
    self.dataSourceReadyForUse = NO;
    
    [self.downloadAssistant downloadContentsOfURL:url];
    
    return self;
}

-(void) acceptWebData:(NSData *)webData forURL:(NSURL *)url {
    self.postData = webData;
    
    NSError *parseError = nil;
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:self.postData options:0 error:&parseError];
    if( debug )
        NSLog(@"%@", jsonString);
    if( parseError ) {
        NSLog(@"Badly formed JSON string. %@", [parseError localizedDescription] );
        return;
    }
    
    for (NSDictionary * postIn in jsonString) {
        Post * temp = [[Post alloc] initWithDictionary:postIn];
        [self.allPosts addObject:temp];
    }
    
    if([self.delegate respondsToSelector:@selector(dataSourceReadyForUse:)]){
        [self.delegate performSelector:@selector(dataSourceReadyForUse:) withObject:self];
    }
    
    self.dataSourceReadyForUse = YES;
    
}

-(NSMutableArray *) getAllPosts {
    return self.allPosts;
}

-(NSInteger) numberOfPosts {
    return [self.allPosts count];
}

-(Post *) postAtIndex:(NSInteger) index {
    return [self.allPosts objectAtIndex: index];
}

-(NSMutableArray *) allPosts {
    if (! _allPosts){
        _allPosts = [[NSMutableArray alloc] init];
    }
    
    return _allPosts;
}

@end
