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
#import "SimpleTableCell.h"





@interface FirstViewController ()
@property (copy, nonatomic) NSArray *dwarves;
@property (retain,nonatomic) NSMutableArray *tasklist;
@property (retain,nonatomic) NSMutableArray *courselist;
@property (retain,nonatomic) NSMutableArray *teacherlist;
@property (retain,nonatomic) NSMutableArray *datelist;



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasklist = [[NSMutableArray alloc] init];
    self.courselist = [[NSMutableArray alloc] init];
    self.teacherlist = [[NSMutableArray alloc] init];
    self.datelist = [[NSMutableArray alloc] init];
    
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
        
//         NSString *displayString = [NSDate stringForDisplayFromDate:task.due_date];
        
       
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM dd, yyyy HH:mm"];
        
        NSString *stringFromDate = [formatter stringFromDate:task.due_date];
        
        
        
        
        
        [self.datelist addObject:stringFromDate];
        
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
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    


    NSUInteger row = [indexPath row];
    NSUInteger count = [_tasklist count];
    
    cell.topicLabel.text = [_tasklist objectAtIndex:(count-1-row)];
    cell.courseLabel.text = [_courselist objectAtIndex:(count-1-row)];
    cell.teacherLabel.text =[_teacherlist objectAtIndex:(count-1-row)];
    cell.dateLabel.text =[ _datelist objectAtIndex:(count-1-row)];
    


    return cell;
    
}



@end
