//
//  LoginViewController.m
//  iShopper
//
//  Created by Zul on 10/7/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"

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
    
    if([[Common instance] authorizeWithEmail:mail andPassword:pass1 andType:AUTH_EXIST]) {
        
        NSLog(@"Sign In OK!");
        [self performSegueWithIdentifier:@"goTabBar" sender:self];
        
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
