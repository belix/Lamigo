//
//  ChatsTableViewController.m
//  Lamigo
//
//  Created by Felix Belau on 18.05.15.
//  Copyright (c) 2015 Bob Schlund Studios. All rights reserved.
//

#import "ChatsTableViewController.h"
#import "ChatTableViewCell.h"
#import "FriendsClient.h"
#import "User.h"
#import "MBProgressHUD.h"
#import "ChatMessagesViewController.h"

@interface ChatsTableViewController () <FriendsClientDelegate>

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) FriendsClient *friendsClient;
@property (nonatomic, strong) User *selectedUser;

@end

@implementation ChatsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendsClient = [[FriendsClient alloc] init];
    self.friendsClient.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self.friendsClient loadFriends];
        
    });
    self.title = @"Chats";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableViewCell" forIndexPath:indexPath];
    
    User *friend = self.friends[indexPath.row];
    cell.profilePictureImageView.image = [UIImage imageWithData:friend.profilePicture];
    cell.usernameLabel.text = friend.username;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedUser = self.friends[indexPath.row];
    [self performSegueWithIdentifier:@"showChatViewController" sender:nil];
}

#pragma - FriendsClientDelegate

- (void)friendsLoaded:(NSArray *)friends
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.friends = friends;
        [self.tableView reloadData];
    });
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showChatViewController"])
    {
        ChatMessagesViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.chatUser = self.selectedUser;
    }
 
}


@end
