//
//  myTableViewCell.m
//  instaClient
//
//  Created by Yesim on 6.10.2015.
//  Copyright © 2015 Yesim. All rights reserved.
//

#import "myTableViewCell.h"
#import "InstagramPost.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"



@implementation myTableViewCell

-(void) cellWithInstagram: (InstagramPost *) post{
    self.userLabel.text=[NSString stringWithFormat:@"%@",post.username];
    self.dateLabel.text=[NSString stringWithFormat:@"%@",post.timeValue];
    [self.userImage sd_setImageWithURL:[NSString stringWithFormat:@"%@",post.profilePictureUrl]];
    [self.postImage sd_setImageWithURL:[NSString stringWithFormat:@"%@",post.fullUrl]];
    self.userImage.layer.cornerRadius = self.userImage.frame.size.height /2;
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.borderWidth = 0.3;
    [self.userLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    [self.dateLabel setTextColor:[UIColor colorWithRed:0.69 green:0.68 blue:0.68 alpha:1.0]];
    [self.userLabel setTextColor:[UIColor colorWithRed:0.13 green:0.23 blue:0.40 alpha:1.0]];

    
    

    
    
 

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
