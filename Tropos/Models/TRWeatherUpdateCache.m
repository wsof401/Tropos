//
//  TRWeatherUpdateCache.m
//  Tropos
//
//  Created by James Craige on 5/8/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

#import "TRWeatherUpdateCache.h"

#define kLatestWeatherUpdateKey @"LatestWeatherUpdate"
#define kLatestWeatherUpdateFile @"latestWeatherUpdate.plist"

@interface TRWeatherUpdateCache ()

@property (weak, nonatomic) NSString *latestWeatherUpdateFilePath;

@end

@implementation TRWeatherUpdateCache

- (instancetype)init
{
    self = [super init];
    if (!self) { return nil; }

    NSString *cachesFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    self.latestWeatherUpdateFilePath = [cachesFolder stringByAppendingPathComponent:kLatestWeatherUpdateFile];

    return self;
}

- (TRWeatherUpdate *)latest
{
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:self.latestWeatherUpdateFilePath];
    if (!codedData) { return nil; }

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    TRWeatherUpdate *latestUpdate = [unarchiver decodeObjectForKey:kLatestWeatherUpdateKey];
    [unarchiver finishDecoding];

    return latestUpdate;
}

- (BOOL)saveWeatherUpdate:(TRWeatherUpdate *)update
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:update forKey:kLatestWeatherUpdateKey];
    [archiver finishEncoding];
    [data writeToFile:self.latestWeatherUpdateFilePath atomically:YES];

    return NO;
}

@end
