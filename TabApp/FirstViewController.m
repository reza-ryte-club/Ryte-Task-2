//
//  FirstViewController.m
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/4/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "Tasks.h"



@interface FirstViewController ()
@property (copy, nonatomic) NSArray *dwarves;
@property (retain,nonatomic) NSMutableArray *tasklist;
@property (retain,nonatomic) NSMutableArray *courselist;
@property (retain,nonatomic) NSMutableArray *teacherlist;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.tasklist = [[NSMutableArray alloc] init];
       self.courselist = [[NSMutableArray alloc] init];
       self.teacherlist = [[NSMutableArray alloc] init];
    
    //start of fetching
    NSError *error = nil;
    AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = theDelegate.managedObjectContext;
   
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (Tasks *task in fetchedObjects) {

        [self.tasklist addObject:task.topic ];
        [self.courselist addObject:task.course];
        [self.teacherlist addObject:task.teacher];
    }
    
    
    
    //end of fetching
    
    
    
    
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

//    return [self.dwarves count];
    return [self.tasklist count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    //in order to reverse the list
    NSUInteger row = [indexPath row];
    NSUInteger count = [_tasklist count];
    
    
    cell.textLabel.text = [_tasklist objectAtIndex:(count-1-row)];
    cell.detailTextLabel.text = [_courselist objectAtIndex:(count-1-row)];
//    cell.detailTextLabel.text = @"Mr. Disney";
    
    return cell;
    
}



@end
