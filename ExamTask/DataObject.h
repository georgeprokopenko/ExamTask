//
//  DataObject.h
//  ExamTask
//
//  Created by George Prokopenko on 01/07/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataObject : NSObject

@property NSInteger itemId;
@property NSString* title;
@property NSString* body;

- (instancetype) initWithDictionary:(NSDictionary*)dict;

@end
