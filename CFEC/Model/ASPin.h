//
//  ASPin.h
//  CFEC
//
//  Created by SumFlower on 14/10/30.
//  Copyright (c) 2014年 ___MyCompanyName___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

@interface ASPin : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
-(id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)title;

@end
