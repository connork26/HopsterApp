//
//  BarDataSource.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/12/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BarDataSource.h"

@interface BarDataSource (){
    BOOL debug;
}

@property (nonatomic) DownloadAssistant *downloadAssistant;
@property (nonatomic) NSData * barData;
@property (nonatomic) NSMutableArray * allBars;

@end

@implementation BarDataSource

-(instancetype)initWithBarsAtURL:(NSString *)url {
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
    self.barData = webData;
    
    NSError *parseError = nil;
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:self.barData options:0 error:&parseError];
    if( debug )
        NSLog(@"%@", jsonString);
    if( parseError ) {
        NSLog(@"Badly formed JSON string. %@", [parseError localizedDescription] );
        return;
    }
    
    for (NSDictionary * barIn in jsonString) {
        Bar * temp = [[Bar alloc] initWithDictionary:barIn];
        [self.allBars addObject:temp];
    }
    
    if([self.delegate respondsToSelector:@selector(dataSourceReadyForUse:)]){
        [self.delegate performSelector:@selector(dataSourceReadyForUse:) withObject:self];
    }
    
    self.dataSourceReadyForUse = YES;
    
}

-(NSMutableArray *) getAllbars {
    return self.allBars;
}

-(NSInteger) numberOfBars {
    return [self.allBars count];
}

-(Bar *) barAtIndex:(NSInteger) index {
    return [self.allBars objectAtIndex: index];
}

-(NSMutableArray *) allBars {
    if (! _allBars){
        _allBars = [[NSMutableArray alloc] init];
    }
    
    return _allBars;
}
@end
