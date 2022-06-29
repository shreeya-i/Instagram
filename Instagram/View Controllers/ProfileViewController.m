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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.postsCollectionView reloadData];
    [self fetchPosts];
    [self fetchDetails];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameLabel.text = [PFUser currentUser].username;
    self.postsCollectionView.dataSource = self;
    
    [self fetchPosts];
    [self fetchDetails];
}

//- (void)didSaveEdits:(NSString *)bio :(PFFileObject *)profileImage {
//    self.bioLabel.text = bio;
//    self.profilePicture.file = profileImage;
//    [self.profilePicture loadInBackground];
//    [self.postsCollectionView reloadData];
//    [self fetchPosts];
//    [self fetchDetails];
//}

- (void) fetchDetails {
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    self.profilePicture.layer.borderWidth = 0.5f;
    self.profilePicture.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"profilePicture"]){
            PFFileObject *file = user[@"profilePicture"];
            [file getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:imageData];
                            [self.profilePicture setImage:image];
                        }
                    }];
    }
    else {
        self.profilePicture.image = [UIImage imageNamed: @"defaultpfp"];
    }
    
    if(user[@"bio"]){
        self.bioLabel.text = user[@"bio"];
    }
    else{
        self.bioLabel.text = @"";
    }
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
