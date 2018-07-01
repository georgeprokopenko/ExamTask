//
//  DataLoader.m
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "DataLoader.h"
@import AFNetworking;

#define ALL_POSTS @"https://jsonplaceholder.typicode.com/posts"
#define SPECIFIED_POST(a) [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/posts/%li", (long)a]

@implementation DataLoader

+ (void) loadAllPostsWithCompletionBlock:(void (^)(id responseData, NSError* error))completionBlock {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:ALL_POSTS parameters:nil progress:nil
         success:^(NSURLSessionDataTask* task, id responseObject){
             if (completionBlock) completionBlock (responseObject, nil);
    }
         failure:^(NSURLSessionDataTask* task, NSError* error) {
             if (completionBlock) completionBlock (nil, error);
    }];
}

+ (void) loadPost:(NSInteger)postID withCompletionBlock:(void (^)(id responseData, NSError* error))completionBlock {
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:SPECIFIED_POST(postID) parameters:nil progress:nil
         success:^(NSURLSessionDataTask* task, id responseObject){
             if (completionBlock) completionBlock (responseObject, nil);
         }
         failure:^(NSURLSessionDataTask* task, NSError* error) {
             if (completionBlock) completionBlock (nil, error);
         }];
}

@end
