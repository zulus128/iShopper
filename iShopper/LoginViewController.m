//
//  LoginViewController.m
//  iShopper
//
//  Created by Zul on 10/7/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Login";
    self.view.userInteractionEnabled = TRUE;

//    [self.view endEditing:YES];

}

- (IBAction)signin:(id)sender {
    
    NSString* mail = self.mailfield.text;
    NSString* pass1 = self.pass1.text;
    NSString* pass2 = self.pass2.text;
    
    //    NSLog(@"password = %@, md5 = %@", pass1, [self md5:pass1]);
    
    if([pass1 isEqualToString:pass2]) {
        
        if(![self NSStringIsValidEmail:mail]){
            
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"E-mail is not valid" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
        }
        else {
            
            if([[Common instance] authorizeWithEmail:mail andPassword:[self md5:pass1] andType:AUTH_NEW]) {
                
                NSLog(@"Sign Up OK!");
                [self performSegueWithIdentifier:@"goTabBar" sender:self];
                
            }
            
        }
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
