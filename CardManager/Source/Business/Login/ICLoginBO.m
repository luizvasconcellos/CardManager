//
//  ICLoinBO.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 29/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICLoginBO.h"
#import "ICHTTPCardManagerAPIProvider+User.h"

@implementation ICLoginBO

+ (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
                  success:(void(^)(ICUser *user))success
                  failure:(void(^)(NSError *error))failure {
    
    ICHTTPCardManagerAPIProvider *sessionManager = [ICHTTPCardManagerAPIProvider sharedInstance];
    
    [sessionManager loginWithUsername:user
                             password:password
                              success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //ALog(@"Login .with success");
         ICUser *user = [[ICUser alloc] initWithLoginResponse:responseObject];
         success(user);
         
     } failure:^(NSError *error) {
         NSLog(@"Error on login." );
         //NSLog(*error);
         //ALog(@"Error on login.");
         //error handling
         
         failure(error);
     }];
}

@end
