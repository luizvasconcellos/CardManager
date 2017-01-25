//
//  ICUser.h
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 26/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICUser : NSObject

#pragma mark - properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *mail;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSString *imageProfileUrl;


#pragma mark - Inits
- (instancetype)initWithLoginResponse:(id)serviceResponse;

@end
