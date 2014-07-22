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
    UILabel *venuePhone;
    UILabel *venueTiming;
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
        
        venueName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 150, 15)];
        [venueName setFont:[UIFont fontWithName:@"Chalkduster" size:18]];
        venueName.textColor = [UIColor blueColor];
        [self.contentView addSubview:venueName];
        
        venuePhone = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 150, 10)];
        [venuePhone setFont:[UIFont fontWithName:@"Chalkduster" size:12]];
        [self.contentView addSubview:venuePhone];
        
        venueTiming = [[UILabel alloc] initWithFrame:CGRectMake(65, 50, 150, 10)];
        [venueTiming setFont:[UIFont fontWithName:@"Chalkduster" size:8]];
        [self.contentView addSubview:venueTiming];
        
        venueDistance = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 50, 50)];
        venueDistance.backgroundColor = [UIColor lightGrayColor];
        venueDistance.layer.cornerRadius = 25;
        venueDistance.clipsToBounds = YES;
        [venueDistance setFont:[UIFont fontWithName:@"Chalkduster" size:12]];
        venueDistance.textColor = [UIColor blueColor];
       [self.contentView addSubview:venueDistance];
    }
    return self;
}

-(void) setInfo:(NSDictionary *)info
{
    _info = info;
    venueImage.image = info[@"image"];
    venueName.text = info[@"name"];
    venuePhone.text = info[@"phone"];
    venueTiming.text = info[@"timing"];
    venueDistance.text = info[@"distance"];
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end
