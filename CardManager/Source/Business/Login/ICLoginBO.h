//
//  ICLoinBO.h
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 29/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICUser.h"

@interface ICLoginBO : NSObject

+ (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
                  success:(void(^)(ICUser *user))success
                  failure:(void(^)(NSError *error))failure;

@end
