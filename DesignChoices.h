//
//  DesignChoices.h
//  ZETApp
//
//  Created by Mantas Laurinavicius on 06/06/16.
//  Copyright © 2016 Mashkius. All rights reserved.
//

// This allows to edit design fast if customer makes some changes

#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define navBarColor 0xDDBF00
#define headerBackgroundColor 0xF2F2F2

#define saveButtonBackground 0x497800
#define cancelButtonBackground 0xE72E24
