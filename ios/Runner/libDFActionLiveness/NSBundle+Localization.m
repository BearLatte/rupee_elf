//
//  NSBundle+Localization.m
//  DFActionLiveness
//

#import "NSBundle+Localization.h"

#define dfRouterResBundle @"Localization"

@implementation NSBundle (Localization)

+ (instancetype)df_localizableBundleWithBundleName:(NSString *)bundleName {
    static NSBundle *localizableBundle = nil;
    if (localizableBundle == nil) {
        if (!bundleName) {
            bundleName = dfRouterResBundle;
        }
        NSString *bundleType = nil;
        if (bundleName && ![bundleName hasSuffix:@"bundle"]) {
            bundleType = @"bundle";
        }
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:bundleType];
        
        localizableBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return localizableBundle;
}

+ (NSString *)df_localizedStringForKey:(NSString *)key {
    NSString *value = [self df_localizedStringForKey:key value:nil];
    return value;
}

+ (NSString *)df_localizedStringForKey:(NSString *)key value:(NSString *)value{
    NSBundle *bundle = nil;
    NSString * language = [self getLanguageFromDevelopersSetup];
    if (!language) {
        language = [self getLanguageFromSystem];
    }
    language = [language componentsSeparatedByString:@"-"].firstObject;
    //从Localization.bundle中查找资源
    NSString *bundlePath = [[NSBundle df_localizableBundleWithBundleName:nil] pathForResource:language ofType:@"lproj"];
    if (!bundlePath) {
        
        bundlePath = [[NSBundle df_localizableBundleWithBundleName:nil] pathForResource:@"en" ofType:@"lproj"];
    }
    bundle = [NSBundle bundleWithPath:bundlePath];
    value = [bundle localizedStringForKey:key value:value table:@"DFLocalizationsHeader"];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (NSString *)df_localizedPathStringForFileKey:(NSString *)key
{
    NSString * language = [self getLanguageFromDevelopersSetup];
    if (!language) {
        language = [self getLanguageFromSystem];
    }
    //从Localization.bundle中查找资源
    NSString *bundlePath = [[NSBundle df_localizableBundleWithBundleName:nil] pathForResource:language ofType:@"lproj"];
    if (!bundlePath) {
        language = [language componentsSeparatedByString:@"-"].firstObject;
        bundlePath = [[NSBundle df_localizableBundleWithBundleName:nil] pathForResource:language ofType:@"lproj"];
        if (!bundlePath) {
            bundlePath = [[NSBundle df_localizableBundleWithBundleName:nil] pathForResource:@"en" ofType:@"lproj"];
        }
    }
    if (key.length && ![key hasSuffix:@".mp3"]) {
        key = [NSString stringWithFormat:@"%@.mp3", key];
    }
    NSString *path = [NSString pathWithComponents:@[bundlePath, key]];
    return path;
}

// reading system setting
+ (NSString *)getLanguageFromSystem{
    NSString *language = [NSLocale preferredLanguages].firstObject;
    return language;
}


// reading user setting
// TODO
+ (NSString *)getLanguageFromDevelopersSetup{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger languageStyle = [[userDefaults valueForKey:@"TODO"] integerValue];
    if (!languageStyle) {
        return nil;
    }
    switch (languageStyle) {
        case 1:
            return @"en";
            break;
        case 2:
            return @"zh-Hans";
            break;
        case 3:
            return @"zh-Hant";
            break;
        default:
            return @"en";
            break;
    }
}

@end
