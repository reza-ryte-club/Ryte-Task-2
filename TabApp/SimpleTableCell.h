//
//  SimpleTableCell.h
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/6/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UILabel *courseLabel;
@property (strong, nonatomic) IBOutlet UILabel *teacherLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
