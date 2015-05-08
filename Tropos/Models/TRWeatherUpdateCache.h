//
//  TRWeatherUpdateCache.h
//  Tropos
//
//  Created by James Craige on 5/8/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRWeatherUpdate.h"

@interface TRWeatherUpdateCache : NSObject

- (TRWeatherUpdate *)latest;
- (BOOL)saveWeatherUpdate:(TRWeatherUpdate *)update;

@end
