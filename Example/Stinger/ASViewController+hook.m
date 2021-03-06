//
//  ASViewController+hook.m
//  Stinger_Example
//
//  Created by Assuner on 2018/1/15.
//  Copyright © 2018年 Assuner-Lee. All rights reserved.
//

#import "ASViewController+hook.h"

@implementation ASViewController (hook)

+ (void)load {
  /*
   * hook class method @selector(class_print:)
   */
  [self st_hookClassMethod:@selector(class_print:) option:STOptionBefore usingIdentifier:@"hook_class_print_before" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---before class_print: %@", s);
  }];

  /*
   * hook @selector(print1:)
   */
  [self st_hookInstanceMethod:@selector(print1:) option:STOptionBefore usingIdentifier:@"hook_print1_before1" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---before1 print1: %@", s);
  }];

  [self st_hookInstanceMethod:@selector(print1:) option:STOptionBefore usingIdentifier:@"hook_print1_before2" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---before2 print1: %@", s);
  }];

  [self st_hookInstanceMethod:@selector(print1:) option:STOptionAfter usingIdentifier:@"hook_print1_after1" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---after1 print1: %@", s);
  }];

  [self st_hookInstanceMethod:@selector(print1:) option:STOptionAfter usingIdentifier:@"hook_print1_after2" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---after2 print1: %@", s);
  }];

  /*
   * hook @selector(print2:)
   */

  __block NSString *oldRet;
  [self st_hookInstanceMethod:@selector(print2:) option:STOptionInstead usingIdentifier:@"hook_print2_instead" withBlock:^NSString * (id<StingerParams> params, NSString *s) {
    [params invokeAndGetOriginalRetValue:&oldRet];
    NSString *newRet = [oldRet stringByAppendingString:@" ++ new-st_instead"];
    NSLog(@"---instead print2 old ret: (%@) / new ret: (%@)", oldRet, newRet);
    return newRet;
  }];

  [self st_hookInstanceMethod:@selector(print2:) option:STOptionAfter usingIdentifier:@"hook_print2_after1" withBlock:^(id<StingerParams> params, NSString *s) {
    NSLog(@"---after1 print2 self:%@ SEL: %@ p: %@",[params slf], NSStringFromSelector([params sel]), s);
  }];

  /*
   * hook @selector(testBlock:) test block
   */

  [self st_hookInstanceMethod:@selector(testBlock:) option:STOptionAfter usingIdentifier:@"hook_testBlock_after1" withBlock:^(id<StingerParams> params, testBlock block) {
    NSLog(@"test block value %f", block(2, 3));
  }];
}

@end
