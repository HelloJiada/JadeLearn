//
//  ColorMacro.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#ifndef ColorMacro_h
#define ColorMacro_h

#define JadeColor(a) [UIColor colorFromHexString:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kThemeBackgroundColor JadeColor(@"AEEEEE")
#endif /* ColorMacro_h */
