//
//  FSATVCell.m
//  FourSquareApp
//
//  Created by Savitha Reddy on 7/21/14.
//  Copyright (c) 2014 Savitha. All rights reserved.
//

#import "FSATVCell.h"

@implementation FSATVCell
{
    UIImageView *venueImage;
    UILabel *venueName;
    UILabel *venuePlace;
    UILabel *venuePhone;
    UILabel *venueDistance;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        venueImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        venueImage.layer.cornerRadius = 25;
        venueImage.clipsToBounds = YES;
        [self.contentView addSubview:venueImage];
        
        venueName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 200, 15)];
        [venueName setFont:[UIFont fontWithName:@"Seravek" size:18]];
        venueName.textColor = [UIColor blueColor];
        [self.contentView addSubview:venueName];
        
        venuePlace = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 150, 12)];
        [venuePlace setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
//        venuePlace.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:venuePlace];
        
        venuePhone = [[UILabel alloc] initWithFrame:CGRectMake(65, 52, 150, 10)];
        [venuePhone setFont:[UIFont fontWithName:@"Arial" size:10]];
        [self.contentView addSubview:venuePhone];
        
        venueDistance = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 50, 50)];
        venueDistance.backgroundColor = [UIColor lightGrayColor];
        venueDistance.layer.cornerRadius = 25;
        venueDistance.clipsToBounds = YES;
        [venueDistance setFont:[UIFont fontWithName:@"Seravek" size:10]];
        venueDistance.textColor = [UIColor blueColor];
       [self.contentView addSubview:venueDistance];
    }
    return self;
}

-(void) setInfo:(NSDictionary *)info
{
    _info = info;
    NSURL *url = [NSURL URLWithString:info[@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    venueImage.image = image;
    venueName.text = info[@"name"];
    venuePlace.text = info[@"place"];
    venuePhone.text = info[@"phone"];
//   NSUInteger intDist = (int)info[@"distance"];
//    NSLog(@" distance is %d",(int)intDist);
//   venueDistance.text = [NSString stringWithFormat:@ "%d",(int) info[@"distance"]];
//    venueDistance.text =[ @((int)info[@"distance"]) stringValue];
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
