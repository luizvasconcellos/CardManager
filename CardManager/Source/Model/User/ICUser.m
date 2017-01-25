//
//  ICUser.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 26/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICUser.h"

@implementation ICUser

- (instancetype)initWithLoginResponse:(id)serviceResponse {
    if (self = [super init]) {
        [self userFromLoginresponse:serviceResponse];
    }
    
    return self;
}

-(void) userFromLoginresponse:(id)response{
    NSDictionary *responseObject = response;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        self.name = responseObject[@"name"];
        self.imageProfileUrl = responseObject[@"image_profile"];
    }
}

@end
