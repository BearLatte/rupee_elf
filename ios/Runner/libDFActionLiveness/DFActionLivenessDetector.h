//
//  DFActionLivenessDetector.h
//  DFActionLivenessDetector
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DFActionLivenessDetectorDelegate.h"
#import "DFImage.h"

@interface DFActionLivenessDetector : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Initialization method
 *
 *  @param dDurationPerModel    The maximum detection time allowed for each module. When the value is less than or equal to 0, the timeout period is not set.
 *  @param strBundlePath        Resource path
 *  @param strLicensePath       License path
 *
 *  @return detector instance
 */
- (instancetype)initWithDuration:(double)dDurationPerModel
             resourcesBundlePath:(NSString *)strBundlePath
                     licensePath:(NSString *)strLicensePath;


/**
 *  Detector configuration method
 *
 *  @param delegate     Callback delegate
 *  @param queue        Callback queue
 *  @param arrDetection Action sequence, such as @[@(LIVE_HOLDSTILL), @(LIVE_BLINK), @(LIVE_MOUTH), @(LIVE_NOD), @(LIVE_YAW)], refer to DFLivenessEnumType.h
 *  @param arrThreshold Threshold, such as @[@(0.7), @(0.7), @(0.7), @(0.7), @(0.7)]
 */
- (void)setDelegate:(id <DFActionLivenessDetectorDelegate>)delegate
      callBackQueue:(dispatch_queue_t)queue
  detectionSequence:(NSArray *)arrDetection
 detectionThreshold:(NSArray *)arrThreshold;

/**
 Setting configuration

 @param region face detected regon
 @param faceMaxSizeRatio face size ratio percentage
 */
- (void)setFaceDetectedRegion:(CGRect)region faceMaxSizeRatio:(float)faceMaxSizeRatio;

/**
 *
 *  @param iOutputType The output scheme after the successful detection, must be LIVE_OUTPUT_MULTI_IMAGE, Others do not support
 */
- (void)setOutputType:(LivefaceOutputType)iOutputType;

/**
 *  Face tracking and live detection for continuous input frames
 *
 *  @param sampleBuffer    Image data for each frame
 *  @param faceOrientation Face orientation
 */
- (void)trackAndDetectWithCMSampleBuffer:(CMSampleBufferRef)sampleBuffer
                         faceOrientation:(LivefaceOrientation)faceOrientation;


/**
 *  Start detection
 */
- (void)startDetection;



/**
 *  Cancel detection
 */
- (void)cancelDetection;


/**
 *  Get the SDK version
 *
 *  @return SDK Version
 */
+ (NSString *)getSDKVersion;


@end
