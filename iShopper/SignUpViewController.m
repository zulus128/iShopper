//
//  SignUpViewController.m
//  iShopper
//
//  Created by Zul on 10/7/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

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

-(BOOL) NSStringIsValidEmail:(NSString *)checkString {
    
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (NSString *) md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
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
