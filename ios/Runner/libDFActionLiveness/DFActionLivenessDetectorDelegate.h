//
//  DFActionLivenessDetectorDelegate
//
//

#import <Foundation/Foundation.h>
#import "DFLivenessEnumType.h"
#import "DFImage.h"

/**
 *  Action detection delegate
 */
@protocol DFActionLivenessDetectorDelegate <NSObject>

@optional

/**
 *  Callback method for each detection module
 *
 *  @param iDetectionType  The type of module that is currently being detecting
 *  @param iDetectionIndex The index of the module currently starting to be detected in the action sequence starts at 0.
 */
- (void)livenessDidStartDetectionWithDetectionType:(LivefaceDetectionType)iDetectionType
                                    detectionIndex:(int)iDetectionIndex;

/**
 *  Each frame of data is called back once, and the current module has been used for the time and the maximum processing time allowed by the current module
 *
 *  @param dPast             Current module detects elapsed time
 *  @param dDurationPerModel Current module detection total time
 */
- (void)livenessTimeDidPast:(double)dPast
           durationPerModel:(double)dDurationPerModel;

/** Frame rate */
- (void)videoFrameRate:(int)rate;

/**
 The number of faces per frame in silent live detection
 
 @param faceCount Face count
 @param faceRectStatus Face status
 @param iDetectionType  Detection module type
 */
- (void)livenessDectectingFaceCount:(int)faceCount faceRectStatus:(LivefaceRectStatus)faceRectStatus detectionType:(LivefaceDetectionType)iDetectionType;

@required

/**
 *  Action detecting successfully callback
 *
 *  @param data       Pass back the encrypted binary data
 *  @param arrDFImage Return the DFImage array according to the specified output scheme. See DFImage.h for the DFImage property
 *  @param dfVideoData Return NSData video data according to the specified output scheme(nil)

 */
- (void)livenessDidSuccessfulGetData:(nullable NSData *)data
                            dfImages:(nullable NSArray *)arrDFImage
                         dfVideoData:(nullable NSData *)dfVideoData;


/**
 *  Action detecting failed callback
 *
 *  @param iErrorType      Type of failure
 *  @param iDetectionType  Detection module type on failure
 *  @param iDetectionIndex The index of the detection module in the action sequence when it fails, starting from 0
 *  @param data            Pass back the encrypted binary data
 *  @param arrDFImage      Return the DFImage array according to the specified output scheme. See DFImage.h for the DFImage property
 *  @param dfVideoData     Return NSData video data according to the specified output scheme(nil)
 */
- (void)livenessDidFailWithErrorType:(LivefaceErrorType)iErrorType
                       detectionType:(LivefaceDetectionType)iDetectionType
                      detectionIndex:(int)iDetectionIndex
                                data:(nullable NSData *)data
                            dfImages:(nullable NSArray *)arrDFImage
                         dfVideoData:(nullable NSData *)dfVideoData;

/**
 *  Action detecting canceled callback
 *
 *  @param iDetectionType  Detection module type when detection is canceled
 *  @param iDetectionIndex The index of the detection module in the action sequence when the detection is canceled, starting from 0
 */
- (void)livenessDidCancelWithDetectionType:(LivefaceDetectionType)iDetectionType
                            detectionIndex:(int)iDetectionIndex;



@end
