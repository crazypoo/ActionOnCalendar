//
//  PooViewController.m
//  ActionOnCalendar
//
//  Created by crazypoo on 14-5-4.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooViewController.h"
#import "PooActionOnCalendar.h"

@interface PooViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property (nonatomic, retain) UITextField *textTitle;
@property (nonatomic, retain) UITextField *textComent;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation PooViewController
@synthesize textTitle = _textTitle;
@synthesize textComent = _textComent;
@synthesize selectedIndex = _selectedIndex;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.textTitle                            = [[UITextField alloc] initWithFrame:CGRectMake(77, 200, 195, 30)];
    self.textTitle.textColor                  = [UIColor blackColor];
    self.textTitle.autocorrectionType         = UITextAutocorrectionTypeNo;
    self.textTitle.keyboardType               = UIKeyboardTypeAlphabet;
    self.textTitle.clearButtonMode            = UITextFieldViewModeWhileEditing;
    self.textTitle.returnKeyType              = UIReturnKeyDone;
    self.textTitle.textAlignment              = NSTextAlignmentLeft;
    self.textTitle.delegate                   = self;
    self.textTitle.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.textTitle];
    
    self.textComent                            = [[UITextField alloc] initWithFrame:CGRectMake(77, 230, 195, 30)];
    self.textComent.textColor                  = [UIColor blackColor];
    self.textComent.autocorrectionType         = UITextAutocorrectionTypeNo;
    self.textComent.keyboardType               = UIKeyboardTypeAlphabet;
    self.textComent.clearButtonMode            = UITextFieldViewModeWhileEditing;
    self.textComent.returnKeyType              = UIReturnKeyDone;
    self.textComent.textAlignment              = NSTextAlignmentLeft;
    self.textComent.delegate                   = self;
    self.textComent.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textComent];
    
    UIPickerView *timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    timePicker.backgroundColor = [UIColor lightGrayColor];
    timePicker.dataSource = self;
    timePicker.delegate = self;
    [self.view addSubview:timePicker];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textComent resignFirstResponder];
    [self.textTitle resignFirstResponder];
    return YES;
}

-(IBAction)taptap:(id)sender
{
    [self.textTitle resignFirstResponder];
    [self.textComent resignFirstResponder];
    
    NSDate*startData     = [NSDate dateWithTimeIntervalSinceNow:10];
    NSDate*endDate       = [NSDate dateWithTimeIntervalSinceNow:100];
    //设置事件之前多长时候开始提醒
    float alarmFloat     = self.selectedIndex + 1;
    NSString*eventTitle  = self.textTitle.text;
    NSString*locationStr = self.textComent.text;
    //isReminder 是否写入提醒事项
    [PooActionOnCalendar saveEventStartDate:startData endDate:endDate alarm:alarmFloat eventTitle:eventTitle location:locationStr isReminder:YES];
    
    UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil                                            delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alview show];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedIndex = row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%li", row + 1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
