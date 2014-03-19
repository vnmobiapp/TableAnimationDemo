//
//  AnimationTableViewController.m
//  TableAnimationDemo
//
//  Created by vnmobiapp on 2014/01/24.
//  Copyright (c) 2014年 vnmobiapp. All rights reserved.
//

#import "AnimationTableViewController.h"

@interface AnimationTableViewController ()
{
    float iosVersion;
}
@end

@implementation AnimationTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    iosVersion = [[UIDevice currentDevice].systemVersion floatValue];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    if (iosVersion < 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor whiteColor];

    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }

    // Configure the cell...

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*! セールのアニメーション
     @author vnmobiapp
     */
    cell.backgroundColor = [UIColor whiteColor];

    // テーブル移動方向調べる
    CGPoint point = [tableView.panGestureRecognizer translationInView:tableView];
    int direction = (point.y < 0) ? 1:-1;

    // 最初テーベルロードの際方向調整
    if (point.y == 0) {
        direction = 0;
    }
    // 特別な場合で方向を調整
    int directControllFlag = 1;

    UITableViewCell* myCell = [tableView.visibleCells lastObject];
    if (myCell) {
        directControllFlag = (indexPath.row > [tableView indexPathForCell:myCell].row) ? 1 : -1;
    }
    if ((directControllFlag * direction) == -1) {
        direction = 0;
    }
    // アニメーションを作成する
    CABasicAnimation*   animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    // アニメーションのプロパティを設定する
    animation.autoreverses = YES;

    CATransform3D   transform;
    transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(cell.layer.transform, 0, 50 * direction, 0);
    animation.toValue = [NSValue valueWithCATransform3D:transform];

    // レイヤーにアニメーションを追加する
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    [cell.layer addAnimation:animation forKey:@"transform"];
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
/*** セールのアニメーション*/
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
