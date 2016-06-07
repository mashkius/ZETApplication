//
//  TableVC.m
//  ZETApp
//
//  Created by Mantas Laurinavicius on 06/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

#import "TableVC.h"
#import "FooterView.h"

@interface TableVC() <UITextFieldDelegate>
@property (nonatomic) NSArray *sectionOneItems;
@property (nonatomic) NSArray *sectionTwoItems;
@property (nonatomic) NSArray *sectionThreeItems;

@property (nonatomic) NSMutableArray *sectionOneEnteredFields;
@property (nonatomic) NSMutableArray *sectionTwoEnteredFields;
@property (nonatomic) NSMutableArray *sectionThreeSelections;
@end

@implementation TableVC

-(void)viewDidLoad {
    self.title = NSLocalizedString(@"nav-bar-title", @"Navigation Title: Registration");
    
    
    // retrieve saved data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrayOne = [userDefaults objectForKey:@"sectionOneEnteredFields"];
    NSArray *arrayTwo = [userDefaults objectForKey:@"sectionTwoEnteredFields"];
    NSArray *arrayThree = [userDefaults objectForKey:@"sectionThreeSelections"];
    
    NSLog(@"%@",arrayOne);
    
    NSString *email = NSLocalizedString(@"email", @"");
    NSString *password = NSLocalizedString(@"password", @"");
    NSString *repeatPassword = NSLocalizedString(@"repeat-password", @"");
    self.sectionOneItems = [[NSArray alloc] initWithObjects:email,password,repeatPassword, nil];
    self.sectionOneEnteredFields = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    
    
    NSString *name = NSLocalizedString(@"name", @"");
    NSString *surname = NSLocalizedString(@"surname", @"");
    self.sectionTwoItems = [[NSArray alloc] initWithObjects:name,surname, nil];
    self.sectionTwoEnteredFields = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    
    NSString *news = NSLocalizedString(@"news", @"");
    NSString *weather = NSLocalizedString(@"weather", @"");
    NSString *discounts = NSLocalizedString(@"discounts", @"");
    self.sectionThreeItems = [[NSArray alloc] initWithObjects:weather,news,discounts, nil];
    self.sectionThreeSelections = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
}

-(void)clearTextFields {
    self.sectionOneEnteredFields = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    self.sectionTwoEnteredFields = [[NSMutableArray alloc]initWithObjects:@"",@"", nil];
    self.sectionThreeSelections = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
    
    [self.tableView reloadData];
}

-(void)saveData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.sectionOneEnteredFields forKey:@"sectionOneEnteredFields"];
    [userDefaults setObject:self.sectionTwoEnteredFields forKey:@"sectionTwoEnteredFields"];
    [userDefaults setObject:self.sectionThreeSelections forKey:@"sectionThreeSelections"];
    [userDefaults synchronize];
}

-(void)switchDidChangeValue:(UISwitch*)sender {
    [self.sectionThreeSelections replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithBool:sender.isOn]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag < 10) {
        [self.sectionOneEnteredFields replaceObjectAtIndex:textField.tag withObject:textField.text];
    } else {
        [self.sectionTwoEnteredFields replaceObjectAtIndex:textField.tag-10 withObject:textField.text];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        CellWithSwitch *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWithSwitch"];
        if (cell == nil) {
            cell = [[CellWithSwitch alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithSwitch"];
        }
        
        cell.label.text = [self.sectionThreeItems objectAtIndex:indexPath.row];
        cell.label.tag = indexPath.row;
        cell.switcher.on = [[self.sectionThreeSelections objectAtIndex:indexPath.row] boolValue];
        cell.switcher.tag = indexPath.row;
        [cell.switcher addTarget:self action:@selector(switchDidChangeValue:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
        
    } else {
        
        CellWithTextField *cell = [tableView dequeueReusableCellWithIdentifier:@"CellWithTextField"];
        if (cell == nil) {
            cell = [[CellWithTextField alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithTextField"];
        }
        cell.textField.tag = indexPath.section*10 + indexPath.row;
        if (indexPath.section==0) {
            cell.label.text = [self.sectionOneItems objectAtIndex:indexPath.row];
            cell.textField.text = [self.sectionOneEnteredFields objectAtIndex:indexPath.row];
            if (indexPath.row!=0) {
                cell.textField.secureTextEntry = YES;
            }
        } else {
            cell.label.text = [self.sectionTwoItems objectAtIndex:indexPath.row];
            cell.textField.text = [self.sectionTwoEnteredFields objectAtIndex:indexPath.row];
        }
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (cell == nil) {
        cell = [[TableHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    }
    cell.backgroundColor = HexColor(headerBackgroundColor);
    if (section==0) {
        cell.headerTitle.text = [NSLocalizedString(@"login-data", @"login data header: Login") uppercaseString];
    } else if (section==1) {
        cell.headerTitle.text = [NSLocalizedString(@"users-info", @"user's info header: User's information") uppercaseString];
    } else {
        cell.headerTitle.text = [NSLocalizedString(@"choose-subscription", @"choose header: Choose") uppercaseString];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FooterView *footer = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    footer.backgroundColor = HexColor(headerBackgroundColor);
    footer.parent = self;
    
    return footer;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==2) {
        return 100;
    } else {
        return 0.1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        return 70;
    } else {
        return 110;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.sectionOneItems.count;
    } else if (section==1) {
        return self.sectionTwoItems.count;
    } else {
        return self.sectionThreeItems.count;
    }
}

@end
