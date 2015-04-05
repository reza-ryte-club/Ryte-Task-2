//
//  NewViewController.h
//  TabApp
//
//  Created by RahmanMd. Rezaur on 4/5/15.
//  Copyright (c) 2015 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController




@property (weak, nonatomic) IBOutlet UIButton *AddButton;
@property (weak, nonatomic) IBOutlet UITextField *TopicTextField;
@property (weak, nonatomic) IBOutlet UITextField *CourseTextField;
@property (weak, nonatomic) IBOutlet UITextField *TeacherTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *DueDatePicker;







- (IBAction)AddNewTask:(UIButton *)sender;


@end
