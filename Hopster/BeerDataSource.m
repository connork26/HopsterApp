//
//  BeerDataSource.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/7/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerDataSource.h"
#import "DownloadAssistant.h"

@interface BeerDataSource (){
    BOOL debug;
};

@property (nonatomic) DownloadAssistant *downloadAssistant;
@property (nonatomic) NSData * beerData;
@property (nonatomic) NSMutableArray * allBeers;

@end


@implementation BeerDataSource

-(instancetype)initWithBeersAtURL:(NSString *)url {
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
    self.beerData = webData;
    
    NSError *parseError = nil;
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:self.beerData options:0 error:&parseError];
    if( debug )
        NSLog(@"%@", jsonString);
    if( parseError ) {
        NSLog(@"Badly formed JSON string. %@", [parseError localizedDescription] );
        return;
    }
    
    for (NSDictionary * beerIn in jsonString) {
        Beer * temp = [[Beer alloc] initWithDictionary:beerIn];
        [self.allBeers addObject:temp];
    }
    
    if([self.delegate respondsToSelector:@selector(dataSourceReadyForUse:)]){
        [self.delegate performSelector:@selector(dataSourceReadyForUse:) withObject:self];
    }
    
    self.dataSourceReadyForUse = YES;

}

-(NSMutableArray *) getAllBeers {
    return self.allBeers;
}

-(NSInteger) numberOfBeers {
    return [self.allBeers count];
}

-(Beer *) beerAtIndex:(NSInteger) index {
    return [self.allBeers objectAtIndex: index];
}

-(NSMutableArray *) allBeers {
    if (! _allBeers){
        _allBeers = [[NSMutableArray alloc] init];
    }
    
    return _allBeers;
}

@end
