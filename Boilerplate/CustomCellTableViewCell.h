//
//  CustomCellTableViewCell.h
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellTableViewCell : UITableViewCell
@property(nonatomic,retain) UIImageView *profileImageView;
@property(nonatomic, retain) UILabel *lblCategory;
@property(nonatomic, retain) UILabel *lblPrice;
@property(nonatomic, retain) UILabel *lblTitle;

@end
