//
//  EditViewController.h
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@protocol EditDelegate

- (void)didSaveEdits:(NSString *)bio :(PFFileObject *)profileImage;

@end

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;
@property (nonatomic, weak) id<EditDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
