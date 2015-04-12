//  FirstViewController.m

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "TestData.h"
#import "MGSwipeButton.h"
#import "Tasks.h"
#import "FirstTableCell.h"
@interface FirstViewController ()
@property (retain,nonatomic) NSMutableArray *tasklist;
@property (retain,nonatomic) NSMutableArray *courselist;
@property (retain,nonatomic) NSMutableArray *teacherlist;
@property (retain,nonatomic) NSMutableArray *datelist;

@end

#define TEST_USE_MG_DELEGATE 1

@implementation FirstViewController
{
    NSMutableArray * tests;
    
    
    
    
}

-(void) cancelTableEditClick: (id) sender
{
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
}

-(void) actionClick: (id) sender
{
}











- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Firstviewcontroller");
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"isComplete MATCHES 'No' AND isTrashed MATCHES 'No'"];
      [fetchRequest setPredicate:predicate];
    

    
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    
    
    
    
    for (Tasks *task in fetchedObjects) {
        
        [self.tasklist addObject:task.topic ];
        [self.courselist addObject:task.course];
        [self.teacherlist addObject:task.teacher];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM dd, yyyy HH:mm"];
        NSString *stringFromDate = [formatter stringFromDate:task.due_date];
        [self.datelist addObject:stringFromDate];
    }
    //end of fetching
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    tests = [FirstTableCell data];
    self.title = @"Pending";
    //This shows the content
    if (!_testingStoryboardCell) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [self.tableView reloadData];//might be ommited
    }
    
}










//This is important
-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"Delete", @"Completed"};
    UIColor * colors[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button =
        [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right).");
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        [result addObject:button];
    }
    return result;
}


-(NSArray *) createLeftButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    UIColor * colors[3] = {[UIColor greenColor],
        [UIColor colorWithRed:0 green:0x99/255.0 blue:0xcc/255.0 alpha:1.0],
        [UIColor colorWithRed:0.59 green:0.29 blue:0.08 alpha:1.0]};
    UIImage * icons[3] = {[UIImage imageNamed:@"check.png"], [UIImage imageNamed:@"fav.png"], [UIImage imageNamed:@"menu.png"]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"" icon:icons[i] backgroundColor:colors[i] padding:15 callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (left).");
            return YES;
        }];
        [result addObject:button];
    }
    return result;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return tests.count;
}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstTableCell * cell;
    
    if (_testingStoryboardCell) {
        /**
         * Test using storyboard and prototype cell that uses autolayout
         **/
        cell = [_tableView dequeueReusableCellWithIdentifier:@"FirstTableCell"];


    }
    else {
        /**
         * Test using programmatically created cells
         **/
        static NSString * reuseIdentifier = @"FirstTableCell";
        cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            //cell = [[FirstTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FirstTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];


            
            
        }
    }
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [_tasklist count];
    
    cell.topicLabel.text = [_tasklist objectAtIndex:(count-1-row)];
    cell.courseLabel.text = [_courselist objectAtIndex:(count-1-row)];
    cell.teacherLabel.text =[_teacherlist objectAtIndex:(count-1-row)];
    cell.dateLabel.text =[ _datelist objectAtIndex:(count-1-row)];

    
    
    
    //    cell.accessoryType = accessory;
    cell.delegate = self;
    //    cell.allowsMultipleSwipe = allowMultipleSwipe;
    
    
#if !TEST_USE_MG_DELEGATE
    cell.leftButtons = [self createLeftButtons:2];
    cell.rightButtons = [self createRightButtons:2];
#endif
    
    return cell;
}



//This is important
#if TEST_USE_MG_DELEGATE
-(NSArray*) swipeTableCell:(FirstTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    FirstTableCell * data = [tests objectAtIndex:[_tableView indexPathForCell:cell].row];
    swipeSettings.transition = data.transition;
    
    
    if (direction == MGSwipeDirectionLeftToRight) {
        expansionSettings.buttonIndex = -1;
        expansionSettings.fillOnTrigger = NO;
        return [self createLeftButtons:0];
    }
    else {
        expansionSettings.buttonIndex = -1;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons:2];
    }
    
}
#endif


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}



-(BOOL) swipeTableCell:(FirstTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [_tableView indexPathForCell:cell];
        //start of fetching
        NSError *error = nil;
        AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext = theDelegate.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks"
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"isComplete MATCHES 'No' AND isTrashed MATCHES 'No'"];
        [fetchRequest setPredicate:predicate];
        
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        NSUInteger count = [fetchedObjects count];
        
        Tasks* task = [fetchedObjects objectAtIndex: (count-1-path.row)];
        task.isTrashed = @"Yes";
        
        [managedObjectContext save:nil];
        //end of fetching
        
        //remove the UI cell
        [tests removeObjectAtIndex:path.row];
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        
        
        
//        FirstViewController *controller = [self.storyboard   instantiateViewControllerWithIdentifier:@"TheMaster"];
  //      [self presentViewController:controller animated:YES completion:nil];
        UITabBarController *controller = [self.storyboard   instantiateViewControllerWithIdentifier:@"TheMaster"];
        controller.selectedIndex=0;
                [self presentViewController:controller animated:YES completion:nil ];
        
        
        return NO; //Don't autohide to improve delete expansion animation
    }
    
    
    
    if (direction == MGSwipeDirectionRightToLeft && index == 1) {
        
        NSLog(@"more");
        
        NSIndexPath * path = [_tableView indexPathForCell:cell];
        
        //start of fetching
        NSError *error = nil;
        AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext = theDelegate.managedObjectContext;
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks"
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

        
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"isComplete MATCHES 'No' AND isTrashed MATCHES 'No'"];
        [fetchRequest setPredicate:predicate];
        
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
      NSUInteger count = [fetchedObjects count];
        
  //      NSUInteger count = [_tableView numberOfRowsInSection:0];
        
        
        NSLog(@"Path Row %ld",path.row);
        NSLog(@"count %ld",count);
        Tasks* task = [fetchedObjects objectAtIndex: (count-1-path.row)];
        task.isComplete = @"Yes";        
        [managedObjectContext save:nil];
        //end of fetching
        
        
        
        
        
        
        //remove the UI cell
        [tests removeObjectAtIndex:path.row];
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        
        UITabBarController *controller = [self.storyboard   instantiateViewControllerWithIdentifier:@"TheMaster"];
        controller.selectedIndex=0;
                [self presentViewController:controller animated:YES completion:nil ];
        

        return NO; //Don't autohide to improve delete expansion animation
    }
    
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}
*/

@end




