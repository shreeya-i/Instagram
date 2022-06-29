//
//  ProfileViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import "ProfileViewController.h"
#import "UserPostCell.h"
@import Parse;

@interface ProfileViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *postsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameLabel.text = [PFUser currentUser].username;
    self.postsCollectionView.dataSource = self;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"profileImage"]){
            PFFileObject *file = user[@"profileImage"];
            [file getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:imageData];
                            [self.profilePicture setImage:image];
                        }
                    }];
    } else {
        //[self.profilePicture setImage: @"defaultpfp"];
    }

    
    
//    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
//    [self.profilePicture addGestureRecognizer:profileTapGestureRecognizer];
//    [self.profilePicture setUserInteractionEnabled:YES];
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    
    [self fetchPosts];
}

- (void) fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo: [PFUser currentUser]];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.postsArray = posts;
            [self.postsCollectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserPostCell" forIndexPath:indexPath];
    cell.postImage.file = self.postsArray[indexPath.row][@"image"];
    [cell.postImage loadInBackground];
    return cell;
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
