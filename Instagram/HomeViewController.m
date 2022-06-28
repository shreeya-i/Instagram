//
//  HomeViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ComposeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
           if (error) {
               NSLog(@"Cannot log out");
           } else {
               // Success
               NSLog(@"User logged out successfully.");
               SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
               LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
               sceneDelegate.window.rootViewController = loginViewController;
           }
       }];
}



/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
