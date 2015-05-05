//
//  SignUpViewController.m
//  Hopster
//
//  Created by Jeremy Swedroe on 4/20/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "SignUpViewController.h"
#import "DownloadAssistant.h"

@interface SignUpViewController ()
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *emailData;
@property (strong, nonatomic) NSString *passwordData;
@property (strong, nonatomic) NSString *zipcodeData;
@property DownloadAssistant *downloadAssistant;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)firstNameField:(UITextField *)sender {
    self.firstName = sender.text;
}
- (IBAction)lastNameField:(UITextField *)sender {
    self.lastName = sender.text;
}
- (IBAction)emailField:(UITextField *)sender {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:sender.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    self.emailData = sender.text;
}
- (IBAction)passwordField:(UITextField *)sender {
    if ([sender.text length] >= 5) {
        self.passwordData = sender.text;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO!" message:@"Password must be at least 5 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
}
- (IBAction)zipcodeField:(UITextField *)sender {
    self.zipcodeData = sender.text;
}
- (IBAction)clickedSubmit:(UIButton *)sender {
    
    NSString *post = [NSString stringWithFormat:@"fName=%@&lName=%@&email=%@&password=%@&zipcode=12345",self.firstName,self.lastName,self.emailData, self.passwordData];
    
    NSLog(@"%@", post);
    
    DownloadAssistant * loader = [[DownloadAssistant alloc] init];
    [loader setDelegate: self];
    
    [loader postContentsOfURL:@"users/createUser" withData:post];
    
}

-(void) acceptWebData:(NSData *)webData forURL:(NSURL *)url {
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];

    NSLog(@"callback for sign up: %@", jsonString);
    
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
