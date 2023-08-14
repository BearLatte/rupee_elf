//
//  DFLivenessCommon.h
//  DFLivenessController
//
//

#ifndef DFLivenessCommon_h
#define DFLivenessCommon_h


#define kDFColorWithRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kDFScreenWidth [UIScreen mainScreen].bounds.size.width
#define kDFScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* DFLivenessCommon_h */
