//
//  NavigationController.m
//  ZETApp
//
//  Created by Mantas Laurinavicius on 06/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

#import "NavigationController.h"
#import "DesignChoices.h"

@implementation NavigationController

-(void)viewDidLoad {
    self.navigationBar.barTintColor = HexColor(navBarColor);
    self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    //could have been done in AppDelegate, but you could have missed it :) this also required to add some field in pList to allow modification of status bar style
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}


@end
