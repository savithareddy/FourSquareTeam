//
//  FSAStepsTableVC.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 8/20/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSAStepsTableVC.h"
#import "STASingleton.h"

@interface FSAStepsTableVC ()



@end

@implementation FSAStepsTableVC
{
    NSArray *stepsArrayOne;
    NSMutableArray *stepsArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
//            NSLog(@"current route is %@",self.tableRoute.steps);
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(goToTable)];
        self.navigationItem.leftBarButtonItem = back;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    stepsArray = self.mapTableArray;
    
//    NSString *theString = [STASingleton mainSingleton].routeTextSteps;
//    NSLog(@"new string is %@",theString);
//    stepsArray = [[NSMutableArray alloc] initWithCapacity:[theString length]];
//    for (int i=0; i < [theString length]; i++) {
//        NSString *newString = [NSString stringWithFormat:@" %@",[theString stringByAppendingString:theString]];
//        NSLog(@"new string is %@",newString);
//        [stepsArray addObject:newString];
        NSLog(@"array now  table is %@",self.mapTableArray);
//    NSLog(@"array now  table is %@",self.mapTableDistanceArray);
    
//    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(void) goToTable
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mapTableArray count];
//    return [self.mapTableDistanceArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.mapTableArray[indexPath.row];
//    cell.textLabel.text = self.mapTableDistanceArray[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
