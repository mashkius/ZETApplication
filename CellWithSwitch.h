//
//  CellWithSwitch.h
//  ZETApp
//
//  Created by Mantas Laurinavicius on 07/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithSwitch : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *switcher;

@end
