//
//  FSAStepsVC.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 8/20/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSAStepsVC.h"
#import "STASingleton.h"

@interface FSAStepsVC ()

@end

@implementation FSAStepsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(backtoMap)];
        self.navigationItem.leftBarButtonItem = cancel;
        
    }
    return self;
}

-(void) backtoMap
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UITextView *stepsLabel = [[UITextView alloc] initWithFrame:self.view.frame];
//    stepsLabel.text = [STASingleton mainSingleton].routeSteps;
    stepsLabel.textColor = [UIColor blueColor];
    [self.view addSubview:stepsLabel];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
