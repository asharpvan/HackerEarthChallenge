//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "iSecureDataModel.h"
#import "iSecureProductDataModel.h"
#import "DetailsViewController.h"
#import "CustomCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TWMessageBarManager.h"

@interface ViewController () {
    
    UIActivityIndicatorView *fetcActivityIndicator;
    UITableView *iSecureProductsTableView;
    NSArray *arrayOfiSecureProducts;
    
    NSMutableArray *searchData;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    
    UILabel *apiPercentage;
    NSNumber *api_Max;
    NSNumber *api_Available;
}

@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {

        [self setTitle:@"Dark Matter"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        fetcActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [fetcActivityIndicator setCenter:self.view.center];
        [fetcActivityIndicator setHidesWhenStopped:TRUE];
        [self.view addSubview:fetcActivityIndicator];

    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    if(!iSecureProductsTableView)
        [self createSubview];
}
-(void)createSubview {
    
    
    CGFloat navBarHeightPlusStatusBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication]statusBarFrame].size.height;
    NSLog(@"navBarHeightPlusStatusBarHeight : %f",navBarHeightPlusStatusBarHeight);
    
    
    iSecureProductsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navBarHeightPlusStatusBarHeight + searchBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - (40 + navBarHeightPlusStatusBarHeight))];
    [iSecureProductsTableView setHidden:TRUE];
    [iSecureProductsTableView setDataSource:self];
    [iSecureProductsTableView setDelegate:self];
//    [iSecureProductsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:iSecureProductsTableView];

    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.displaysSearchBarInNavigationBar = FALSE;
    [searchDisplayController.searchResultsTableView setRowHeight:90];
    [searchDisplayController.searchResultsTableView setDelegate:self];
    [searchDisplayController.searchResultsTableView setDataSource:self];
    iSecureProductsTableView.tableHeaderView = searchBar;
    
    apiPercentage = [[UILabel alloc]initWithFrame:CGRectMake(0, iSecureProductsTableView.frame.size.height + iSecureProductsTableView.frame.origin.y, iSecureProductsTableView.frame.size.width, 40)];
    [apiPercentage setHidden:TRUE];
    [apiPercentage setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:apiPercentage];
}
    


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if(!arrayOfiSecureProducts)
        [self startFetching];
    
}

-(void)startFetching {
    
    NSLog(@"Start Fetching");
    
    [fetcActivityIndicator startAnimating];
    
    [APIClient fetchiSecureData:^(iSecureDataModel *returnedDataModel, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{

        [fetcActivityIndicator stopAnimating];
        if(!error) {
            NSLog(@"Success");
            arrayOfiSecureProducts = [returnedDataModel productArray];
            searchData = [NSMutableArray arrayWithCapacity:[arrayOfiSecureProducts count]];
            api_Max = [returnedDataModel quota_max];
            NSLog(@"api Max : %@",api_Max);
            api_Available = [returnedDataModel quota_available];
            NSLog(@"api_Available : %@",api_Available);
            [self hideSpinnerAndShowTableView];
            
        }else {
            NSLog(@"Failure");
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:[NSString stringWithFormat:@"%ld",[error code]] description:[NSString stringWithFormat:@"%@",[error localizedDescription]] type:TWMessageBarMessageTypeError];
            }
        });
    }];
}

-(void) hideSpinnerAndShowTableView {
    
    
    [fetcActivityIndicator stopAnimating];
    [iSecureProductsTableView reloadData];
    [iSecureProductsTableView setHidden:FALSE];
    
    NSLog(@"API Percentage %ld",[api_Available integerValue]/[api_Max integerValue]);
    [apiPercentage setText:[NSString stringWithFormat:@"API Quota : %ld%%",[api_Available integerValue]/[api_Max integerValue]]];
    [apiPercentage setHidden:FALSE];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.searchDisplayController.searchResultsTableView)
        return  [searchData count];
    else
        return [arrayOfiSecureProducts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"HistoryCell";
    // Similar to UITableViewCell, but
    CustomCellTableViewCell *cell = (CustomCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    iSecureProductDataModel *nowShowing;
    if (tableView == self.searchDisplayController.searchResultsTableView)
        nowShowing = [searchData objectAtIndex:indexPath.row];
    else
        nowShowing = [arrayOfiSecureProducts objectAtIndex:indexPath.row];
    
    [cell.lblCategory setText:[nowShowing valueForKeyPath:@"category"]];
    [cell.lblTitle setText:[nowShowing valueForKeyPath:@"title"]];
    [cell.lblPrice setText:[nowShowing valueForKeyPath:@"price"]];
    
    [cell.profileImageView sd_setImageWithURL:[nowShowing valueForKeyPath:@"image"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
     

     
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Row selected!!");
    
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    NSInteger row;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        NSLog(@"%@",[searchData objectAtIndex:indexPath.row]);
        
        row = [arrayOfiSecureProducts indexOfObject:[searchData objectAtIndex:indexPath.row]];
        
        
    }else {
        
        row = indexPath.row;
    }
    
    DetailsViewController *detailsVC = [[DetailsViewController alloc]initWithArray:arrayOfiSecureProducts andCurrentPage:row];
    [self.navigationController pushViewController:detailsVC animated:TRUE];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    //*******************************************************************************//
//    //Think  And Build Animation
//    //*******************************************************************************//
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
//    //*******************************************************************************//
    
//    //*******************************************************************************//
//    //Jaded Mind
//    //*******************************************************************************//
//    //Create an animation with pulsating effect
//    CABasicAnimation *theAnimation;
//    //within the animation we will adjust the "opacity"
//    //value of the layer
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
//    //animation lasts 0.4 seconds
//    theAnimation.duration=0.4;
//    //and it repeats forever
//    theAnimation.repeatCount= 1;
//    //we want a reverse animation
//    theAnimation.autoreverses=YES;
//    //justify the opacity as you like (1=fully visible, 0=unvisible)
//    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
//    theAnimation.toValue=[NSNumber numberWithFloat:0.1];
//    //Assign the animation to your UIImage layer and the
//    //animation will start immediately
//    [cell.layer addAnimation:theAnimation forKey:@"animateOpacity"];
//    //*******************************************************************************//
    
    
    //*******************************************************************************//
    //Table View Tutorial
    //*******************************************************************************//
//    if (tableView.isDragging) {
//        UIView *myView = cell.contentView;
//        CALayer *layer = myView.layer;
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
////        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI*0.5, 1.0f, 0.0f, 0.0f);
//        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI*0.5, 1.0f, 0.0f, 0.0f);
//      layer.transform = rotationAndPerspectiveTransform;
//        [UIView animateWithDuration:.5 animations:^{
//            layer.transform = CATransform3DIdentity;
//        }];
//    }
    //*******************************************************************************//
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [searchData removeAllObjects];
    
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"category contains[c] %@", searchText];
    NSPredicate *descriptionPredicate = [NSPredicate predicateWithFormat:@"description contains[c] %@", searchText];
    NSPredicate *pricePredicate = [NSPredicate predicateWithFormat:@"price contains[c] %@", searchText];
    
    
    NSPredicate * orPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:[NSArray arrayWithObjects:titlePredicate,categoryPredicate,descriptionPredicate,pricePredicate, nil]];
    searchData = [NSMutableArray arrayWithArray: [arrayOfiSecureProducts filteredArrayUsingPredicate:orPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
@end
