//
//  ICTestNetworkConnectionProvider.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 24/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICTestNetworkConnectionProvider.h"
#import <SystemConfiguration/SCNetworkReachability.h>

@implementation ICTestNetworkConnectionProvider

+ (BOOL)isNetworkAvailable
{
    CFNetDiagnosticRef diagnosticReference;
    diagnosticReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (diagnosticReference, NULL);
    
    CFRelease (diagnosticReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is down");
        return NO;
    }
}

@end
