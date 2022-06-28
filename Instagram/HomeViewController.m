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
#import "Post.h"
#import "PostCell.h"
#import "DetailViewController.h"
@import Parse;

@interface HomeViewController () <UITableViewDataSource>
@property (nonatomic, strong) NSArray *arrayOfPosts;

@end

@implementation HomeViewController

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.postTableView reloadData];
//    [self fetchPosts];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.postTableView insertSubview:self.refreshControl atIndex:0];

    
    self.postTableView.dataSource = self;
    self.postTableView.rowHeight = 420;
    
    [self fetchPosts];
}

- (void)fetchPosts {
    
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = posts;
            [self.postTableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"%@", error);
        }
    }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    cell.captionLabel.text = cell.post.caption;
    cell.usernameLabel.text = cell.post.author.username;
    
    [cell.likeButton setTitle: [NSString stringWithFormat:@"%@", cell.post.likeCount]  forState:UIControlStateNormal];
    [cell.commentButton setTitle: [NSString stringWithFormat:@"%@", cell.post.commentCount]  forState:UIControlStateNormal];

    cell.postImage.file = cell.post[@"image"];
    [cell.postImage loadInBackground];
    
    //cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfPosts.count;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]){
//        UINavigationController *navigationController = [segue destinationViewController];
//
        NSIndexPath *myIndexPath = [self.postTableView indexPathForCell:sender];
        Post *dataToPass = self.arrayOfPosts[myIndexPath.row];
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.detailPost = dataToPass;
    }
}

@end
