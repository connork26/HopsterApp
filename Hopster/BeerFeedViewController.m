//
//  BeerFeedViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerFeedViewController.h"
#import "BeerDataSource.h"

@interface BeerFeedViewController ()

@property (nonatomic) BeerDataSource * dataSource;
@property (nonatomic) NSString * beerURL;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end

static NSString * cellIdent = @"beerCell";

@implementation BeerFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beerURL = @"beers/allBeers";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdent];
    
    self.dataSource = [[BeerDataSource alloc] initWithBeersAtURL:self.beerURL];
    self.dataSource.delegate = self;
    
    self.refreshControl= [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dataSourceReadyForUse: (BeerDataSource *) dataSource {
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![self.dataSource dataSourceReadyForUse]){
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped:YES];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfBeers];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    Beer * beer = [self.dataSource beerAtIndex:[indexPath row]];
    
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel * breweryLabel = (UILabel *)[cell viewWithTag:2];
    UILabel * styleLabel = (UILabel *)[cell viewWithTag:3];
    
    NSLog(@"Beer name: %@", beer.name);
    
    [titleLabel setText:beer.name];
    breweryLabel.text = [beer getValueForAttribute:@"breweryName"];
    styleLabel.text = [beer getValueForAttribute:@"styleName"];

    
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender {
    [self.tableView reloadData];
    [sender endRefreshing];
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
