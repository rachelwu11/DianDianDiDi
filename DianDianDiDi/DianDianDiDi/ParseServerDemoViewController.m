//
//  ParseServerDemoViewController.m
//  DianDianDiDi
//
//  Created by rachel on 3/12/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "ParseServerDemoViewController.h"
#import "PFUser.h"

@interface ParseServerDemoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ParseServerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"Log In";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLoginTapped:(id)sender {

    if ([self.userNameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Missing Information" message:@"Username and Password fields cannot be empty. Please enter and try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            NSLog(@"user:%@, error: %@", user, error);
        }];
    }





}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
