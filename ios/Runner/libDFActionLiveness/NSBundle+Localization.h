//
//  NSBundle+Localization.h
//  DFActionLiveness
//

#import <Foundation/Foundation.h>

#define DFLOCALIZATION(key) [NSBundle df_localizedStringForKey:key]
#define DFLOCALIZATIONFILEPATH(key) [NSBundle df_localizedPathStringForFileKey:key]

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Localization)

+ (instancetype)df_localizableBundleWithBundleName:(nullable NSString *)bundleName;
+ (NSString *)df_localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
+ (NSString *)df_localizedStringForKey:(NSString *)key;
+ (NSString *)df_localizedPathStringForFileKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
