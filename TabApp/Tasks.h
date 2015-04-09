//
//  Tasks.h
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/5/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tasks : NSManagedObject

@property (nonatomic, retain) NSString * course;
@property (nonatomic, retain) NSDate * due_date;
@property (nonatomic, retain) NSString * teacher;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * isTrashed;
@property (nonatomic, retain) NSString * isComplete;

@end
