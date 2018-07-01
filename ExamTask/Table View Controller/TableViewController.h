//
//  TableViewController.h
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kTableVCShowPosts,
    kTableVCShowItemIDs,
} TableViewControllerMode;

@interface TableViewController : UIViewController

@property (assign, nonatomic) TableViewControllerMode viewControllerMode;
@property (strong, nonatomic) NSArray* posts;

@end
