//
//  BeerFeedViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BeerFeedViewController.h"
#import "BeerDataSource.h"
#import "BeerDetailsViewController.h"

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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.dataSource = [[BeerDataSource alloc] initWithBeersAtURL:self.beerURL];
    self.dataSource.delegate = self;
    
    self.refreshControl= [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
    
    

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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    
    Beer * beer = [self.dataSource beerAtIndex:[indexPath row]];
    
    UILabel * titleLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel * breweryLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel * styleLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel * descrLabel = (UILabel *)[cell.contentView viewWithTag:8];
    
    NSLog(@"Beer name: %@", beer.name);
    //NSLog(@"cell: %@", cell);
    
    [titleLabel setText:beer.name];
    breweryLabel.text = [beer getValueForAttribute:@"breweryName"];
    styleLabel.text = [beer getValueForAttribute:@"styleName"];
    descrLabel.text = [beer getValueForAttribute:@"description"];

    
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender {
    [self.tableView reloadData];
    [sender endRefreshing];
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog([NSString stringWithFormat:@"beer selected: %@", [self.dataSource beerAtIndex:[indexPath row]]]);
    
    if([self.delegate respondsToSelector:@selector(beerTagged:)]){
        [self.delegate performSelector:@selector(beerTagged:) withObject:[self.dataSource beerAtIndex:[indexPath row]]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toBeerDetails"]){
        BeerDetailsViewController * nextController =  [segue destinationViewController];
        [nextController setBeer: [self.dataSource beerAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
    } else if ([[segue identifier] isEqualToString:@"backToPost"]) {
        if([self.delegate respondsToSelector:@selector(beerTagged:)]){
            [self.delegate performSelector:@selector(beerTagged:) withObject:[self.dataSource beerAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
        }
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

@end
