//
//  XMLUIGeneratorTestAppDelegate.h
//  XMLUIGeneratorTest
//
//  Created by Snow Leopard User on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLUIGeneratorTestAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *_window;
    IBOutlet UINavigationController *_uiNav;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *uiNav;

@end
