//
//  ICLoginProvider+User.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 28/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICHTTPCardManagerAPIProvider+User.h"

@implementation ICHTTPCardManagerAPIProvider (User)

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(ICRequestOperationBlockSuccess)success
                  failure:(ICRequestOperationBlockFailure)failure {
    NSString *loginProfileUser = [self loginEndpoint];
    
    NSDictionary *parameters = @{@"email": username,
                                 @"password": password};
    
    [self POST:loginProfileUser
    parameters:parameters
      progress:nil
       success:success
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           
           AFHTTPRequestSerializer *serializer = self.requestSerializer;
           [serializer clearAuthorizationHeader];
           
           //DLog(@"Request error: %@", error.description);
           failure(error);
       }];
    }

#pragma mark - EndPoints

- (NSString *)loginEndpoint {
    NSString *endpoint = [self setEndpointVersion:@"login"];
    
    return endpoint;
}

@end
