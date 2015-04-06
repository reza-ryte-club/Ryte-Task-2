//
//  SimpleTableCell.m
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/6/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell


@synthesize topicLabel = _topicLabel;
@synthesize courseLabel = _courseLabel;
@synthesize teacherLabel = _teacherLabel;
@synthesize dateLabel = _dateLabel;



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
