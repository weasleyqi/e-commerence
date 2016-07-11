//
//  ShopDetailViewController.m
//  e-commerence
//
//  Created by Weasley Qi on 16/7/4.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "AFNetworking.h"
#import "Constant.h"

@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/product/detail/product/408.jhtml",Server];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"pageNumber" : @"1", @"pageSize": @"1", @"orderType": @"salesDesc", @"productCategoryId": @"0"};
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        [self doingAfterLogin:[responseObject stringValue]];
        if ([responseObject[@"success"] intValue] == 1) {
            _detailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://121.41.5.225/upload/image/201507/108fa684-9b30-40ec-b134-4f838384e6ad.jpg"]]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
