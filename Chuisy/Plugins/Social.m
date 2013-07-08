//
//  Social.m
//
//  Cameron Lerch
//  Sponsored by Brightflock: http://brightflock.com
//

#import "Social.h"

@interface Social ()

@end

@implementation Social

- (void) available:(CDVInvokedUrlCommand*)command {
    NSString *service = [command.arguments objectAtIndex:0];
    NSString *serviceType;
    
    if ([service isEqual: @"facebook"]) {
        serviceType = SLServiceTypeFacebook;
    } else if ([service isEqual: @"twitter"]) {
        serviceType = SLServiceTypeTwitter;
    } else {
        serviceType = nil;
    }
    
    BOOL avail = false;
    
    if (NSClassFromString(@"UIActivityViewController") && [SLComposeViewController isAvailableForServiceType:serviceType]) {
        avail = true;
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool: avail];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) facebook:(CDVInvokedUrlCommand*)command {
    NSString *text = [command.arguments objectAtIndex:0];
    NSString *urlString = [command.arguments objectAtIndex:1];
    NSURL *url = [NSURL URLWithString: urlString];
    NSString *imageUrl = [command.arguments objectAtIndex:2];
    UIImage *image = nil;
    if (imageUrl != (id)[NSNull null] && imageUrl.length != 0) {
        image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbSLComposerSheet setInitialText:[NSString stringWithFormat:text, fbSLComposerSheet.serviceType]];
        if (image != nil) {
            [fbSLComposerSheet addImage: image];
        }
        [fbSLComposerSheet addURL: url];
        
        [fbSLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            CDVPluginResult *pluginResult;
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    break;
                case SLComposeViewControllerResultDone:
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    break;
                default:
                    break;
            }
        }];
        
        [self.viewController presentViewController:fbSLComposerSheet animated:YES completion:nil];
    } else {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

-(void) twitter:(CDVInvokedUrlCommand*)command {
    NSString *text = [command.arguments objectAtIndex:0];
    NSString *urlString = [command.arguments objectAtIndex:1];
    NSURL *url = [NSURL URLWithString: urlString];
    NSString *imageUrl = [command.arguments objectAtIndex:2];
    UIImage *image = nil;
    if (imageUrl != (id)[NSNull null] && imageUrl.length != 0) {
        image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    }
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *twSLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [twSLComposerSheet setInitialText:[NSString stringWithFormat:text, twSLComposerSheet.serviceType]];
        if (image != nil) {
            [twSLComposerSheet addImage: image];
        }
        [twSLComposerSheet addURL: url];
        
        [twSLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            CDVPluginResult *pluginResult;
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    break;
                case SLComposeViewControllerResultDone:
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                    break;
                default:
                    break;
            }
            
            [twSLComposerSheet dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self.viewController presentViewController:twSLComposerSheet animated:YES completion:nil];
    } else {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
