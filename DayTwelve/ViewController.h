//
//  ViewController.h
//  DayTwelve
//
//  Created by Anuj Katiyal on 29/09/14.
//  Copyright (c) 2014 Katiyals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtInfo;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateDate;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdateDate;
- (IBAction)tappedSaveAsNew:(id)sender;
- (IBAction)tappedLoadData:(id)sender;
- (IBAction)tappedNext:(id)sender;
- (IBAction)tappedPrevious:(id)sender;

@end

