//
//  ICLoginProvider+User.h
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 28/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICHTTPCardManagerAPIProvider.h"

@interface ICHTTPCardManagerAPIProvider (User)

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(ICRequestOperationBlockSuccess)success
                  failure:(ICRequestOperationBlockFailure)failure;
@end
