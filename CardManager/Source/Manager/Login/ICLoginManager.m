//
//  ICLoginManager.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 29/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICLoginManager.h"
#import "ICLoginBO.h"

@implementation ICLoginManager

- (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
      withCompletionBlock:(void(^)(ICUser *user, BOOL success))completion{
    
    [self.mainQueue addOperationWithBlock:^{
        [ICLoginBO loginWithUsername:user
                            password:password
                             success:^(ICUser *user) {
                                 completion(user, YES);
                             }
                             failure:^(NSError *error) {
                                 completion(nil, NO);
                             }];
    }];
    
}
@end
