//
//  DataObject.m
//  ExamTask
//
//  Created by George Prokopenko on 01/07/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "DataObject.h"

@implementation DataObject

- (instancetype) initWithDictionary:(NSDictionary*)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) return nil;
    
    self = [super init];
    
    self.itemId = [dict[@"id"] integerValue];
    self.title = dict[@"title"];
    self.body = dict[@"body"];
    
    return self;
}

@end
