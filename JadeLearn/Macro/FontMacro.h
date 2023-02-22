//
//  FontMacro.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/21.
//

#ifndef FontMacro_h
#define FontMacro_h

#define kFontFamilyRegular             @"DMSans-Regular"
#define kFontFamilyBold                @"DMSans-Bold"
#define kFontFamilyMedium              @"DMSans-Medium"


#define PingFangRegularFont(font)   [UIFont fontWithName:kFontFamilyRegular size:font]

#define PingFangMediumFont(font) [UIFont fontWithName:kFontFamilyMedium size:font]

#define PingFangBoldFont(font)  [UIFont fontWithName:kFontFamilyBold size:font]

#endif /* FontMacro_h */
