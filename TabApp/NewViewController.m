//
//  NewViewController.m
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/5/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import "NewViewController.h"
#import "Tasks.h"
#import "AppDelegate.h"
#import "FirstViewController.h"
#import <CoreData/CoreData.h>

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"New");
    
    self.DueDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.DueDatePicker setValue:[UIColor colorWithRed:70/255.0f green:161/255.0f blue:174/255.0f alpha:1.0f] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString(@"setHighlightsToday:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDatePicker instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:self.DueDatePicker];
    
    
    
    NSAttributedString *topicStr = [[NSAttributedString alloc] initWithString:@" Enter Topic" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    NSAttributedString *courseStr =[[NSAttributedString alloc] initWithString:@" Enter Course Name" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    NSAttributedString *teacherStr =[[NSAttributedString alloc] initWithString:@" Who is the Teacher?" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    
    self.TopicTextField.attributedPlaceholder = topicStr;
    self.CourseTextField.attributedPlaceholder = courseStr;
    self.TeacherTextField.attributedPlaceholder = teacherStr;
  
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}



- (IBAction)isReminderSelected:(UISwitch *)sender {
    if([_reminderSetField isOn]){
        NSLog(@"On");
        UIAlertView * alert = [[UIAlertView alloc]
                               initWithTitle:@"Ryte Task!" message:@"We will notify you before 24 hours"
                               delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];

        
    }

    
    else {NSLog(@"Off");
        

    }
}





- (IBAction)AddNewTask:(UIButton *)sender {
    NSString *topic = _TopicTextField.text;
    NSString *course = _CourseTextField.text;
    NSString *teacher = _TeacherTextField.text;
    NSDate *due_date = _DueDatePicker.date;
    NSString *reminder_set;
//    BOOL isReminderEnabled = YES;
    if([_reminderSetField isOn])
        reminder_set = @"Yes";
    else
        reminder_set = @"No";
    
    
    if([_reminderSetField isOn]){
        NSLog(@"Hello");
        
    }
    else NSLog(@"Noooooo");
    
    
    if(topic.length==0){
        UIAlertView * alert = [[UIAlertView alloc]
    initWithTitle:@"Ryte Task!" message:@"Please mention the topic"
    delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    [alert show];
        //NSLog(@"%@ -- %@ -- %@ -- %@",topic,teacher,course,due_date);
    }
    else{
        
        
    NSError *error = nil;
        AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = theDelegate.managedObjectContext;
        
        
        
    Tasks *tasks = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Tasks"
        inManagedObjectContext:managedObjectContext];
        tasks.topic = topic;
        tasks.course = course;
        tasks.teacher = teacher;
        tasks.due_date = due_date;
        tasks.isComplete = @"No";
        tasks.isTrashed = @"No";
        tasks.reminder = reminder_set;

        
        NSLog(@"Hei");
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks"
                                                  inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (Tasks *task in fetchedObjects) {
            NSLog(@"Topic: %@", task.topic);
        }
        if (![managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

        
        
        _TopicTextField.text = @"";
        _CourseTextField.text = @"";
        _TeacherTextField.text = @"";
        _reminderSetField.enabled = NO;

        
        
        FirstViewController *controller = [self.storyboard   instantiateViewControllerWithIdentifier:@"TheMaster"];
        [self presentViewController:controller animated:YES completion:nil];
        
        
        

        
        
        
        
    
    
    }
    
    
    
    
}




@end
