//
//  myTableViewController.m
//  instaClient
//
//  Created by Yesim on 6.10.2015.
//  Copyright © 2015 Yesim. All rights reserved.
//

#import "myTableViewController.h"
#import "myTableViewCell.h"
#import "AFNetworking.h"
#import "InstagramPost.h"
#import "NSDate+TimeAgo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"





@interface myTableViewController ()
@property (strong, nonatomic) NSArray *instagramPosts;
@property (strong, nonatomic) NSArray *instagramSearchedPosts;

@end

@implementation myTableViewController

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *searchQuery=searchText;
    NSString *baseUrlString = @"https://api.instagram.com/v1/";
    NSString *searchString = @"tags/search?q=";
    NSString *clientIdString = @"&client_id=2bd06103258b4887872cfd799c716a6c";
    NSMutableArray *searched = [[NSMutableArray alloc]init];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", baseUrlString,searchString,searchQuery, clientIdString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSDictionary *response=responseObject[@"data"];
        for (NSDictionary *d in response) {
            
            NSString *value = [d objectForKey:@"name"];
            
            [searched addObject:value];
        }

        self.instagramSearchedPosts = [searched copy];
        [self.searchBarController.searchResultsTableView reloadData];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.instagramPosts) {
        self.instagramPosts = [[NSArray alloc] init];
    }
    
    NSString *apiURL = @"https://api.instagram.com/v1/media/popular?client_id=e243b5cf68b245f4aa3b57d01fa6b894";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *data=responseObject[@"data"];
        NSMutableArray *posts = [[NSMutableArray alloc]init];
        NSMutableArray *dates = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in data) {
             NSDictionary *imagesDict = dict[@"images"];
             NSDictionary *imageFullUrl = imagesDict[@"standard_resolution"];
             NSString *fullUrl=imageFullUrl[@"url"];
             NSNumber *createdTime = dict[@"created_time"];
             NSDictionary *userDict = dict[@"user"];
             NSString *username = userDict[@"username"];
             NSString *profilePicUrl = userDict[@"profile_picture"];
             
             double ago=[createdTime doubleValue];
             NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:ago];
             NSString *timeValue = [date timeAgo];
             
             InstagramPost *post=[[InstagramPost alloc]initWithtimeValue:timeValue fullUrl:fullUrl username:username profilePictureUrl:profilePicUrl];

             [posts addObject:post];
             }
        
        
        self.instagramPosts = [posts copy];
        [self.tableView reloadData];
        
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView != self.tableView) {
        return self.instagramSearchedPosts.count;
    }
    return self.instagramPosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
   if(self.searchDisplayController.active)
    {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
        }
        
      cell.textLabel.text=[self.instagramSearchedPosts objectAtIndex:[indexPath row]];
          [self.searchBarController.searchResultsTableView reloadData];
        
        return cell;
    }
    
    else
    {
        myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    [cell cellWithInstagram:[self.instagramPosts objectAtIndex:[indexPath row]]];
            return cell;
    }
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
