//
//  DataParser.m
//  ExamTask
//
//  Created by George Prokopenko on 01/07/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "DataParser.h"
#import "DataObject.h"

typedef enum : NSInteger {
    kDataTypeJSONString,
    kDataTypeArray,
    kDataTypeUnknown,
} UnparsedDataType;

@implementation DataParser

+ (void) parseData:(id)unparsedData withCompletion:(void (^)(NSArray* array, NSError* error))completion {
    UnparsedDataType dataType = [self dataTypeForObject:unparsedData];
    
    if (dataType == kDataTypeJSONString) {
        NSError* serializationError;
        NSData *jsonData = [unparsedData dataUsingEncoding:NSUTF8StringEncoding];
        
        if (jsonData) {
            id outputObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&serializationError];
            
            if (outputObjects && [outputObjects isKindOfClass:[NSArray class]])
                completion([self parseDataObjectsFromArray:outputObjects], nil);
            
            if (serializationError) completion(nil, serializationError);
        }
        else {
            NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{@"errorMessage" : @"noInputData"}];
            completion(nil, error);
        }

    }
    
    else if (dataType == kDataTypeArray) {
        completion([self parseDataObjectsFromArray:unparsedData], nil);
    }
    
    else if (dataType == kDataTypeUnknown) {
        NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{@"errorMessage" : @"unknownInputData"}];
        completion(nil, error);
    }
}

+ (UnparsedDataType) dataTypeForObject:(id)object {
    if ([object isKindOfClass: [NSString class]]) return kDataTypeJSONString;
    if ([object isKindOfClass: [NSArray class]])  return kDataTypeArray;
    return kDataTypeUnknown;
}

+ (NSArray*) parseDataObjectsFromArray:(NSArray*)arrayOfDicts {
    NSMutableArray* outputArray = [NSMutableArray array];
    for (id dict in arrayOfDicts) {
        DataObject* parsedObject = [[DataObject alloc] initWithDictionary:dict];
        if (parsedObject) [outputArray addObject:parsedObject];
    }
    return outputArray;
}

@end
