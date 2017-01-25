//
//  ICValidateStringBO.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 24/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICValidateStringBO.h"

@implementation ICValidateStringBO
+(BOOL) isValidMailType: (NSString *)mailString {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:mailString];
}
@end
