//
//  YFGIFImageView.h
//  UIImageView-PlayGIF
//
//  Created by Yang Fei on 14-3-26.
//  Copyright (c) 2014年 yangfei.me. All rights reserved.
//

/*******************************************************
 *  Dependencies:
 *      - QuartzCore.framework
 *      - ImageIO.framework
 *  Parameters:
 *      Pass value to one of them:
 *      - gifData NSData from a GIF
 *      - gifPath local path of a GIF
 *  Usage:
 *      - startGIF
 *      - stopGIF
 *      - isGIFPlaying
 *******************************************************/

#import <UIKit/UIImageView.h>

typedef void(^YFGIFImageViewCompletionBlock)(void);

@interface YFGIFImageView : UIImageView

@property (nonatomic, strong) NSString          *gifPath;
@property (nonatomic, strong) NSData            *gifData;
@property (nonatomic, assign, readonly) CGSize  gifPixelSize;
@property (nonatomic, assign) BOOL restart;
@property (nonatomic, assign) BOOL shouldShowLastFrame; // Whether to retain the last frame after the end of playback, the default is NO
@property (nonatomic, assign) NSInteger repeatMaxCount; // Gif maximum number of cycles, default is infinity
@property (nonatomic, copy, readonly) YFGIFImageViewCompletionBlock completionBlock; // After setting the number of Gif image loops, the callback at the end of playback

- (instancetype)initWithRepeatMaxCount:(NSInteger)repeatMaxCount;
- (instancetype)initWithRepeatMaxCount:(NSInteger)repeatMaxCount withCompletionBlock:(YFGIFImageViewCompletionBlock)completionBlock;     // Designed Initializer
- (NSTimeInterval)duration; // Gif’playing time
- (void)startGIF;
- (void)startGIFWithRunLoopMode:(NSString * const)runLoopMode;
- (void)stopGIF;
- (BOOL)isGIFPlaying;

@end
