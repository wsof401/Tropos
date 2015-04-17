#import <HockeySDK/HockeySDK.h>
#import "TRAppDelegate.h"
#import "TRAnalyticsController.h"
#import "TRSettingsController.h"
#import "TRWeatherController.h"
#import "Tropos-Swift.h"

#ifndef DEBUG
#import "Secrets.h"
#endif

@interface TRAppDelegate ()

@property (strong, nonatomic) TRWeatherController *controller;

@end

@implementation TRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifndef DEBUG
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:TRHockeyIdentifier];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];

    [[TRAnalyticsController sharedController] install];
#endif

    [[TRSettingsController new] registerSettings];

//    self.controller = [TRWeatherController new];
//
//    [[self.controller conditionsDescriptionString] subscribeNext:^(NSString *phrase) {
//        if (phrase == nil) {
//            NSLog(@"aasdlfkjasdf");
//        } else {
//            NSLog(@"%@", phrase);
//        }
//    }];
//
//    [self.controller.updateWeatherCommand execute:self];

    return YES;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    [self loadWeatherDataForWatch:reply];
//    reply(nil);
}

- (void)loadWeatherDataForWatch:(void (^)(NSDictionary *))callback
{
    self.controller = [TRWeatherController new];

    [[self.controller conditionsDescriptionString] subscribeNext:^(NSString *phrase) {
        if (phrase == nil) {
//            callback(@{
//                @"phrase" : @"nil!!!",
//                @"image" : @"rain",
//            });
        } else {
            //TODO: why is the phrase always nil??
            //If we move this method's body into didFinishLaunchingWithOptions, and we hit the non-nil case
            callback(@{
                @"phrase" : @"phrase!!",
                @"image" : @"clear-day",
            });
        }
    }];

    [self.controller.updateWeatherCommand execute:self];
}

@end
