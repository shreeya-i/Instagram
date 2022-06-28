//
//  DetailViewController.h
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Post *detailPost;

@end

NS_ASSUME_NONNULL_END
