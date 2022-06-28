//
//  DetailViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "DetailViewController.h"
@import Parse;

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) NSDate *date;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = self.detailPost.author.username;
    self.captionLabel.text = self.detailPost.caption;
    
    self.postImage.file = self.detailPost[@"image"];
    [self.postImage loadInBackground];
    
    self.date = self.detailPost.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *curDate = [NSDate date];
    NSTimeInterval diff = [curDate timeIntervalSinceDate:self.date];
    
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;

    NSInteger interval = diff;
    long seconds = interval % 60;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
    if(hours > 1) {
        self.dateLabel.text = [NSString stringWithFormat:@"%ldh", hours];
        } else if(minutes > 1) {
        self.dateLabel.text = [NSString stringWithFormat:@"%ldm", minutes];
        } else {
        self.dateLabel.text = [NSString stringWithFormat:@"%lds", seconds];
        }
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
