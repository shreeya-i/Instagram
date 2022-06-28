//
//  HomeViewController.h
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *postTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

NS_ASSUME_NONNULL_END
