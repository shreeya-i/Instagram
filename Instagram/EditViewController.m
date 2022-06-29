//
//  EditViewController.m
//  Instagram
//
//  Created by Shreeya Indap on 6/28/22.
//

#import "EditViewController.h"
#import "Post.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *postTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapPlaceholderImage:)];
    [self.profilePicture addGestureRecognizer:postTapGestureRecognizer];
    [self.profilePicture setUserInteractionEnabled:YES];
    
    self.profilePicture.layer.cornerRadius  = self.profilePicture.frame.size.width/2;
    self.profilePicture.clipsToBounds = YES;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"profilePicture"]){
            PFFileObject *file = user[@"profilePicture"];
            [file getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:imageData];
                            [self.profilePicture setImage:image];
                        }
                    }];
    }
    else {
        self.profilePicture.image = [UIImage imageNamed: @"defaultpfp"];
    }

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
        [self.profilePicture setImage: editedImage];
        PFFileObject *file = [Post getPFFileFromImage: editedImage];
        [self.profilePicture setFile: file];
    }
    else{
        self.profilePicture.image = originalImage;
        PFFileObject *file = [Post getPFFileFromImage: originalImage];
        [self.profilePicture setFile: file];
    }
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSave:(id)sender {
    PFUser *user = [PFUser currentUser];
    user[@"profilePicture"] = self.profilePicture.file;
    //    PFFileObject fileObjectWithData: [image
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(error){
                  NSLog(@"Error saving: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully saved");
             }
        }];
    [self dismissViewControllerAnimated:YES completion:nil];
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
