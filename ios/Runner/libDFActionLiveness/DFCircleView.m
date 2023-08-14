//
//  DFCircleView.m
//  DFLivenessController
//
//

#import "DFCircleView.h"

@interface DFCircleView ()

@property (nonatomic , assign) CGFloat fBodyWidth;

@property (nonatomic , strong) UIColor *colorB;

@property (nonatomic , strong) UIFont *font;

@property (nonatomic , strong) UIColor *colorT;

@property (nonatomic , strong) UILabel *lblNumber;

@property (nonatomic , assign) NSInteger iLastNumber;

@property (nonatomic , assign) CGContextRef context;

@property (nonatomic , assign) double dMaxNumber;

@property (nonatomic, weak) CAShapeLayer *bgLayer;

@end

@implementation DFCircleView

- (instancetype)initWithFrame:(CGRect)frame bodyWidth:(CGFloat)fWidth bodyColor:(UIColor *)colorB font:(UIFont *)font textColor:(UIColor *)colorT MaxNumber:(double)dMaxNumber;
{
    if (self = [super initWithFrame:frame]) {
        _fBodyWidth = fWidth;
        _colorB = colorB;
        _font = font;
        _colorT = colorT;
        self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
        self.clipsToBounds = YES;
        self.iLastNumber = 0;
        self.dMaxNumber = dMaxNumber;
//        [self addSubview:self.lblNumber];
    }
    return self;
}

#pragma - mark lazy load
#pragma - mark

- (UILabel *)lblNumber
{
    if (!_lblNumber) {
        _lblNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - _fBodyWidth, self.frame.size.height - _fBodyWidth)];
        _lblNumber.backgroundColor = [UIColor clearColor];
        _lblNumber.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _lblNumber.layer.cornerRadius = (self.frame.size.width - _fBodyWidth) / 2;
        _lblNumber.clipsToBounds = YES;
        _lblNumber.textColor = _colorT;
        _lblNumber.textAlignment = NSTextAlignmentCenter;
        _lblNumber.font = _font;
        _lblNumber.adjustsFontSizeToFitWidth = YES;
    }
    return _lblNumber;
}

- (void)drawRect:(CGRect)rect
{
    if (!self.context) {
        self.context = UIGraphicsGetCurrentContext();
    }
    
    [self drawWithAnglePercent];
}

- (void)setFAnglePercent:(double)fAnglePercent
{
    if (fAnglePercent > 1.0) {
        fAnglePercent = 0.000001;
    }
    
    _fAnglePercent = fAnglePercent;
    [self setNeedsDisplay];
}


- (void)drawWithAnglePercent
{
    int iNumber = (int)ceilf((1.0 - self.fAnglePercent) * self.dMaxNumber);
    
    if (iNumber != self.iLastNumber) {
        self.lblNumber.text = [NSString stringWithFormat:@"%d" , iNumber];
        self.iLastNumber = iNumber;
    }
    //设置半径
    CGFloat radius = (self.frame.size.width - _fBodyWidth) / 2.0;
    //按照顺时针方向
    BOOL clockWise = NO;
    if (self.bgLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer new];
        layer.lineWidth = _fBodyWidth;
        //圆环的颜色
        layer.strokeColor = _colorB.CGColor;
        //背景填充色
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineCap = kCALineCapRound;
        //初始化一个路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:radius startAngle:-M_PI_2 endAngle:-M_PI_2 - M_PI * 2 * (1 - self.fAnglePercent) clockwise:clockWise];
        
        layer.path = [path CGPath];
        self.bgLayer = layer;
        [self.layer addSublayer:self.bgLayer];
    } else {
        //初始化一个路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:radius startAngle:-M_PI_2 endAngle:-M_PI_2 - M_PI * 2 * (1 - self.fAnglePercent) clockwise:clockWise];
        self.bgLayer.path = [path CGPath];
    }
}

@end
