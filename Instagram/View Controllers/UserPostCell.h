//
//  UserPostCell.h
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface UserPostCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;

@end

NS_ASSUME_NONNULL_END
