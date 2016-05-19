//
//  iSecureProductView.h
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iSecureProductView : UIView
@property (nonatomic,retain) UILabel *title;
@property (nonatomic,retain) UILabel *descriptionText;
@property (nonatomic,retain) UILabel *price;
@property (nonatomic,retain) UILabel *category;
@property (nonatomic,retain) UIImageView *imageView;

-(instancetype) initWithFrame:(CGRect)frame;
@end
