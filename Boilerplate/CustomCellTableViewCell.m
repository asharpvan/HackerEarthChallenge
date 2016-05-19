//
//  CustomCellTableViewCell.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "CustomCellTableViewCell.h"

@implementation CustomCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //set the background for the content view
        self.profileImageView = [[UIImageView alloc]init];
        [self.profileImageView setContentMode:UIViewContentModeScaleAspectFit];
        
//        [self.profileImageView setBackgroundColor:[UIColor cyanColor]];
        
        //initialize Label for date
        self.lblCategory = [[UILabel alloc]init];
        [self.lblCategory setTextAlignment: NSTextAlignmentLeft];
        [self.lblCategory setNumberOfLines:0];
        [self.lblCategory setTextColor:[UIColor blackColor]];
//        [self.lblCategory setBackgroundColor:[UIColor greenColor]];
        
        self.lblPrice = [[UILabel alloc]init];
        [self.lblPrice setTextAlignment: NSTextAlignmentLeft];
        [self.lblPrice setNumberOfLines:0];
        [self.lblPrice setTextColor:[UIColor blackColor]];
//                [self.lblPrice setBackgroundColor:[UIColor blueColor]];
        
        self.lblTitle = [[UILabel alloc]init];
        [self.lblTitle setTextAlignment: NSTextAlignmentLeft];
        [self.lblTitle setNumberOfLines:0];
        [self.lblTitle setTextColor:[UIColor blackColor]];
//                [self.lblTitle setBackgroundColor:[UIColor yellowColor]];
        
        [self.contentView addSubview:self.profileImageView];
        [self.contentView addSubview:self.lblCategory];
        [self.contentView addSubview:self.lblPrice];
        [self.contentView addSubview:self.lblTitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //set the frame for date icon
    [self.profileImageView setFrame: CGRectMake(0,0,80,80)];
    [self.profileImageView setCenter:CGPointMake(self.profileImageView.center.x, self.contentView.center.y)];
//    [[self.profileImageView layer] setCornerRadius:90/2];
         [[self
.profileImageView layer] setCornerRadius:80/2];
    
    self.lblCategory.frame = CGRectMake(self.profileImageView.frame.origin.x + self.profileImageView.frame.size.width + 5,0,self.contentView.frame.size.width - (95),30);//90+5 = 95
    
    self.lblTitle.frame = CGRectMake(self.lblCategory.frame.origin.x,31,self.lblCategory.frame.size.width,30);
    
    self.lblPrice.frame = CGRectMake(self.lblCategory.frame.origin.x,61,self.lblCategory.frame.size.width,30);
 
    
//    //Add separator at the end of the cell.
//    UIBezierPath *cellSeparatorLine = [UIBezierPath bezierPath];
//    [cellSeparatorLine moveToPoint:CGPointMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y+self.contentView.frame.size.height-2)];
//    [cellSeparatorLine addLineToPoint:CGPointMake(self.contentView.frame.origin.x+self.contentView.frame.size.width, self.contentView.frame.origin.y+self.contentView.frame.size.height-2)];
//    CAShapeLayer *cellSeparator = [CAShapeLayer layer];
//    cellSeparator.path = [cellSeparatorLine CGPath];
//    cellSeparator.strokeColor = [[UIColor blackColor] CGColor];
//    cellSeparator.lineWidth = 4.0;
//    cellSeparator.fillColor = [[UIColor redColor] CGColor];
//    [self.contentView.layer addSublayer:cellSeparator];
}

@end
