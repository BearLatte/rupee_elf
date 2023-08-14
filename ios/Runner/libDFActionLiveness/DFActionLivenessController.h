//
//  DFActionLivenessController.h
//
//

#import <UIKit/UIKit.h>

/// Detection module type
typedef NS_ENUM(NSUInteger, DFDetectionType) {
    /// None
    DFDETECTION_NONE,
    
    /// Blink detection
    DFLIVEFACE_BLINK,
    
    /// Open mouth detection
    DFLIVEFACE_MOUTH,
    
    /// Up and down nodding detection
    DFLIVEFACE_NOD,
    
    /// Left and right rotor detection
    DFLIVEFACE_YAW,
    
    /// Silent detection
    DFLIVEFACE_HOLD_STILL
};

typedef NS_ENUM(NSUInteger, DFActionLivenessError) {
    /// SDK initialization failed
    DFActionLivenessInitFaild,
    
    /// Camera permission acquisition failed
    DFActionLivenessCameraError,
    
    /// Face change
    DFActionLivenessFaceChanged,
    
    /// Detection timeout
    DFActionLivenessTimeOut,
    
    /// App is about to be suspended
    DFActionLivenessWillResignActive,
        
    /// Internal error
    DFActionLivenessInternalError,
    
    /// Parsing Json configuration failed
    DFActionLivenessBadJson,
    
    /// Bundle ID error
    DFActionLivenessBundleIDError,
    
    /// Authorization expired
    DFActionLivenessAuthExpire,
    
    /// Action sequence error (starting with silence and only one silent action)
    DFActionLivenessSequenceError,
    
    /// Face more than one error
    DFActionLivenessFaceMoreThanOneError,
    
    /// License invalid
    DFActionLivenessLicenseInvalid,
};

@protocol DFActionLivenessDelegate <NSObject>

@optional

/**
 *  Action detection has started the callback
 */
- (void)actionLivenessDidStart;

@required

/**
 *  Action detecting successfully callback when set autoAntiHack to NO
 *  @param data       Pass back the encrypted binary data
 *  @param arrDFImage Return the DFImage array according to the specified output scheme. See DFImage.h for the DFImage property
 *  @param dfVideoData Return NSData video data according to the specified output scheme(nil)
 */
- (void)actionLivenessDidSuccessfulGetData:(NSData *)encryTarData
                                  dfImages:(NSArray *)arrDFImage
                               dfVideoData:(NSData *)dfVideoData;

/**
 *  Action detecting successfully callback when set autoAntiHack to YES
 *  @param data       Pass back the encrypted binary data
 *  @param arrDFImage Return the DFImage array according to the specified output scheme. See DFImage.h for the DFImage property
 *  @param dfVideoData Return NSData video data according to the specified output scheme(nil)
 *  @param isHack  Is a hack user or not.
 */
- (void)actionLivenessDidSuccessfulGetData:(NSData *)encryTarData
                                  dfImages:(NSArray *)arrDFImage
                               dfVideoData:(NSData *)dfVideoData
                                    isHack:(BOOL)isHack;

/**
 *  Action detecting failed callback
 *
 *  @param iErrorType      Type of failure
 *  @param iDetectionType  Detection module type on failure
 *  @param iIndex          The index of the detection module in the action sequence when it fails, starting from 0
 *  @param encryTarData    Pass back the encrypted binary data
 *  @param arrDFImage      Return the DFImage array according to the specified output scheme. See DFImage.h for the DFImage property
 *  @param dfVideoData     Return NSData video data according to the specified output scheme(nil)
 */
- (void)actionLivenessDidFailWithType:(DFActionLivenessError)iErrorType
                        DetectionType:(DFDetectionType)iDetectionType
                       DetectionIndex:(NSInteger)iIndex
                                 Data:(NSData *)encryTarData
                             dfImages:(NSArray *)arrDFImage
                          dfVideoData:(NSData *)dfVideoData;

/**
 *  Cancel the action detection callback
 */
- (void)actionLivenessDidCancel;

@end

@interface DFActionLivenessController : UIViewController

/// Callback delegate
@property (nonatomic, weak) id <DFActionLivenessDelegate>delegate;

/// Set json string , return whether the setting is successful
- (BOOL)setJsonCommand:(NSString *)strJsonCommand;

/// Start or restar
- (void)restart;

/// Cancel
- (void)cancel;

/// Get the SDK version
- (NSString *)getLivenessVersion;

@end
