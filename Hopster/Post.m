//
//  Post.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/29/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "Post.h"

@interface Post ()

@property (nonatomic) NSMutableDictionary * postAttrs;

@end

@implementation Post

-(id) initWithDictionary: (NSDictionary *) dictionary
{
    if( (self = [super init]) == nil )
        return nil;
    self.postAttrs = [NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName
{
    [self.postAttrs setObject: attrVal forKey: attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr
{
    return [self.postAttrs valueForKey: attr ];
}


@end
