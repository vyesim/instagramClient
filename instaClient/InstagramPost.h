//
//  InstagramPost.h
//  instaClient
//
//  Created by Yesim on 6.10.2015.
//  Copyright © 2015 Yesim. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface InstagramPost : NSObject
    
    @property (strong,nonatomic) NSString *timeValue;
    @property (strong,nonatomic) NSString *fullUrl;
    @property (strong,nonatomic) NSString *username;
    @property (strong,nonatomic) NSString *profilePictureUrl;



-(id)initWithtimeValue:(NSString *)timeValue fullUrl:(NSString *)fullUrl username:(NSString *)username profilePictureUrl:(NSString *)profilePictureUrl;

@end
