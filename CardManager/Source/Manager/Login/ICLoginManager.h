//
//  ICLoginManager.h
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 29/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICBaseManager.h"
#import "ICUser.h"

@interface ICLoginManager : ICBaseManager

- (void)loginWithUsername:(NSString *)user
                 password:(NSString *)password
      withCompletionBlock:(void(^)(ICUser *user, BOOL success))completion;


@end
