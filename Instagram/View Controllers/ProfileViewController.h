//
//  ProfileViewController.h
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController<EditDelegate>

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *postsCollectionView;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

@end

NS_ASSUME_NONNULL_END
