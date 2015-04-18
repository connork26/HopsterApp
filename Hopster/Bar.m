//
//  Bar.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/12/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "Bar.h"

@interface Bar ()

@property (nonatomic) NSMutableDictionary * barAttrs;

@end

@implementation Bar

-(id) initWithDictionary: (NSDictionary *) dictionary
{
    if( (self = [super init]) == nil )
        return nil;
    self.barAttrs = [NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName
{
    [self.barAttrs setObject: attrVal forKey: attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr
{
    return [self.barAttrs valueForKey: attr ];
}

-(NSString *) name {
    return ([self getValueForAttribute:@"name"]);
}

@end
