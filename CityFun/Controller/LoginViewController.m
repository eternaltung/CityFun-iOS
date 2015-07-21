//
//  LoginViewController.m
//  CityFun
//
//  Created by Shih-Ming Tung on 7/19/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "LoginViewController.h"
#import "MainController.h"
#import "UserModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPress:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            [[UserModel getUserClient] loginWithProvider:@"facebook" controller:self animated:YES completion:^(MSUser *user, NSError *error) {
                if (error == nil)
                    [self navigateToMainView:user.userId];
            }];
        }
            break;
        case 2:
        {
            [[UserModel getUserClient] loginWithProvider:@"google" controller:self animated:YES completion:^(MSUser *user, NSError *error) {
                if (error == nil)
                    [self navigateToMainView:user.userId];
            }];
        }
            break;
        case 3:
        {
            [[UserModel getUserClient] loginWithProvider:@"twitter" controller:self animated:YES completion:^(MSUser *user, NSError *error) {
                if (error == nil)
                    [self navigateToMainView:user.userId];
            }];
        }
            break;
        default:
            break;
    }
    
}

- (void)navigateToMainView:(NSString*)uID
{
    //save user
    [UserModel saveUser:uID];
    
    //navigation
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainController *mainView = [sb instantiateViewControllerWithIdentifier:@"MainView"];
    [self.navigationController pushViewController:mainView animated:YES];
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
