//
//  SlidingView.h
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingView : UIView <UIScrollViewDelegate>


@property (nonatomic,retain) UIScrollView *horizontalScroller;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) UILabel *stepsLabel;

-(instancetype) initWithFrame:(CGRect)frame andArray :(NSArray *)arrayOfProducts andCurrentPage:(NSInteger)currentPageTopShow;

@end
