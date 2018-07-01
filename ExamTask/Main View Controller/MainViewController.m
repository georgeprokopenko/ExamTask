//
//  MainViewController.m
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"
#import "DataLoader.h"
#import "DataParser.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton* loadPostsButton;
@property (weak, nonatomic) IBOutlet UIButton* loadIdsButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation MainViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void) setupViews {
    self.loadPostsButton.layer.cornerRadius = self.loadPostsButton.bounds.size.height/2;
    self.loadIdsButton.layer.cornerRadius = self.loadPostsButton.layer.cornerRadius;
}

- (IBAction)loadPosts:(id)sender {
    [self.activityIndicator startAnimating];
    self.loadPostsButton.enabled = NO;
    
    [DataLoader loadAllPostsWithCompletionBlock:^(id responseData, NSError *error) {
        [self.activityIndicator stopAnimating];
        self.loadPostsButton.enabled = YES;
        
        if (responseData) [DataParser parseData:responseData withCompletion:^(NSArray *array, NSError *error) {
            if (array) [self showObjectsList:array mode:kTableVCShowPosts];
            else [self showError];
        }];
        else [self showError];
    }];
}

- (IBAction)loadItemIds:(id)sender {
    [self.activityIndicator startAnimating];
    self.loadPostsButton.enabled = NO;
    
    [DataLoader loadAllPostsWithCompletionBlock:^(id responseData, NSError *error) {
        [self.activityIndicator stopAnimating];
        self.loadPostsButton.enabled = YES;
        
        if (responseData) [DataParser parseData:responseData withCompletion:^(NSArray *array, NSError *error) {
            if (array) [self showObjectsList:array mode:kTableVCShowItemIDs];
            else [self showError];
        }];
        else [self showError];
    }];
}


- (void) showObjectsList:(NSArray*)objects mode:(TableViewControllerMode)mode {
    TableViewController* tableViewController = [[TableViewController alloc] init];
    tableViewController.viewControllerMode = mode;
    tableViewController.posts = objects;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:tableViewController animated:YES];
    });
}

- (void) showError {
    [self.activityIndicator stopAnimating];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Smth went wrong. Try again." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}


@end
