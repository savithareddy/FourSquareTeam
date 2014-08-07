//
//  FSAViewController.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/31/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSAViewController.h"
#import "FSATableVC.h"
#import "STASingleton.h"

@interface FSAViewController ()

@end

@implementation FSAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
        
        UIButton *buttonAtlanta = [[UIButton alloc] initWithFrame:CGRectMake(80, 150, 150, 50)];
        buttonAtlanta.backgroundColor = [UIColor orangeColor];
        [buttonAtlanta setTitle:@"Atlanta" forState:UIControlStateNormal];
        buttonAtlanta.tag = 1;
        [buttonAtlanta addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonAtlanta];
        
        UIButton *buttonNewYork= [[UIButton alloc] initWithFrame:CGRectMake(80, 210, 150, 50)];
        buttonNewYork.backgroundColor = [UIColor blueColor];
        [buttonNewYork setTitle:@"New York" forState:UIControlStateNormal];
        buttonNewYork.tag = 2;
        [buttonNewYork addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonNewYork];
        
        UIButton *buttonLosAngeles = [[UIButton alloc] initWithFrame:CGRectMake(80, 270, 150, 50)];
        buttonLosAngeles.backgroundColor = [UIColor magentaColor];
        [buttonLosAngeles setTitle:@"Los Angeles" forState:UIControlStateNormal];
        buttonLosAngeles.tag = 3;
        [buttonLosAngeles addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLosAngeles];
        
        UIButton *buttonBangalore = [[UIButton alloc] initWithFrame:CGRectMake(80, 330, 150, 50)];
        buttonBangalore.backgroundColor = [UIColor redColor];
        [buttonBangalore setTitle:@"Bangalore" forState:UIControlStateNormal];
        buttonBangalore.tag = 4;
        [buttonBangalore addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonBangalore];
        
        UIButton *buttonChicago = [[UIButton alloc] initWithFrame:CGRectMake(80, 390, 150, 50)];
        buttonChicago.backgroundColor = [UIColor lightGrayColor];
        [buttonChicago setTitle:@"Chicago" forState:UIControlStateNormal];
        buttonChicago.tag = 5;
        [buttonChicago addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonChicago];
        
        UIButton *buttonDallas = [[UIButton alloc] initWithFrame:CGRectMake(80, 450, 150, 50)];
        buttonDallas.backgroundColor = [UIColor darkGrayColor];
        [buttonDallas setTitle:@"Dallas" forState:UIControlStateNormal];
        buttonDallas.tag = 6;
        [buttonDallas addTarget:self action:@selector(goToTableVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonDallas];

        
    }
    return self;
}

-(void) goToTableVC : (UIButton *) sender
{
    [STASingleton mainSingleton].buttonTag = (int) sender.tag;
    FSATableVC *tableVC = [[FSATableVC alloc] initWithStyle:UITableViewStylePlain];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:tableVC animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
