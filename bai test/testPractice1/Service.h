//
//  Service.h
//  testPractice1
//
//  Created by binh on 3/26/18.
//  Copyright © 2018 binh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Service : NSObject
+(void)getData:(NSString*)urlString block:(void (^)(NSDictionary*dict))iteratorBlock;

@end
