//
//  Service.m
//  testPractice1
//
//  Created by binh on 3/26/18.
//  Copyright © 2018 binh. All rights reserved.
//

#import "Service.h"
#import "AFNetworking.h"

@implementation Service
+(void)getData:(NSString *)urlString block:(void (^)(NSDictionary *dict))iteratorBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *valueDict = responseObject;
        iteratorBlock(valueDict); // save to block
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
