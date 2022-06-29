//
//  ComposeViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/27/22.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "SVProgressHUD/SVProgressHUD.h"

@interface ComposeViewController () <UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *postTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapPlaceholderImage:)];
    [self.postImage addGestureRecognizer:postTapGestureRecognizer];
    [self.postImage setUserInteractionEnabled:YES];
    
    self.captionTextView.delegate = self;
//    self.captionTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    self.captionTextView.layer.borderWidth = 1.0;
    //self.composeTextView.layer.cornerRadius = 8;
    self.captionTextView.text = @"Write a caption...";
    self.captionTextView.textColor = [UIColor lightGrayColor];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Write a caption..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    int characterLimit = 300;
    NSString *newText = [self.self.captionTextView.text stringByReplacingCharactersInRange:range withString:text];
    //self.characterCount.text = [NSString stringWithFormat:@"%lu / 280", (unsigned long)newText.length];
    return newText.length < characterLimit;
}

- (void) didTapPlaceholderImage:(UITapGestureRecognizer *)sender{
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    if (editedImage){
        self.postImage.image = editedImage;
    }
    else{
        self.postImage.image = originalImage;
    }
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)didTapPost:(id)sender {
    
    [SVProgressHUD show];
    
    UIImage *resizedImage = [self resizeImage:self.postImage.image withSize:self.postImage.image.size];
    [Post postUserImage:resizedImage withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error posting user image");
        }
        else{
            NSLog(@"Successfully posted image");
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD dismiss];
        }
    }];
}


- (IBAction)didTapDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
