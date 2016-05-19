//
//  DetailsViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "DetailsViewController.h"
#import "SlidingView.h"


@interface DetailsViewController (){
   
    SlidingView *slidingView;
    NSArray *arrayRecieved;
    NSInteger currentPageRecieved;
    
}

@end

@implementation DetailsViewController


-(instancetype) initWithArray:(NSArray *) arrayPassed andCurrentPage:(NSInteger) currentPagePassed  {
    
    self = [super init];
    if(self) {
        
        [self setTitle:@"Detailed View"];
        [self.view setBackgroundColor:[UIColor blackColor]];
        arrayRecieved = arrayPassed;
        currentPageRecieved = currentPagePassed;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self createSubview];
}

-(void)createSubview {
    
    
    CGFloat navBarHeightPlusStatusBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication]statusBarFrame].size.height;
    NSLog(@"navBarHeightPlusStatusBarHeight : %f",navBarHeightPlusStatusBarHeight);
    
    slidingView = [[SlidingView alloc]initWithFrame:CGRectMake(0, navBarHeightPlusStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navBarHeightPlusStatusBarHeight) andArray:arrayRecieved andCurrentPage:currentPageRecieved];
    [self.view addSubview:slidingView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
