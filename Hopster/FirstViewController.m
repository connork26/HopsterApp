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

@property (nonatomic) LoginStatus status;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
            self.errorLabel.text = @"Invalid Login!";
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
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
    
    if ([json objectForKey:@"error"]) {
        self.errorLabel.text = @"Invalid login!";
        self.status = INVALID;
        return;
    }
    
    NSLog(@"Logged in! First Name: %@", [json objectForKey:@"fName"]);
    self.status = VALID;
    
}

-(void) saveUsername:(NSString*)user withPassword:(NSString*)pass forServer:(NSString*)server {
    
    // Create dictionary of search parameters
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, server, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, nil];
    
    // Remove any old values from the keychain
    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
    
    // Create dictionary of parameters to add
    NSData* passwordData = [pass dataUsingEncoding:NSUTF8StringEncoding];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword), kSecClass, server, kSecAttrServer, passwordData, kSecValueData, user, kSecAttrAccount, nil];
    
    // Try to save to keychain
    err = SecItemAdd((__bridge CFDictionaryRef) dict, NULL);
}


@end
