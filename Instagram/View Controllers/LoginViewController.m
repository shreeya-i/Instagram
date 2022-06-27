//
//  LoginViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "HomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
}


- (IBAction)didTapLogIn:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;

    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"loginSegue"]){
        UINavigationController *navigationController = [segue destinationViewController];
        HomeViewController *homeVC = (HomeViewController*)navigationController.topViewController;
    }
}

@end
