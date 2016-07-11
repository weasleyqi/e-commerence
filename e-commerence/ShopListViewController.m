//
//  ShopListViewController.m
//  e-commerence
//
//  Created by Weasley Qi on 16/7/4.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopListCell.h"
#import "Constant.h"
#import "AFNetworking.h"

@interface ShopListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *shoplistTableView;
@property (strong, nonatomic) NSArray *resultArr;

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.resultArr = [[NSArray alloc] init];
    
    [self loadData];
    
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/product/list.jhtml",Server];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"pageNumber" : @"1", @"pageSize": @"1", @"orderType": @"salesDesc", @"productCategoryId": @"0"};
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        self.resultArr = dict[@"returnValue"][@"products"];
        [_shoplistTableView reloadData];
//        [self doingAfterLogin:[responseObject stringValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoplistCell"];
    
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_resultArr[indexPath.row][@"image"]]]];
    [cell.imageView clipsToBounds];
    cell.shopName = _resultArr[indexPath.row][@"name"];
    cell.shopPrice = _resultArr[indexPath.row][@"price"];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"shopdetail" sender:self];
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
