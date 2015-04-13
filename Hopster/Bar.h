//
//  Bar.h
//  Hopster
//
//  Created by Connor Kuehnle on 4/12/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bar : NSObject

-(id) initWithDictionary: (NSDictionary *) dictionary;
-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
-(NSString *) getValueForAttribute: (NSString *) attr;
-(NSString *) name;

@end
