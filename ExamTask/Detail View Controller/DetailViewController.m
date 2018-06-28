//
//  DetailViewController.m
//  ExamTask
//
//  Created by Prokopenko Georgy on 27/06/2018.
//  Copyright © 2018 Prokopenko George. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation DetailViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    self.titleLabel.text = self.post[@"title"];
    self.descriptionLabel.text = self.post[@"body"];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
