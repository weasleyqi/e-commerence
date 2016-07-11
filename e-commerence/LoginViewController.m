//
//  LoginViewController.m
//  e-commerence
//
//  Created by Weasley Qi on 16/7/4.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "Constant.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn.layer setCornerRadius:5];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
    if([self checkStyle]){
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@/auth/login.jhtml",Server];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username" : _userName.text, @"password": _password.text};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self doingAfterLogin:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (BOOL )checkStyle{
    NSString *msg = @"";
    BOOL isfalse = NO;
    if ([_userName.text length] == 0) {
        msg = @"用户名不能为空！";
        isfalse = YES;
    }else if ([_password.text length] == 0) {
        msg = @"密码不能为空！";
        isfalse = YES;
    }
    if (isfalse) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    return isfalse;
}

- (void)doingAfterLogin:(NSString *)param {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
//    self.navigationItem.backBarButtonItem = NULL;
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
