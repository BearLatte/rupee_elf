//
//  DFCircleView.h
//  DFLivenessController
//
//

#import <UIKit/UIKit.h>

@interface DFCircleView : UIView

@property (nonatomic, assign) double fAnglePercent;

@property (nonatomic, assign) BOOL bPrepareToDealloc;

- (instancetype)initWithFrame:(CGRect)frame
                    bodyWidth:(CGFloat)fWidth
                    bodyColor:(UIColor *)colorB
                         font:(UIFont *)font
                    textColor:(UIColor *)colorT
                    MaxNumber:(double)dMaxNumber;

@end
