//
//  EditViewController.h
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;

@end

NS_ASSUME_NONNULL_END
