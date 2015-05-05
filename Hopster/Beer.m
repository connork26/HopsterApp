//
//  Beer.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/7/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "Beer.h"

@interface Beer ()

@property (nonatomic) NSMutableDictionary * beerAttrs;

@end

@implementation Beer

-(id) initWithDictionary: (NSDictionary *) dictionary
{
    if( (self = [super init]) == nil )
        return nil;
    self.beerAttrs = [NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName
{
    [self.beerAttrs setObject: attrVal forKey: attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr
{
    return [self.beerAttrs valueForKey: attr ];
}

-(NSString *) name {
    return ([self getValueForAttribute:@"beerName"]);
}



@end
