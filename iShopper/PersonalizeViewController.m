//
//  SignUpViewController.m
//  iShopper
//
//  Created by Zul on 10/7/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "PersonalizeViewController.h"

@interface PersonalizeViewController ()

@end

@implementation PersonalizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"About Myself";
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Personalize" style:UIBarButtonItemStyleBordered target:self action:@selector(Personalize)];
    self.navigationItem.rightBarButtonItem = rightButton;


}

- (void) Personalize {
    
    [self performSegueWithIdentifier:@"goSignUp" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
