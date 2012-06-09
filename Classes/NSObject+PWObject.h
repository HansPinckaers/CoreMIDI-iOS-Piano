//
//  NSObject+PWObject.h
//  Demo
//
//  Created by Hans Pinckaers on 01-06-12.
//  Copyright (c) 2012 Mauw Mobile. All rights reserved.
//

/* NSObject+PWObject.h */

#import <Foundation/Foundation.h>


@interface NSObject (PWObject)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
