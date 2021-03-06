//
//  Post.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic createdAt;
@dynamic caption;
@dynamic image;
@dynamic liked;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
return @"Post";
}

//To upload the user image to Parse, get the user input from the view controller and then call the postUserImage method from the view controller by passing all the required arguments into it.

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {

Post *newPost = [Post new];
newPost.image = [self getPFFileFromImage:image];
newPost.author = [PFUser currentUser];
newPost.caption = caption;
newPost.likeCount = @(0);
newPost.commentCount = @(0);
newPost.liked = false;

[newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
