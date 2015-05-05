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

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentView;

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
    NSLog(@"Tagged beer: %@", taggedBeer.name);
}

-(void) barTagged: (Bar *) taggedBar{
    
}

- (IBAction)postButtonPressed:(id)sender {
    
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
