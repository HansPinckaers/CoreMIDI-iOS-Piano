//
//  NSObject+PWObject.m
//  Demo
//
//  Created by Hans Pinckaers on 01-06-12.
//  Copyright (c) 2012 Mauw Mobile. All rights reserved.
//

/* NSObject+PWObject.m */

#import "NSObject+PWObject.h"


@implementation NSObject (PWObject)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

@end