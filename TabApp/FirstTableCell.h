//
//  FirstTableCell.h
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/8/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import "MGSwipeTableCell.h"

@interface FirstTableCell : MGSwipeTableCell
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UILabel *courseLabel;
@property (strong, nonatomic) IBOutlet UILabel *teacherLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) MGSwipeTransition transition;
+(NSMutableArray*) data;

@end
