//
//  ViewController.m
//  DayTwelve
//
//  Created by Anuj Katiyal on 29/09/14.
//  Copyright (c) 2014 Katiyals. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    NSArray *fetchedObjects;
    NSManagedObject *selectedObject;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.txtInfo.delegate = self;
    self.txtName.delegate = self;
    self.txtNumber.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tappedSaveAsNew:(id)sender{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSManagedObject *dataRecord = [NSEntityDescription insertNewObjectForEntityForName:@"DataRecord"
                                                                inManagedObjectContext:context];
    [dataRecord setValue:self.txtName.text forKey:@"name"];
    [dataRecord setValue:self.txtInfo.text forKey:@"info"];
    [dataRecord setValue:[NSNumber numberWithInteger:[self.txtNumber.text integerValue]] forKey:@"number"];
    [dataRecord setValue:[NSDate date] forKey:@"createDate"];
    [dataRecord setValue:[NSDate date] forKey:@"updateDate"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Error:%@", error);
    }
    NSLog(@"Data saved");
}

- (IBAction)tappedLoadData:(id)sender{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"DataRecord"];
    
    NSError *error;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *obj in fetchedObjects) {
        NSLog(@"Name: %@", [obj valueForKey:@"name"]);
        NSLog(@"Info: %@", [obj valueForKey:@"info"]);
        NSLog(@"Number: %@", [obj valueForKey:@"number"]);
        NSLog(@"Create Date: %@", [obj valueForKey:@"createDate"]);
        NSLog(@"Last Update: %@", [obj valueForKey:@"updateDate"]);
    }
    
    NSManagedObject *obj = [fetchedObjects objectAtIndex:0];
    [self displayManagedObject:obj];
    selectedObject = obj;
}

- (void)displayManagedObject:(NSManagedObject *)obj {
    self.txtName.text = [obj valueForKey:@"name"];
    self.txtInfo.text = [obj valueForKey:@"info"];
    self.txtNumber.text = [(NSNumber *)[obj valueForKey:@"number"] stringValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.lblCreateDate.text = [dateFormatter stringFromDate:[obj valueForKey:@"createDate"]];
    self.lblUpdateDate.text = [dateFormatter stringFromDate:[obj valueForKey:@"updateDate"]];
}

- (IBAction)tappedNext:(id)sender{
    BOOL isNext = NO;
    for (NSManagedObject *obj in fetchedObjects) {
        if (isNext) {
            selectedObject = obj;
            [self displayManagedObject:obj];
            return;
        }else{
            if (obj == selectedObject) {
                isNext = YES;
            }
        }
    }
}

- (IBAction)tappedPrevious:(id)sender{
    BOOL isPrevious = NO;
    for (int i = fetchedObjects.count - 1 ; i >= 0 ; i--) {
        if (isPrevious) {
            selectedObject = [fetchedObjects objectAtIndex:i];
            [self displayManagedObject:selectedObject];
            return;
        }else{
            if ([fetchedObjects objectAtIndex:i] == selectedObject) {
                isPrevious = YES;
            }
        }
    }
}


@end
