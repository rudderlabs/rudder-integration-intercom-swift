//
//  AppDelegate.m
//  SampleAppObjC
//
//  Created by Pallab Maiti on 11/03/22.
//

#import "AppDelegate.h"

@import Rudder;
@import RudderIntercom;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    RSConfig *config = [[RSConfig alloc] initWithWriteKey:@"<WRITE_KEY>"];
    [config dataPlaneURL:@"<DATA_PLANE_URL>"];
    [config loglevel:RSLogLevelDebug];
    [config trackLifecycleEvents:YES];
    [config recordScreenViews:YES];
    [[RSClient sharedInstance] configureWith:config];
    [[RSClient sharedInstance] addDestination:[[RudderIntercomDestination alloc] init]];
    [[RSClient sharedInstance] track:@"Track 1"];
    [[RSClient sharedInstance] identify:@"test_user_id"];
    [[RSClient sharedInstance] track:@"daily_rewards_claim"];
    [[RSClient sharedInstance] track:@"level_up"];
    [[RSClient sharedInstance] track:@"revenue"];
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
