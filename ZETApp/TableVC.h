//
//  TableVC.h
//  ZETApp
//
//  Created by Mantas Laurinavicius on 06/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignChoices.h"
#import "TableHeaderCell.h"
#import "CellWithSwitch.h"
#import "CellWithTextField.h"


@interface TableVC : UITableViewController
-(void)saveData;
-(void)clearTextFields;
@end
