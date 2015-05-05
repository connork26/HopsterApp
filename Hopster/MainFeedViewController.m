//
//  MainFeedViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 3/30/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "MainFeedViewController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import "PostsDataSource.h"

@interface MainFeedViewController ()

@property (nonatomic) PostsDataSource * dataSource;
@property (nonatomic) NSString * postURL;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation MainFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postURL = @"posts/postsForUser?userID=0";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userID = [[defaults objectForKey:@"userID"] integerValue];
    
    [self.tabBarController setTitle:@"Feed"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.dataSource = [[PostsDataSource alloc] initWithPostsAtURL:self.postURL];
    self.dataSource.delegate = self;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void) refreshTableView: (UIRefreshControl *) sender {
    [self.tableView reloadData];
    [sender endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (![self.dataSource dataSourceReadyForUse]){
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped:YES];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfPosts];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
/*
    Post * post = [self.dataSource postAtIndex:[indexPath row]];
    UILabel * usernameLabel = (UILabel *) [cell.contentView viewWithTag:1];
    UILabel * dateLabel = (UILabel *) [cell.contentView viewWithTag:2];
    UILabel * commentLabel = (UILabel *) [cell.contentView viewWithTag:3];
    UILabel * beerLabel = (UILabel *) [cell.contentView viewWithTag:4];
    UILabel * barLabel = (UILabel *) [cell.contentView viewWithTag:5];
    
    usernameLabel.text = [post getValueForAttribute:@"userName"];
    commentLabel.text = [post getValueForAttribute:@"comment"];
    dateLabel.text = [post getValueForAttribute:@"postedAt"];
    
    if (![[post getValueForAttribute:@"beerName"] isEqualToString:@"NULL"]){
        beerLabel.text = [post getValueForAttribute:@"beerName"];
    } else {
        beerLabel.text = @"";
    }
    
    if (![[post getValueForAttribute:@"pubName"] isEqualToString:@"NULL"]){
        barLabel.text = [post getValueForAttribute:@"pubName"];
    } else {
        barLabel.text = @"";
    }
*/    
    return cell;
}

-(void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void) dataSourceReadyForUse: (PostsDataSource *) dataSource {
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
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
