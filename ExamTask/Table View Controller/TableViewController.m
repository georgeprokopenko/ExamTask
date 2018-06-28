//
//  TableViewController.m
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "DataLoader.h"

static NSString* cellIdentifier = @"cellIdentifier";

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation TableViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void) setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView setContentInset:UIEdgeInsetsMake(40, 0, 20, 0)];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary* post = self.posts[indexPath.row];
    cell.textLabel.text = post[@"title"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.activityIndicator startAnimating];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* post = self.posts[indexPath.row];
    [DataLoader loadPost:post[@"id"] withCompletionBlock:^(id responseData, NSError *error) {
        
        if (responseData) [self performSelectorOnMainThread:@selector(showDetailsOfPost:) withObject:responseData waitUntilDone:NO];
        else [self performSelectorOnMainThread:@selector(showError) withObject:nil waitUntilDone:NO];
    }];
}

- (void) showDetailsOfPost:(id)post {
    [self.activityIndicator stopAnimating];
    DetailViewController* detailViewController = [[DetailViewController alloc] init];
    detailViewController.post = (NSDictionary*)post;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void) showError {
    [self.activityIndicator stopAnimating];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Smth went wrong. Try again." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}











@end
