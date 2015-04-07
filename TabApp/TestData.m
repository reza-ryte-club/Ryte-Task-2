/*
 * MGSwipeTableCell is licensed under MIT licensed. See LICENSE.md file for more information.
 * Copyright (c) 2014 Imanol Fernandez @MortimerGoro
 */

#import "TestData.h"
#import "MGSwipeButton.h"

@implementation TestData


-(NSString *) title
{
    NSString * modeTitle;
    modeTitle = @"boo";//[NSString stringWithFormat:@"transition"];
    return  modeTitle;
}

-(NSString *) detailTitle
{
    return  @"Not expandable";
}


+(NSMutableArray *) data
{
    NSMutableArray * tests = [NSMutableArray array];
    for (int i = 0; i < 6; ++i) {
                TestData * data = [[TestData alloc] init];
                data.transition = MGSwipeTransitionBorder;
                [tests addObject:data];
    }
    return tests;
}

@end