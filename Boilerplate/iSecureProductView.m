//
//  iSecureProductView.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "iSecureProductView.h"

static int padding = 5;
@implementation iSecureProductView


-(instancetype) initWithFrame:(CGRect)frame {
        
        self =[super initWithFrame:frame];
        if(self) {
            
            [self setBackgroundColor:[UIColor whiteColor]];
        
            self.category = [[UILabel alloc]initWithFrame: CGRectMake(0, padding, frame.size.width, 40)];
            [self.category setTextAlignment:NSTextAlignmentCenter];
            [self.category setFont:[UIFont boldSystemFontOfSize:14]];
            [self addSubview:self.category];
            
            self.title = [[UILabel alloc]initWithFrame: CGRectMake(0, self.category.frame.origin.y + self.category.frame.size.height + padding, frame.size.width, 40)];
            [self.title setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:self.title];
            
            self.imageView = [[UIImageView alloc]initWithFrame: CGRectMake(padding, self.title.frame.origin.y + self.title.frame.size.height + padding, frame.size.width - (2 * padding), 150)];
            [self.imageView setBackgroundColor:[UIColor yellowColor]];
            [self addSubview:self.imageView];
            
            self.price = [[UILabel alloc]initWithFrame: CGRectMake(0, self.imageView.frame.origin.y + self.imageView.frame.size.height + padding, frame.size.width, 40)];
            [self.price setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:self.price];
            
            self.descriptionText = [[UILabel alloc]initWithFrame: CGRectMake(0, self.price.frame.origin.y + self.price.frame.size.height + padding, frame.size.width, 100)];
            [self.descriptionText setTextAlignment:NSTextAlignmentCenter];
            [self.descriptionText setNumberOfLines:0];
            [self  addSubview:self.descriptionText];
        }

    return self;
}
    
@end
