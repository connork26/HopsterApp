//
//  Post.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/29/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

-(id) initWithDictionary: (NSDictionary *) dictionary;
-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
-(NSString *) getValueForAttribute: (NSString *) attr;


@end
