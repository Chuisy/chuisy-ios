//
//  Social.h
//
//  Cameron Lerch
//  Sponsored by Brightflock: http://brightflock.com
//

#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVPluginResult.h>
#import "social/Social.h"
#import "accounts/Accounts.h"
#import <Foundation/Foundation.h>

@interface Social : CDVPlugin {
}

- (void)available:(CDVInvokedUrlCommand*)command;
- (void)twitter:(CDVInvokedUrlCommand*)command;
- (void)facebook:(CDVInvokedUrlCommand*)command;

@end
