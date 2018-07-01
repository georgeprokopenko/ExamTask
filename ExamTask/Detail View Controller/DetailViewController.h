//
//  DetailViewController.h
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) DataObject* post;
@end
