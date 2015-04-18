//
//  FirstViewController.m
//  Hopster
//
//  Created by Connor Kuehnle on 3/24/15.
//  Copyright (c) 2015 Connor Kuehnle. All rights reserved.
//

#import "FirstViewController.h"
#import "DownloadAssistant.h"
#import <Security/Security.h>

typedef NS_ENUM(NSInteger, LoginStatus){
    NOTLOGGEDIN,
    INVALID,
    VALID
};

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic) NSDictionary * userInfo;

@property (nonatomic) LoginStatus status;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [defaults objectForKey:@"userID"]);
    
    if((NSString *)[defaults objectForKey:@"userID"] ){
        [self performSegueWithIdentifier:@"toMainFeed" sender:self];
    }
    
    self.status = NOTLOGGEDIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"toMainFeed"]){
        if([self.emailTextField.text length] == 0){
            self.errorLabel.text = @"Enter your email!";
            return NO;
        }
        
        if ([self.passwordTextField.text length] == 0){
            self.errorLabel.text = @"Enter your password!";
            return NO;
        }
        
        
        if (self.status == INVALID || self.status == NOTLOGGEDIN){
            self.status = NOTLOGGEDIN;
            return NO;
        }
            
        return YES;
    }
    
    return YES;

}

- (IBAction)onSubmitButtonPressed:(UIButton *)sender {
    if([self.emailTextField.text length] == 0 || [self.passwordTextField.text length] == 0){
        return;
    }
    
    DownloadAssistant * download = [[DownloadAssistant alloc] init];
    [download setDelegate: self];
    [download downloadContentsOfURL:[NSString stringWithFormat:@"users/login?email=%@&password=%@", self.emailTextField.text, self.passwordTextField.text]];
}

- (IBAction)onSignUpButtonPressed:(UIButton *)sender {
    
}

-(void) acceptWebData: (NSData *) webData forURL: (NSURL *) url{
    self.userInfo = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
    
    if ([self.userInfo objectForKey:@"error"]) {
        self.errorLabel.text = @"Invalid login!";
        self.status = INVALID;
        return;
    }
    
    NSLog(@"Logged in! First Name: %@", [self.userInfo objectForKey:@"fName"]);
    self.status = VALID;
    
    [self performSegueWithIdentifier:@"toMainFeed" sender:self];
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[self.userInfo objectForKey:@"fName"] forKey:@"fName"];
    [defaults setObject:[self.userInfo objectForKey:@"lName"] forKey:@"lName"];
    [defaults setInteger:[[self.userInfo objectForKey:@"userID"] integerValue] forKey:@"userID"];
    
    [defaults synchronize];
}

@end
