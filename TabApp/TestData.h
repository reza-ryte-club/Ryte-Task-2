/*
 * MGSwipeTableCell is licensed under MIT licensed. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

#import "MGSwipeTableCell.h"

@interface TestData : NSObject

@property (nonatomic) MGSwipeTransition transition;


-(NSString *) title;
-(NSString *) detailTitle;

+(NSMutableArray*) data;


@end
