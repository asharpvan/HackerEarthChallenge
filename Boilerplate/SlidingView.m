//
//  SlidingView.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "SlidingView.h"
#import "iSecureProductView.h"
#import "UIImageView+WebCache.h"

static int TopViewHeight = 30;
static int BottomViewHeight = 60;
static int ScreenUIControlHeight = 60;
static int ScreenUIContentPadding = 10;

@implementation SlidingView {
    
    UIView *topView;
    UIView *middleView;
    UIView *bottomView;
    NSArray *arrayOfProductsRecieved;
    UIButton *favButton;
    NSMutableArray *dbReplica;
}



@synthesize horizontalScroller,pageControl,stepsLabel;

-(instancetype) initWithFrame:(CGRect)frame andArray :(NSArray *)arrayOfProducts andCurrentPage:(NSInteger)currentPageTopShow  {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        
        dbReplica = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"]];
        NSLog(@"On Load dbReplica : %@",dbReplica);
        
        topView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, TopViewHeight)];
//        [topView setBackgroundColor:[UIColor greenColor]];
        [self addSubview:topView];
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - BottomViewHeight, self.frame.size.width, BottomViewHeight)];
//        [bottomView setBackgroundColor:[UIColor yellowColor]];
        [self addSubview:bottomView];
        
        //Bottom View Subviews
        favButton = [[UIButton alloc]initWithFrame:CGRectMake(bottomView.frame.origin.x + ScreenUIContentPadding, bottomView.frame.origin.y + ScreenUIContentPadding, bottomView.frame.size.width -  (ScreenUIContentPadding * 2), bottomView.frame.size.height -  (ScreenUIContentPadding * 2))];
        [favButton addTarget:self action:@selector(favButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [favButton setBackgroundColor:[UIColor blueColor]];
        [self addSubview:favButton];
        
        
        
        middleView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, topView.frame.origin.y + topView.frame.size.height, self.frame.size.width, self.frame.size.height - (TopViewHeight + BottomViewHeight))];
//                [middleView setBackgroundColor:[UIColor blueColor]];
//                [middleView setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:middleView];
        
        
        //Top View Subviews
        stepsLabel = [[UILabel alloc]initWithFrame:CGRectMake(topView.frame.size.width - (ScreenUIControlHeight + ScreenUIContentPadding), topView.frame.origin.y, ScreenUIControlHeight, topView.frame.size.height)];
        [stepsLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [stepsLabel setTextAlignment:NSTextAlignmentRight];
        [stepsLabel setTextColor:[UIColor whiteColor]];
        [topView addSubview:stepsLabel];
        
        // PAGE CONTROL
        pageControl = [[UIPageControl alloc]initWithFrame:topView.bounds];
        [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
        [pageControl setNumberOfPages:[arrayOfProducts count]];
        [pageControl setCurrentPage:currentPageTopShow];
        [topView addSubview:pageControl];
        
        //Middle View Subviews
        horizontalScroller = [[UIScrollView alloc] initWithFrame:middleView.frame];
//        [horizontalScroller setBackgroundColor:[UIColor orangeColor]];
        [horizontalScroller setPagingEnabled:TRUE];
        [horizontalScroller setShowsHorizontalScrollIndicator:FALSE];
        [horizontalScroller setDelegate:self];
        [self addSubview:horizontalScroller];
        
        arrayOfProductsRecieved = arrayOfProducts;
        
        [self createPaginatedPages];
    }
    
    return self;
}

-(void) createPaginatedPages {
    
    [self updatePageCount];
    
    [arrayOfProductsRecieved enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame;
        frame.origin.x = horizontalScroller.frame.size.width * idx + ScreenUIContentPadding;
        frame.origin.y = ScreenUIContentPadding;
        frame.size = CGSizeMake(horizontalScroller.frame.size.width - (ScreenUIContentPadding *2), horizontalScroller.frame.size.height - (ScreenUIContentPadding * 2));
        
        iSecureProductView *viewToAdd = [[iSecureProductView alloc]initWithFrame:frame];
        
        [[viewToAdd title] setText:[obj valueForKeyPath:@"title"]];
        [[viewToAdd descriptionText] setText:[NSString stringWithFormat:@"Description :\n%@",[obj valueForKeyPath:@"description"]]];
        [[viewToAdd category] setText:[obj valueForKeyPath:@"category"]];
        [[viewToAdd price] setText:[NSString stringWithFormat:@"    Price : %@",[obj valueForKeyPath:@"price"]]];
        [[viewToAdd imageView] sd_setImageWithURL:[obj valueForKeyPath:@"image"]];
        
        [[viewToAdd layer] setCornerRadius:10.0f];
        [[viewToAdd layer] setShadowColor:[UIColor blackColor].CGColor];
        [[viewToAdd layer] setShadowOpacity:0.8];
        [[viewToAdd layer] setShadowRadius:3.0];
        [[viewToAdd layer] setShadowOffset:CGSizeMake(2.0, 2.0)];
        [viewToAdd setClipsToBounds:TRUE];
        
        [horizontalScroller addSubview:viewToAdd];
        
    }];
    
    [horizontalScroller setContentOffset:CGPointMake(horizontalScroller.frame.size.width * [pageControl currentPage], 0)];
    horizontalScroller.contentSize =  CGSizeMake(horizontalScroller.frame.size.width * [arrayOfProductsRecieved count], horizontalScroller.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = horizontalScroller.frame.size.width;
    float fractionalPage = horizontalScroller.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
    [self updatePageCount];
}


-(void) updatePageCount {
    
    [stepsLabel setText:[NSString stringWithFormat:@"%ld/%ld",([pageControl currentPage] + 1),[arrayOfProductsRecieved count]]];
    [self updateButtonTitle];
    
    
}

-(void)dealloc {
    
    NSLog(@"dealloc");
    NSLog(@"On dealloc dbReplica : %@",dbReplica);
    [[NSUserDefaults standardUserDefaults] setObject:dbReplica forKey:@"Favorites"];
}

-(void) updateButtonTitle {
    
    NSString *buttonTitle;
    switch ([dbReplica containsObject:[NSNumber numberWithInteger:pageControl.currentPage]]) {
        case 0:
            buttonTitle = @"Add To Favorites";
            break;
        case 1:
            buttonTitle = @"Remove To Favorites";
            break;
        default:
            break;
    }
    
    [favButton setTitle:buttonTitle forState:UIControlStateNormal];
}

-(void) favButtonPressed {
    
    
    
    if(![dbReplica containsObject:[NSNumber numberWithInteger:pageControl.currentPage]]) {
        [dbReplica addObject:[NSNumber numberWithInteger:pageControl.currentPage]];
        
    }
    else {
        [dbReplica removeObject:[NSNumber numberWithInteger:pageControl.currentPage]];
    }

    [self updateButtonTitle];
   
}
@end
