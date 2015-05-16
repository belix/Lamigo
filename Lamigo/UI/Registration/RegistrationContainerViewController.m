//
//  RegistrationContainerViewController.m
//  Lamigo
//
//  Created by Felix Belau on 15.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "RegistrationContainerViewController.h"
#import "RegistrationStepViewController.h"
#import "RegistrationNativeLanguageViewController.h"
#import "RegistrationLearningLanguageViewController.h"
#import "RegistrationUniversalLanguageViewController.h"
#import "RegistrationInterestsViewController.h"
#import "RegistrationProfilePictureViewController.h"
#import "LoginClient.h"
#import "MBProgressHUD.h"

@interface RegistrationContainerViewController () <LoginClientDelegate>

@property (weak, nonatomic) IBOutlet UIView *profilePictureContainer;
@property (weak, nonatomic) IBOutlet UIView *nativeLanguageContainer;
@property (weak, nonatomic) IBOutlet UIView *worldLanguageContainer;
@property (weak, nonatomic) IBOutlet UIView *learningLanguageContainer;
@property (weak, nonatomic) IBOutlet UIView *interestsContainer;
@property (weak, nonatomic) IBOutlet UILabel *registrationStepDescriptionLabel;

@property (strong, nonatomic) NSArray *registrationSteps;
@property (strong, nonatomic) NSMutableArray *registrationStepsViewControllers;
@property (nonatomic) int registrationStep;
@property (strong, nonatomic) LoginClient *loginClient;

@end

@implementation RegistrationContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.registrationStep = 0;
    self.registrationSteps = @[self.profilePictureContainer,self.nativeLanguageContainer,self.learningLanguageContainer,self.worldLanguageContainer,self.interestsContainer];
    self.loginClient = [[LoginClient alloc] init];
    self.loginClient.delegate = self;
}

#pragma mark - Getter

- (NSMutableArray *)registrationStepsViewControllers
{
    if(!_registrationStepsViewControllers)
    {
        _registrationStepsViewControllers = [[NSMutableArray alloc] init];
    }
    return _registrationStepsViewControllers;
}

#pragma mark - Internal

- (void)updateDescriptionLabel
{
    RegistrationStepViewController *childViewController = self.registrationStepsViewControllers[self.registrationStep];
    self.registrationStepDescriptionLabel.text = childViewController.descriptionText;
}

- (void)finishRegistrationProcess
{
    for (RegistrationStepViewController *stepController in self.registrationStepsViewControllers)
    {
        if ([stepController isKindOfClass:[RegistrationProfilePictureViewController class]])
        {
            self.currentUser.profilePicture = UIImagePNGRepresentation(((RegistrationProfilePictureViewController *)stepController).profileImage);
        }
        else if ([stepController isKindOfClass:[RegistrationNativeLanguageViewController class]])
        {
            self.currentUser.nativeLanguage = ((RegistrationNativeLanguageViewController *)stepController).selectedNativeLanguage;
        }
        else if ([stepController isKindOfClass:[RegistrationLearningLanguageViewController class]])
        {
            self.currentUser.learningLanguage = ((RegistrationLearningLanguageViewController *)stepController).selectedLearningLanguage;
        }
        else if ([stepController isKindOfClass:[RegistrationUniversalLanguageViewController class]])
        {
            self.currentUser.universalLanguage = ((RegistrationUniversalLanguageViewController *)stepController).selectedUniversalLanguage;
        }
        else if ([stepController isKindOfClass:[RegistrationInterestsViewController class]])
        {
            self.currentUser.interests = ((RegistrationInterestsViewController *)stepController).selectedInterests;
        }
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        [self.loginClient signUpWithForUser:self.currentUser];

    });
    
}

#pragma mark - IBActions

- (IBAction)backButtonPressed:(id)sender
{
    if(self.registrationStep <= 0)
    {
        NSLog(@"no back!");
        return;
    }
    UIView *currentContainer = self.registrationSteps[self.registrationStep];
    self.registrationStep--;
    UIView *nextContainer = self.registrationSteps[self.registrationStep];
    [self moveContainerOut:currentContainer toLeft:NO];
    [self moveContainerIn:nextContainer fromLeft:YES];
}

- (IBAction)nextButtonPressed:(id)sender
{
    if(self.registrationStep >= self.registrationSteps.count-1)
    {
        [self finishRegistrationProcess];
        NSLog(@"reg finished!");
        return;
    }
    
    UIView *currentContainer = self.registrationSteps[self.registrationStep];
    self.registrationStep++;
    UIView *nextContainer = self.registrationSteps[self.registrationStep];
    
    [self moveContainerOut:currentContainer toLeft:YES];
    [self moveContainerIn:nextContainer fromLeft:NO];
}

#pragma mark - Animations

- (void)moveContainerOut:(UIView*)container toLeft:(BOOL)toLeft;
{
    //move current container out of the screen
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect newRect = container.frame;
                         newRect.origin.x = (toLeft ? -self.view.frame.size.width : + self.view.frame.size.width);
                         container.frame = newRect;
                     }
                     completion:^(BOOL finished){
                         container.hidden = YES;
                     }];
}

- (void)moveContainerIn:(UIView*)container fromLeft:(BOOL)fromLeft
{
    //set new container (which will be animated in) to right side of the screen
    CGRect newRect = container.frame;
    newRect.origin.x = (fromLeft ? -self.view.frame.size.width : +self.view.frame.size.width);
    container.frame = newRect;
    container.hidden = NO;
    
    //move new container to center of the screen
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect newRect = container.frame;
                         newRect.origin.x = 0;
                         container.frame = newRect;
                     }
                     completion:^(BOOL finished){
                         [self updateDescriptionLabel];
                     }];
}

#pragma mark - LoginClientDelegate

- (void)signUpSuccessful
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self performSegueWithIdentifier:@"showStartscreenViewController" sender:nil];
    });

}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"registrationStepSegue"])
    {
        RegistrationStepViewController * childViewController = (RegistrationStepViewController *) [segue destinationViewController];
        if ([childViewController isKindOfClass:[RegistrationProfilePictureViewController class]])
        {
            ((RegistrationProfilePictureViewController *)childViewController).profileImage = [UIImage imageWithData:self.currentUser.profilePicture];
        }
        [self.registrationStepsViewControllers addObject:childViewController];
    }
}

@end
