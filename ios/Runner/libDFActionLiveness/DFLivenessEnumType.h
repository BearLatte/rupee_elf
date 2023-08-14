//
//  DFLivenessEnumType.h
//  DFActionLivenessDetector
//
//

#ifndef DFLivenessEnumType_h
#define DFLivenessEnumType_h


/**
 *  Live detection failure type
 */
typedef NS_ENUM(NSInteger, LivefaceErrorType) {
    
    /**
     *  SDK initialization failed
     */
    LIVENESS_INIT_FAILD = 0,
    
    /**
     *  Camera permission acquisition failed
     */
    LIVENESS_CAMERA_ERROR,
    
    /**
     *  Face change
     */
    LIVENESS_FACE_CHANGED,
    
    /**
     *  Detection timeout
     */
    LIVENESS_TIMEOUT,
    
    /**
     *  App is about to be suspended
     */
    LIVENESS_WILL_RESIGN_ACTIVE,
    
    /**
     *  Internal error
     */
    LIVENESS_INTERNAL_ERROR,
    
    /**
     *  Bundle ID error
     */
    LIVENESS_BUNDLEID_ERROR,
    
    /**
     *  Authorization expired
     */
    LIVENESS_AUTH_EXPIRE,
    
    /**
     *  Action sequence error (starting with silence and only one silent action)
     */
    LIVENESS_SEQUENCE_ERROR,
    
    /**
     *  Face more than one error
     */
    LIVENESS_FACE_MORE_THAN_ONE_ERROR,
    
    /**
     *  License invalid
     */
    LIVENESS_LICENSE_INVALID,
};

/**
 *  Detection module type
 */
typedef NS_ENUM(NSInteger, LivefaceDetectionType) {
    /**
     *  Blink detection
     */
    LIVE_BLINK = 0,
    
    /**
     *  Open mouth detection
     */
    LIVE_MOUTH,
    
    /**
     *  Left and right rotor detection
     */
    LIVE_YAW,
    
    /**
     *  Up and down nodding detection
     */
    LIVE_NOD,
    
    /**
     *  Silent detection
     */
    LIVE_HOLDSTILL,
};


/**
 *  Face direction
 */
typedef NS_ENUM(NSUInteger, LivefaceOrientation) {
    /**
     *  The face is up, that is, the face is facing normal
     */
    LIVE_FACE_UP = 0,
    /**
     *  The face is to the left, that is, the face is rotated 90 degrees counterclockwise
     */
    LIVE_FACE_LEFT = 1,
    /**
     *  The face is down, that is, the face is rotated 180 degrees counterclockwise
     */
    LIVE_FACE_DOWN = 2,
    /**
     *  The face is to the right, that is, the face is rotated 270 degrees counterclockwise
     */
    LIVE_FACE_RIGHT = 3
};


/**
 *  Output scheme
 */
typedef NS_ENUM(NSUInteger, LivefaceOutputType) {
    /**
     *  Multi-image scheme
     */
    LIVE_OUTPUT_MULTI_IMAGE = 1,
    
    /**
     *  Video scheme
     */
    LIVE_OUTPUT_VIDEO,
};

typedef NS_ENUM(NSInteger, LivefaceRectStatus) {
    LivefaceRectStatusNone = -1,                //No face passed the test
    LivefaceRectStatusSuccess = 0,              //Face detection successfully
    LivefaceRectStatusLarge = 1,                //The face is too large, beyond the face detection area
    LivefaceRectStatusMoreThanOne = 2,          //More than one face
};

#endif /* DFLivenessEnumType_h */
