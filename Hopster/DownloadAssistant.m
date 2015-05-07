//
//  DownloadAssistant.m
//  SharedServicesActivityReportingSystem
//
//  Created by Ali Kooshesh on 12/25/13.
//  Copyright (c) 2013 Ali Kooshesh. All rights reserved.
//

#import "DownloadAssistant.h"

@interface DownloadAssistant()

@property (nonatomic) NSMutableData *inData;
@property (nonatomic) NSURLConnection *conn;
@property (nonatomic, strong) NSURL *url;

@end

@implementation DownloadAssistant


-(NSData *) downloadedData
{
    return _inData;
}

-(void) downloadContentsOfURL: (NSString *) inURL
{
    //NSString * baseURL = @"http://localhost:3000/";
    
    NSString * baseURL = @"http://hopster.herokuapp.com/";
    self.url = [NSURL URLWithString:[baseURL stringByAppendingString:inURL]];
    NSURLRequest *request = [NSURLRequest requestWithURL: self.url];
    if( _conn)
        [_conn cancel];
    _conn = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
}

-(void) postContentsOfURL: (NSString *) inURL withData: (NSString *) post
{
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    
    NSString * baseURL = @"http://hopster.herokuapp.com/";
    self.url = [NSURL URLWithString:[baseURL stringByAppendingString:inURL]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    
    
    NSLog(@"URL: %@", self.url);
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    if( _conn)
        [_conn cancel];
    _conn = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
}

-(NSMutableData *) inData
{
    if( ! _inData )
        _inData = [[NSMutableData alloc] init];
    return _inData;
}
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    
}

// Called each time some data arrives.
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    NSLog( @"received %@ bytes.", @([data length]));
    [self.inData appendData: data];
}

// Called when last segment arrives.
-(void) connectionDidFinishLoading: (NSURLConnection *) connection {
    NSLog( @"Finished download." );
    NSLog( @"The file has %@ bytes.", @([_inData length]));
    NSString *string = [[NSString alloc] initWithData:_inData encoding:NSUTF8StringEncoding];
    NSLog( @"%@", string);
    if( [self.delegate respondsToSelector:@selector(acceptWebData:forURL:)] )
        [self.delegate acceptWebData:_inData forURL:_url];
    _inData = nil;
        
}

// Called if the fetch fails.
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog( @"Connection failed: %@", error );
    _inData = nil;
}


@end
