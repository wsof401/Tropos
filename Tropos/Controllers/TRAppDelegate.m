#import <HockeySDK/HockeySDK.h>
#import "TRAppDelegate.h"
#import "TRAnalyticsController.h"
#import "TRSettingsController.h"

#ifndef DEBUG
#import "Secrets.h"
#endif

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

    return YES;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    //FIXME: this is a huge hack

    NSString *cachesFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];

    NSString *phraseFile = [cachesFolder stringByAppendingPathComponent:@"lastWeatherUpdate.txt"];
    NSData *phraseData = [[NSFileManager defaultManager] contentsAtPath:phraseFile];
    NSString *phrase = [[NSString alloc] initWithData:phraseData encoding:NSUTF8StringEncoding];

    NSString *imageFile = [cachesFolder stringByAppendingPathComponent:@"lastWeatherUpdateImage.txt"];
    NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:imageFile];
    NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];

    NSDictionary *dict = @{
        @"phrase" : phrase,
        @"image" : imageString
    };
    reply(dict);
}

@end
