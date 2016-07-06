//
//  ShopListCell.h
//  e-commerence
//
//  Created by Weasley Qi on 16/7/6.
//  Copyright © 2016年 Weasley Qi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;

@end
