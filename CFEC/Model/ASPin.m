//
//  ASPin.m
//  CFEC
//
//  Created by SumFlower on 14/10/30.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import "ASPin.h"

@implementation ASPin

@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)title
{
    if(self =[super init])
    {
        coordinate =aCoordinate;
        _title = title;
    }
    return self;
}


-(CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

//注解标题
-(NSString *)title
{
    return _title;
}
@end
