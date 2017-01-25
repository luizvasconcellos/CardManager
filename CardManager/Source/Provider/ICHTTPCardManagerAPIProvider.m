//
//  ICHTTPCardManagerAPIProvider.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 28/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICHTTPCardManagerAPIProvider.h"

static NSString * const constBaseURL = @"http://cardmanagerserver.herokuapp.com";
//static NSString * const constEndPointVersion = @"1";

@implementation ICHTTPCardManagerAPIProvider

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    
    static ICHTTPCardManagerAPIProvider * _sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:constBaseURL];
        _sharedInstance = [[ICHTTPCardManagerAPIProvider alloc] initWithBaseURL:url];
    });
    
    return _sharedInstance;
}


#pragma mark - Endpoint

- (NSString *)setEndpointVersion:(NSString *)endpoint {
    NSString *endpointWithVersion = [NSString stringWithFormat:@"/%@", endpoint];
    
    return endpointWithVersion;
}
@end
