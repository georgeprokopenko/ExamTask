//
//  DataLoader.h
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLoader : NSObject

+ (void) loadAllPostsWithCompletionBlock:(void (^)(id responseData, NSError* error))completionBlock;
+ (void) loadPost:(NSString*)postID withCompletionBlock:(void (^)(id responseData, NSError* error))completionBlock;

@end
