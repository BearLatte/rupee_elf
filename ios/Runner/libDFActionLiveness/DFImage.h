//
//  DFImage.h
//  DFActionLivenessDetector
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DFLivenessEnumType.h"

@interface DFImage : NSObject

/**
 *  image
 */
@property (nonatomic, strong) UIImage *image;

/**
 *  Image index in the action sequence, 0 is the first
 */
@property (nonatomic, assign) int iIndex;

/**
 *  Type of detection module to which the image belongs
 */
@property (nonatomic, assign) LivefaceDetectionType iDetectionType;

@end
