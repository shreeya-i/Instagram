//
//  PostCell.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "PostCell.h"
#import "Parse/Parse.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void) refreshData {
    UIImage *favorImage = [UIImage imageNamed:@"favor-icon"];
    UIImage *favorImageSelected = [UIImage imageNamed:@"favor-icon-red"];
    if (self.post.liked) {
        [self.likeButton setImage:favorImageSelected forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:favorImage forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLike:(id)sender {
    if (self.post.liked){
        self.post.liked = NO;
        NSNumber *sum = [NSNumber numberWithFloat:([self.post.likeCount intValue] - 1)];
        self.post[@"likeCount"] = sum;
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                      NSLog(@"Error saving: %@", error.localizedDescription);
                 }
                 else{
                     NSLog(@"Successfully saved");
                     [self refreshData];
                 }
            }];
    }
    else{
        self.post.liked = YES;
        NSNumber *sum = [NSNumber numberWithFloat:(1 + [self.post.likeCount intValue])];
        self.post[@"likeCount"] = sum;
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                      NSLog(@"Error saving: %@", error.localizedDescription);
                 }
                 else{
                     NSLog(@"Successfully saved");
                     [self refreshData];
                 }
            }];
 }
}
    

@end
