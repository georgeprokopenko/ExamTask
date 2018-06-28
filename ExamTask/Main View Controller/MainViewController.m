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

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton* loadPostsButton;
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
}

- (IBAction)loadPosts:(id)sender {
    [self.activityIndicator startAnimating];
    self.loadPostsButton.enabled = NO;
    
    [DataLoader loadAllPostsWithCompletionBlock:^(id responseData, NSError *error) {
        [self.activityIndicator stopAnimating];
        self.loadPostsButton.enabled = YES;
        
        if (responseData) [self performSelectorOnMainThread:@selector(showPosts:) withObject:responseData waitUntilDone:NO];
        else [self performSelectorOnMainThread:@selector(showError) withObject:nil waitUntilDone:NO];
    }];
}

- (void) showPosts:(id)posts {
    if ([posts isKindOfClass:[NSArray class]]) {
        TableViewController* tableViewController = [[TableViewController alloc] init];
        tableViewController.posts = (NSArray*)posts;
        [self.navigationController pushViewController:tableViewController animated:YES];
    }
}

- (void) showError {
    [self.activityIndicator stopAnimating];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Smth went wrong. Try again." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
