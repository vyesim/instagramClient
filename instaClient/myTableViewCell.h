//
//  myTableViewCell.h
//  instaClient
//
//  Created by Yesim on 6.10.2015.
//  Copyright © 2015 Yesim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstagramPost;

@interface myTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;



-(void) cellWithInstagram: (InstagramPost *)post;



@end
