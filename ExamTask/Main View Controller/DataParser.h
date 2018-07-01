//
//  DataParser.h
//  ExamTask
//
//  Created by George Prokopenko on 01/07/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataParser : NSObject

+ (void) parseData:(id)unparsedData withCompletion:(void (^)(NSArray* array, NSError* error))completion;

@end
