//
//  PostViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 4/27/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "PostViewController.h"
#import "BarFeedViewController.h"
#import "BeerFeedViewController.h"
#import "Beer.h"
#import "Bar.h"
#import "DownloadAssistant.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (nonatomic) Bar * tagBar;
@property (nonatomic) Beer * tagBeer;
@property (weak, nonatomic) IBOutlet UIButton *beerTagButton;
@property (weak, nonatomic) IBOutlet UIButton *barTagButton;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToPost:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"Unwinding");
}

-(void) beerTagged: (Beer *) taggedBeer{
    self.tagBeer = taggedBeer;
    [self.beerTagButton setTitle:taggedBeer.name forState:UIControlStateNormal];
}

-(void) barTagged: (Bar *) taggedBar{
    self.tagBar = taggedBar;
    [self.barTagButton setTitle:taggedBar.name forState:UIControlStateNormal];
}

- (IBAction)postButtonPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userID = [[defaults objectForKey:@"userID"] integerValue];
    
    DownloadAssistant * loader = [[DownloadAssistant alloc] init];
    //loader.delegate = self;
    
    NSString *post = [NSString stringWithFormat:@"userID=%@&comment=%@&zipcode=12345&tags=1", @(userID), self.commentView.text];
    if (self.tagBar){
        post = [post stringByAppendingString:[NSString stringWithFormat:@"&pubID=%@", [self.tagBar getValueForAttribute:@"pubID"]]];
    }
    
    if(self.tagBeer){
        post = [post stringByAppendingString:[NSString stringWithFormat:@"&beerID=%@", [self.tagBeer getValueForAttribute:@"beerID"]]];
    }
    
    [loader postContentsOfURL:@"posts/newPost" withData:post];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toBeers"]){
        BeerFeedViewController * temp = [segue destinationViewController];
        temp.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"toBars"]){
        BarFeedViewController * temp = [segue destinationViewController];
        temp.delegate = self;
    }
}


@end
