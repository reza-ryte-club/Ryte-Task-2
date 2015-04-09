//
//  FirstTableCell.m
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/8/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import "FirstTableCell.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"
#import "AppDelegate.h"
#import  "tasks.h"
#import <Foundation/Foundation.h>

@implementation FirstTableCell
@synthesize topicLabel = _topicLabel;
@synthesize courseLabel = _courseLabel;
@synthesize teacherLabel = _teacherLabel;
@synthesize dateLabel = _dateLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+(NSMutableArray *) data
{
    NSMutableArray * tests = [NSMutableArray array];
    

    
    
    //start of fetching
    NSError *error = nil;
    AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = theDelegate.managedObjectContext;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
  //  NSString *isComplete = @"No";
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"isComplete MATCHES 'No' AND isTrashed MATCHES 'No'"];
    [fetchRequest setPredicate:predicate];

    
    
    
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //end of fetching

    
    
    
    
    for (int i = 0; i < fetchedObjects.count; ++i) {
        FirstTableCell * data = [[FirstTableCell alloc] init];
        data.transition = MGSwipeTransitionBorder;
        [tests addObject:data];
    }
    return tests;
}

@end
