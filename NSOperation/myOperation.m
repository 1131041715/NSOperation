//
//  myOperation.m
//  NSOperation
//
//  Created by 大碗豆 on 17/5/16.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "myOperation.h"

@implementation myOperation


- (void)main{
    
    for (NSInteger i = 0; i < 5000 ; i ++) {
        NSLog(@"------1----%@",[NSThread currentThread]);
    }
    
    if (self.cancelled) {
        return;
    }
    
    for (NSInteger i = 0; i < 5000 ; i ++) {
        NSLog(@"------2----%@",[NSThread currentThread]);
    }
    
    if (self.cancelled) {
        return;
    }
    
    for (NSInteger i = 0; i < 5000 ; i ++) {
        NSLog(@"------3----%@",[NSThread currentThread]);
    }
    
    if (self.cancelled) {
        return;
    }
    
    for (NSInteger i = 0; i < 5000 ; i ++) {
        NSLog(@"------4----%@",[NSThread currentThread]);
    }
    
    if (self.cancelled) {
        return;
    }
}

@end
