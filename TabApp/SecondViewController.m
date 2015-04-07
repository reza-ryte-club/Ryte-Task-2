//  SecondViewController.m

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "TestData.h"
#import "MGSwipeButton.h"
@interface SecondViewController ()
@end

#define TEST_USE_MG_DELEGATE 1

@implementation SecondViewController
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
    // Do any additional setup after loading the view, typically from a nib.
    tests = [TestData data];
    self.title = @"Completed";
    

    //This shows the content
   
    if (!_testingStoryboardCell) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    
}










//This is important
-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"Delete", @"More"};
    UIColor * colors[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
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
    MGSwipeTableCell * cell;
    
    if (_testingStoryboardCell) {
        /**
         * Test using storyboard and prototype cell that uses autolayout
         **/
       // cell = [_tableView dequeueReusableCellWithIdentifier:@"prototypeCell"];
    }
    else {
        /**
         * Test using programmatically created cells
         **/
        static NSString * reuseIdentifier = @"programmaticCell";
        cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        }
    }
    
    TestData * data = [tests objectAtIndex:indexPath.row];
    
    cell.textLabel.text = data.title;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = data.detailTitle;
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
-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    TestData * data = [tests objectAtIndex:[_tableView indexPathForCell:cell].row];
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
    return 90;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [_tableView indexPathForCell:cell];
        [tests removeObjectAtIndex:path.row];
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }
/*
    if (direction == MGSwipeDirectionLeftToRight && index == 0) {
        //delete button
        NSIndexPath * path = [_tableView indexPathForCell:cell];
        [tests removeObjectAtIndex:path.row];
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }
 */
    return YES;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




