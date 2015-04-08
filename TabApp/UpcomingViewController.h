//
//  UpcomingViewController.h
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/5/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
@interface UpcomingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate,UISearchDisplayDelegate>
@property (nonatomic, assign) BOOL testingStoryboardCell;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
