//
//  SignUpViewController.m
//  iShopper
//
//  Created by Zul on 10/7/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "SignUpViewController.h"
#import "Common.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Sign Up";
    self.view.userInteractionEnabled = TRUE;
}

- (IBAction)signup:(id)sender {
    
    NSString* mail = self.mailfield.text;
    NSString* pass1 = self.pass1.text;
    NSString* pass2 = self.pass2.text;
    
//    NSLog(@"password = %@, md5 = %@", pass1, [self md5:pass1]);
    
    if([pass1 isEqualToString:pass2]) {

        if([[Common instance] authorizeWithEmail:mail andPassword:pass1 andType:AUTH_NEW]) {
            
            NSLog(@"Sign Up OK!");
            [self performSegueWithIdentifier:@"goTabBar" sender:self];
            
        }
//        else {
//            
//            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Sign Up Unsuccessful" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
//
//        }
        
    }
    else {
        
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords are not identical" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
