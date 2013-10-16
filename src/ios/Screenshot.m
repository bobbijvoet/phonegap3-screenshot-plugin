#import "Screenshot.h"
#import <Cordova/CDV.h>
#import <QuartzCore/QuartzCore.h>

@implementation Screenshot

@synthesize webView;

- (void)saveScreenshot:(CDVInvokedUrlCommand*)command {
	CDVPluginResult* pluginResult = nil;

	CGRect imageRect;
	CGRect screenRect = [[UIScreen mainScreen] bounds];

	// statusBarOrientation is more reliable than UIDevice.orientation
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

	if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) { 
		// landscape check
		imageRect = CGRectMake(0, 0, CGRectGetHeight(screenRect), CGRectGetWidth(screenRect));
	} else {
		// portrait check
		imageRect = CGRectMake(0, 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
	}

	// Adds support for Retina Display. Code reverts back to original if iOs 4 not detected.
	if (NULL != UIGraphicsBeginImageContextWithOptions) {
		UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);
	} else {
		UIGraphicsBeginImageContext(imageRect.size);
	}

	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[[UIColor blackColor] set];
	CGContextTranslateCTM(ctx, 0, 0);
	CGContextFillRect(ctx, imageRect);

	[webView.layer renderInContext:ctx];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
	UIGraphicsEndImageContext();

	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Screenshot saved."];

	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
