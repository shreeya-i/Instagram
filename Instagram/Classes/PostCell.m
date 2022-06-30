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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLike:(id)sender {
//    self.post.liked = !self.post.liked;
//    if (self.post.liked){
//        NSNumber *sum = [NSNumber numberWithFloat:(1 + [self.post.likeCount intValue])];
//        self.post[@"likedCount"] = sum;
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                if(error){
//                      NSLog(@"Error saving: %@", error.localizedDescription);
//                 }
//                 else{
//                     //[self.delegate didSaveEdits:self.bioTextField.text:self.profilePicture.file];
//                     NSLog(@"Successfully saved");
//                 }
//            }];
//    }
//    else{
//        NSNumber *sum = [NSNumber numberWithFloat:([self.post.likeCount intValue] - 1)];
//        self.post[@"likedCount"] = sum;
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                if(error){
//                      NSLog(@"Error saving: %@", error.localizedDescription);
//                 }
//                 else{
//                     //[self.delegate didSaveEdits:self.bioTextField.text:self.profilePicture.file];
//                     NSLog(@"Successfully saved");
//                 }
//            }];
// }
}
    

@end
