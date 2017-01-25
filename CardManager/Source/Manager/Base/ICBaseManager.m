//
//  ICBaseManager.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 29/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICBaseManager.h"

@implementation ICBaseManager

/**
 *  This Operation queue should be used whenever one view controller needs Pause Stop Resume or Cancel operations
 */
- (NSOperationQueue *)mainQueue {
    if (!_mainQueue) {
        _mainQueue = [NSOperationQueue new];
    }
    
    return _mainQueue;
}

@end
