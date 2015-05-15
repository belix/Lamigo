//
//  LoginViewController.m
//  Halleluja
//
//  Created by Felix Belau on 06.03.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginClient.h"
#import "User.h"
#import "RegistrationContainerViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <UITextFieldDelegate,FBSDKLoginButtonDelegate, LoginClientDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *expandableView;
@property (weak, nonatomic) IBOutlet UIView *loginBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *footerLabel;
@property (weak, nonatomic) IBOutlet UIButton *footerButton;
@property (weak, nonatomic) IBOutlet UIImageView *overlayView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;

@property (nonatomic) BOOL loginViewExpanded;
@property (nonatomic, strong) LoginClient *loginClient;
@property (nonatomic, strong) User *currentUser;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginClient = [[LoginClient alloc] init];
    self.loginClient.delegate = self;

    self.loginButton.layer.cornerRadius = 3.0f;
    self.loginBackgroundView.layer.cornerRadius = 3.0f;
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([User currentUser])
    {
        [self performSegueWithIdentifier:@"showStartscreenViewController" sender:nil];
        NSLog(@"user already logged in");
        // User is logged in, do work such as go to next view controller.
    }
}

#pragma mark - IBActions

- (IBAction)loginSignupButtonPressed:(id)sender
{

}


- (IBAction)footerButtonPressed:(id)sender
{
    if (!self.loginViewExpanded)
    {
        [self expandLoginView];
    }
    else
    {
        [self collapseLoginView];
    }
}

#pragma mark - Animations

- (void)expandLoginView
{
    self.expandableView.alpha = 0;
    self.expandableView.hidden = NO;
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.expandableView.alpha = 1;
                         self.loginViewHeightConstraint.constant = 270;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         self.loginViewExpanded = YES;
                         self.footerLabel.text = @"Bereits registriert?";
                         [self.footerButton setTitle:@"Log In" forState:UIControlStateNormal];
                         [self.loginButton setTitle:@"Sign up" forState:UIControlStateNormal];
                     }];
    
}

- (void)collapseLoginView
{
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.expandableView.alpha = 0;
                         self.loginViewHeightConstraint.constant = 170;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         self.loginViewExpanded = NO;
                         self.expandableView.hidden = YES;
                         self.footerLabel.text = @"Noch nicht registriert?";
                         [self.footerButton setTitle:@"Sign up" forState:UIControlStateNormal];
                         [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
                     }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - FacebookLogin Delegate

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", result[@"id"]];
                 
                 // download the image asynchronously
                 [self downloadImageWithURL:[NSURL URLWithString:userImageURL] completionBlock:^(BOOL succeeded, UIImage *image) {
                     if (succeeded)
                     {
                         self.currentUser = [[User alloc] init];
                         self.currentUser.username = result[@"name"];
                         self.currentUser.email = @"";
                         self.currentUser.gender = 1;
                         self.currentUser.birthday = @"";
                         self.currentUser.facebookID = result[@"id"];
                         self.currentUser.profilePicture = UIImagePNGRepresentation(image);
                         [self performSegueWithIdentifier:@"showRegistrationSequence" sender:nil];
                     }
                 }];

             }
         }];
    }
    
    NSLog(@"result %@",result);
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"logout");
}

#pragma mark - LoginClientDelegate

- (void)loginSuccessful
{
//    [self performSegueWithIdentifier:@"showRegistrationSequence" sender:nil];
//    [self performSegueWithIdentifier:@"showStartscreenViewController" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRegistrationSequence"])
    {
        RegistrationContainerViewController *destionationViewController = [segue destinationViewController];
        destionationViewController.currentUser = self.currentUser;
    }
}


@end
