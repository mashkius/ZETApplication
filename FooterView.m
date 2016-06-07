//
//  FooterView.m
//  ZETApp
//
//  Created by Mantas Laurinavicius on 07/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView

- (void)drawRect:(CGRect)rect {
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(40, 25, (rect.size.width-80)/2, 50)];
    [cancel setTitle:NSLocalizedString(@"cancel-button", @"Cancel") forState:UIControlStateNormal];
    //cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    //cancel.titleLabel.textColor = [UIColor whiteColor];
    cancel.backgroundColor = HexColor(cancelButtonBackground);
    [cancel addTarget:self action:@selector(clearAllFields) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *save = [[UIButton alloc] initWithFrame:CGRectMake((rect.size.width-80)/2+40, 25, (rect.size.width-80)/2, 50)];
    [save setTitle:NSLocalizedString(@"save-button", @"Save") forState:UIControlStateNormal];
    save.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    save.titleLabel.textColor = [UIColor whiteColor];
    save.backgroundColor = HexColor(saveButtonBackground);
    [save addTarget:self action:@selector(saveTableData) forControlEvents:UIControlEventTouchUpInside];
    
    [self addMaskTo:save byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight];
    [self addMaskTo:cancel byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    
    [self addSubview:cancel];
    [self addSubview:save];
}

-(void)saveTableData {
    [self.parent saveData];
}

-(void)clearAllFields {
    [self.parent clearTextFields];
}

-(void)addMaskTo:(UIView*)view byRoundingCorners:(NSInteger)corner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(view.frame.size.height/2, view.frame.size.height/2)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


@end
