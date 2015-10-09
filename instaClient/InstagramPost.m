//
//  InstagramPost.m
//  instaClient
//
//  Created by Yesim on 6.10.2015.
//  Copyright © 2015 Yesim. All rights reserved.
//

#import "InstagramPost.h"

@implementation InstagramPost
    
-(id)initWithtimeValue:(NSString *)timeValue fullUrl:(NSString *)fullUrl username:(NSString *)username profilePictureUrl:(NSString *)profilePictureUrl{
        self=[super init];
        
        if(self) {
            self.timeValue=timeValue;
            self.fullUrl=fullUrl;
            self.profilePictureUrl=profilePictureUrl;
            self.username=username;
           
        }
        return self;
    }

@end
