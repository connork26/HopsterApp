//
//  BarFeedViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "BarFeedViewController.h"
#import "BarDataSource.h"
#import "BarDetailsViewController.h"

@interface BarFeedViewController ()
@property(nonatomic) UIActivityIndicatorView *activityIndicator;
@property(nonatomic) BarDataSource * dataSource;
@end

static NSString * cellIdent = @"barCell";

@implementation BarFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * url = @"pubs/allPubs";
    

    self.dataSource = [[BarDataSource alloc] initWithBarsAtURL:url];
    self.dataSource.delegate = self;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter:self.view.center];
    [self.view addSubview:self.activityIndicator];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) dataSourceReadyForUse: (BarDataSource *) dataSource {
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfBars];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    Bar * bar = [self.dataSource barAtIndex:[indexPath row]];
    
    UILabel * nameLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel * addressLabel = (UILabel *) [cell.contentView viewWithTag:3];
    
    NSString * street = [NSString stringWithFormat:@"%@, %@ %@", [bar getValueForAttribute:@"streetAddress"], [bar getValueForAttribute:@"city"],[bar getValueForAttribute:@"stateAbrv"]];
        
    nameLabel.text = [bar getValueForAttribute:@"name"];
    addressLabel.text = street;
    
    return cell;
}


-(void) refreshTableView: (UIRefreshControl *) sender {
    [self.tableView reloadData];
    [sender endRefreshing];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"backToPost"]) {
        if([self.delegate respondsToSelector:@selector(barTagged:)]){
            [self.delegate performSelector:@selector(barTagged:) withObject:[self.dataSource barAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
        }
    } else if ([[segue identifier] isEqualToString:@"toDetails"]){
        BarDetailsViewController * temp = [segue destinationViewController];
        [temp setBar:[self.dataSource barAtIndex:[[self.tableView indexPathForSelectedRow] row]]];
    }
}


@end
