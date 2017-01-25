//
//  ICHTTPCardManagerAPIProvider.h
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 28/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


typedef void (^ICRequestOperationBlockSuccess) (NSURLSessionDataTask *task, id responseObject);
typedef void (^ICRequestOperationBlockFailure) (NSError *error);

@interface ICHTTPCardManagerAPIProvider : AFHTTPSessionManager

+ (instancetype)sharedInstance;
- (NSString *)setEndpointVersion:(NSString *)endpoint;
@end
