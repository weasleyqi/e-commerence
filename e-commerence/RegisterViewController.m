//
//  RegisterViewController.m
//  e-commerence
//
//  Created by Weasley Qi on 16/7/4.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "Constant.h"

@interface RegisterViewController (){
    
}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirm;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender {
    [self checkStyle];
    NSString *url = [NSString stringWithFormat:@"%@/auth/register.jhtml",Server];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username" : _userName.text, @"password": _password.text};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self doingAfterRegister:[responseObject stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//检查注册内容是否齐全
- (void)checkStyle{
    NSString *str = @"";
    if ([_userName.text length]==0) {
        str = @"用户名不能为空！";
    }else if([_password.text length] == 0){
        str = @"密码不能为空！";
    }else if ([_passwordConfirm.text length] == 0 ){
        str = @"密码确认不能为空！";
    }else if (_password.text == _passwordConfirm.text) {
        str = @"两次密码不相同！";
    }else{
        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
    [alert show];
    return;
}

- (void) doingAfterRegister:(NSString *)param {
    
}

@end
