
//  DFActionfaceViewController.m
//
//

#import "DFActionfaceViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreImage/CoreImage.h>
#import "DFActionLivenessDetector.h"
#import "DFLivenessCommon.h"
#import "DFCircleView.h"
#import "YFGIFImageView.h"
//#import "DFLocalizationsHeader.h"
#import "NSBundle+Localization.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface DFActionfaceViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, DFActionLivenessDetectorDelegate>

{
    int _indexOfCase;
    BOOL _bSingleCore;
    int _iFramesCount;
    NSArray *_arrDetection;
}


@property (nonatomic , strong) UIView *preview;
@property (nonatomic, strong) UIView *tipFaceView;
@property (nonatomic , strong) YFGIFImageView *imageAnimationView;

@property (nonatomic , strong) UILabel *lblPrompt;
@property (nonatomic, strong) UIButton *btnBack;

@property (nonatomic , assign) float fCurrentPlayerVolume;

@property (nonatomic , strong) AVCaptureSession *session;

@property (nonatomic) dispatch_queue_t queueBuffer;
@property (nonatomic , strong) AVCaptureDevice *deviceFront;

@property (nonatomic , strong) UIView *stepBackGroundView;
@property (nonatomic , strong) UILabel *lblProcessing;

@property (nonatomic , strong) AVCaptureDeviceInput * deviceInput;
@property (nonatomic , strong) AVCaptureVideoDataOutput * dataOutput;

@property (nonatomic , weak) id <DFActionLivenessDetectorDelegate>delegate;

@property (nonatomic , strong) DFActionLivenessDetector *detector;

@property (nonatomic) dispatch_queue_t callBackQueue;

@property (nonatomic , copy) NSString *strBundlePath;

@property (nonatomic , assign) BOOL bShowCountDownView;

@property (nonatomic , strong) DFCircleView *circleView;

@property (nonatomic , assign) float fMaxDuration;

@property (nonatomic , strong) AVAudioPlayer *blinkAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *mouthAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *nodAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *yawAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *holdstillAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *nofaceAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *toocloseAudioPlayer;
@property (nonatomic , strong) AVAudioPlayer *currentAudioPlayer;

@end

@implementation DFActionfaceViewController

- (void)dealloc
{
    if (self.session) {
        [self.session beginConfiguration];
        [self.session removeOutput:self.dataOutput];
        [self.session removeInput:self.deviceInput];
        [self.session commitConfiguration];
        
        if ([self.session isRunning]) {
            [self.session stopRunning];
        }
        self.session = nil;
    }
    
    if ([self.imageAnimationView isGIFPlaying]) {
        [self.imageAnimationView stopGIF];
    }
    
    if ([self.currentAudioPlayer isPlaying]) {
        [self.currentAudioPlayer stop];
    }
}

#pragma - mark Life Cycle

- (instancetype)initWithDuration:(double)fDuration
             resourcesBundlePath:(NSString *)strBundlePath
                     licensePath:(NSString *)strLicensePath
{
    if (self = [super init]) {
        if (!strBundlePath || [strBundlePath isEqualToString:@""] || ![[NSFileManager defaultManager] fileExistsAtPath:strBundlePath]) {
            NSLog(@" ╔————————————————————————— WARNING ————————————————————————╗");
            NSLog(@" |                                                          |");
            NSLog(@" |  Please add df_liveness_resource.bundle to your project !|");
            NSLog(@" |                                                          |");
            NSLog(@" ╚——————————————————————————————————————————————————————————╝");
            return nil;
        }
        self.detector = [[DFActionLivenessDetector alloc] initWithDuration:fDuration
                                                 resourcesBundlePath:strBundlePath
                                                         licensePath:strLicensePath];
        self.bShowCountDownView = fDuration > 0;
        self.fMaxDuration = fDuration;
        self.strBundlePath = strBundlePath;
        self.fCurrentPlayerVolume = 0.8;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _bSingleCore = ([NSProcessInfo processInfo].processorCount == 1);
    self.callBackQueue = dispatch_queue_create("UNIVERSAL_CALL_BACK_QUEUE", NULL);
    
    [self setupUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupFaceDetectedReionAndFaceSizeRatio];
    [self setupAudio];
    BOOL bSetupCaptureSession = [self setupCaptureSession];
    if (!bSetupCaptureSession) {
        return;
    }
    if (![self.session isRunning] ) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.session startRunning];
        });
        
    }
}

#pragma mark - Common set

- (void)setupUI
{
    self.lblPrompt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDFScreenWidth, 38.0)];
    self.lblPrompt.font = [UIFont systemFontOfSize:18];
    self.lblPrompt.textAlignment = NSTextAlignmentCenter;
    self.lblPrompt.textColor = [UIColor blackColor];
    [self.view addSubview:self.lblPrompt];

    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(20, 40, 11, 20)];
    [btnBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    self.btnBack = btnBack;

    self.lblPrompt.center = CGPointMake(kDFScreenWidth / 2.0, btnBack.center.y);

    CGFloat fAnimationViewWidth = 100.0;
    CGFloat fAnimationViewY = self.lblPrompt.frame.origin.y + self.lblPrompt.frame.size.height + 28;

    self.imageAnimationView = [[YFGIFImageView alloc] initWithFrame:CGRectMake((kDFScreenWidth - fAnimationViewWidth) / 2.0, fAnimationViewY, fAnimationViewWidth, fAnimationViewWidth)];
    self.imageAnimationView.layer.masksToBounds = YES;
    self.imageAnimationView.layer.cornerRadius = self.imageAnimationView.frame.size.width / 2;
    self.imageAnimationView.repeatMaxCount = 999;
    self.imageAnimationView.shouldShowLastFrame = YES;
    self.imageAnimationView.restart = YES;

    [self.view addSubview:self.imageAnimationView];

    CGRect circleFrame = CGRectMake(0, 0, self.imageAnimationView.frame.size.width + 10.0, self.imageAnimationView.frame.size.height + 10.0);
    self.circleView = [[DFCircleView alloc] initWithFrame:circleFrame
                                                bodyWidth:5
                                                bodyColor:[self colorWithHexString:@"00FF8F"]
                                                     font:[UIFont boldSystemFontOfSize:28]
                                                textColor:[UIColor whiteColor]
                                                MaxNumber:self.fMaxDuration];
    self.circleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.circleView.center = self.imageAnimationView.center;
    self.circleView.hidden = YES;
    [self.view addSubview:self.circleView];

    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.8;
    CGFloat height = width;
    self.preview = [[UIView alloc] initWithFrame:CGRectMake((kDFScreenWidth - width) / 2.0, fAnimationViewY + fAnimationViewWidth + 30, width, height)];
    self.preview.layer.cornerRadius = width / 2.0;
    self.preview.layer.masksToBounds = YES;
    [self.view addSubview:self.preview];

    CGRect tipFaceFrame = CGRectMake(0, 0, self.preview.frame.size.width + 10.0, self.preview.frame.size.height + 10.0);
    UIView *tipFaceView = [[UIView alloc] initWithFrame:tipFaceFrame];
    tipFaceView.backgroundColor = [self colorWithHexString:@"FF0000"];
    tipFaceView.layer.cornerRadius = tipFaceFrame.size.width / 2.0;
    tipFaceView.layer.masksToBounds = YES;
    tipFaceView.center = self.preview.center;
    [self.view insertSubview:tipFaceView belowSubview:self.preview];
    self.tipFaceView = tipFaceView;

    CGFloat buttonWidth = 6.0;
    CGFloat buttonMargin = 9.0;
    self.stepBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _arrDetection.count * buttonWidth + (_arrDetection.count - 1) * buttonMargin, buttonWidth)];
    self.stepBackGroundView.center = CGPointMake(kDFScreenWidth / 2.0, kDFScreenHeight - 26.0);
    self.stepBackGroundView.userInteractionEnabled = NO;
    [self.view addSubview:self.stepBackGroundView];

    for (int i = 0; i < _arrDetection.count; i ++) {
        UIButton *btnNumber = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnNumber setFrame:CGRectMake(i * (buttonWidth + buttonMargin), 0, buttonWidth, buttonWidth)];
        [btnNumber setImage:[self imageWithFullFileName:@"Oval4.png"] forState:UIControlStateNormal];
        [btnNumber setImage:[self imageWithFullFileName:@"Oval3.png"] forState:UIControlStateHighlighted];
        [self.stepBackGroundView addSubview:btnNumber];
    }
}

- (void)setupAudio
{
    self.fCurrentPlayerVolume = 0.8;
    NSInteger playCount = 0;
    NSString *strAppBunldePath = [[NSBundle mainBundle] pathForResource:@"df_liveness_resource" ofType:@"bundle"];
    NSString *strBlinkPath = DFLOCALIZATIONFILEPATH(@"blink.mp3");
    self.blinkAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strBlinkPath] error:nil];
    self.blinkAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.blinkAudioPlayer.numberOfLoops = playCount;
    [self.blinkAudioPlayer prepareToPlay];
    
    NSString *strMouthPath = DFLOCALIZATIONFILEPATH(@"mouth.mp3");
    self.mouthAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strMouthPath] error:nil];
    self.mouthAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.mouthAudioPlayer.numberOfLoops = playCount;
    [self.mouthAudioPlayer prepareToPlay];
    
    NSString *strNodPath = DFLOCALIZATIONFILEPATH(@"nod.mp3");
    self.nodAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strNodPath] error:nil];
    self.nodAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.nodAudioPlayer.numberOfLoops = playCount;
    [self.nodAudioPlayer prepareToPlay];
    
    NSString *strYawPath = DFLOCALIZATIONFILEPATH(@"yaw.mp3");
    self.yawAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strYawPath] error:nil];
    self.yawAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.yawAudioPlayer.numberOfLoops = playCount;
    [self.yawAudioPlayer prepareToPlay];
    
    NSString *strHoldstillPath = DFLOCALIZATIONFILEPATH(@"holdstill.mp3");
    self.holdstillAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strHoldstillPath] error:nil];
    self.holdstillAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.holdstillAudioPlayer.numberOfLoops = playCount;
    [self.holdstillAudioPlayer prepareToPlay];
    
    NSString *strNofacePath = DFLOCALIZATIONFILEPATH(@"noface.mp3");
    self.nofaceAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strNofacePath] error:nil];
    self.nofaceAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.nofaceAudioPlayer.numberOfLoops = playCount;
    [self.nofaceAudioPlayer prepareToPlay];
    
    NSString *strTooclosePath = DFLOCALIZATIONFILEPATH(@"tooclose.mp3");
    self.toocloseAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strTooclosePath] error:nil];
    self.toocloseAudioPlayer.volume = self.fCurrentPlayerVolume;
    self.toocloseAudioPlayer.numberOfLoops = playCount;
    [self.toocloseAudioPlayer prepareToPlay];
}

- (BOOL)setupCaptureSession
{
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    captureVideoPreviewLayer.frame = CGRectMake(0, 0, self.preview.frame.size.width, self.preview.frame.size.height);
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview.layer addSublayer:captureVideoPreviewLayer];
    
    NSArray *devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *device in devices) {
        if ([device hasMediaType:AVMediaTypeVideo]) {
            if ([device position] == AVCaptureDevicePositionFront) {
                self.deviceFront = device;
            }
        }
    }
    
    int frameRate;
    CMTime frameDuration = kCMTimeInvalid;
    
    // For single core systems like iPhone 4 and iPod Touch 4th Generation we use a lower resolution and framerate to maintain real-time performance.
    frameRate = _bSingleCore ? 15 : 30;
    frameDuration = CMTimeMake( 1, frameRate );
    
    NSError *error = nil;
    if ( [self.deviceFront lockForConfiguration:&error] ) {
        self.deviceFront.activeVideoMaxFrameDuration = frameDuration;
        self.deviceFront.activeVideoMinFrameDuration = frameDuration;
        [self.deviceFront unlockForConfiguration];
    }
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.deviceFront error:&error];
    self.deviceInput = input;
    if (!input) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(livenessDidFailWithErrorType:detectionType:detectionIndex:data:dfImages:dfVideoData:)]) {
            dispatch_async(_callBackQueue, ^{
                [self.delegate livenessDidFailWithErrorType:LIVENESS_CAMERA_ERROR detectionType:[[_arrDetection firstObject] integerValue] detectionIndex:0 data:nil dfImages:nil dfVideoData:nil];
            });
        }
        return NO;
    }
    self.dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.dataOutput setAlwaysDiscardsLateVideoFrames:YES];
    [self.dataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    
    [self.session beginConfiguration];
    
    if ([self.session canAddOutput:self.dataOutput]) {
        [self.session addOutput:self.dataOutput];
    }
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    [self.session commitConfiguration];
    
    return YES;
}

- (UIImage *)imageWithFullFileName:(NSString *)strFileName{
    NSString *strAppBunldePath = [[NSBundle mainBundle] pathForResource:@"df_liveness_resource" ofType:@"bundle"];
    NSString *strFilePath = [NSString pathWithComponents:@[strAppBunldePath , @"images" , strFileName]];
    return [UIImage imageWithContentsOfFile:strFilePath];
}

- (void)setupFaceDetectedReionAndFaceSizeRatio
{
    [self.detector setFaceDetectedRegion:self.preview.frame faceMaxSizeRatio:0.7];
}

#pragma - mark Actions

- (void)onBtnStartDetect
{
    [self startDetection];
}

- (void)startDetection
{
    if (self.session && self.detector) {
        if (![self.session isRunning] ) {
            [self.session startRunning];
        }
        [self.detector startDetection];
        [self livenessDectectingFaceCount:0 faceRectStatus:LivefaceRectStatusNone detectionType:[[_arrDetection firstObject] integerValue]];
        if (self.dataOutput.sampleBufferDelegate == nil) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.dataOutput setSampleBufferDelegate:self queue:dispatch_queue_create("LIVENESS_BUFFER_QUEUE", NULL)];
            });
        }
    }
}

- (void)cancelDetection
{
    if (self.detector) {
        [self.detector cancelDetection];
    }
}

- (void)btnBackTapped:(id)sender
{
    [self cancelDetection];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)displayViewsIfRunning:(BOOL)bRunning detectionType:(LivefaceDetectionType)iDetectionType
{
    self.imageAnimationView.hidden = !bRunning;
    self.stepBackGroundView.hidden = !bRunning;
    if (iDetectionType == LIVE_HOLDSTILL) {
        self.circleView.hidden = YES;
    } else {
        self.circleView.hidden = self.bShowCountDownView ? !bRunning : YES;
    }
}

- (void)resetButtonAndAudioStatus
{
    for (UIButton *btnNumber in self.stepBackGroundView.subviews) {
        [btnNumber setHighlighted:NO];
    }
    if (self.currentAudioPlayer) {
        [self stopAudioPlayer];
        self.currentAudioPlayer = nil;
    }
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
    self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessTitle");
}

#pragma - mark AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (self.detector) {
        [self.detector trackAndDetectWithCMSampleBuffer:sampleBuffer faceOrientation:LIVE_FACE_LEFT];
    }
}

#pragma - mark Public Methods

- (void)setDelegate:(id<DFActionLivenessDetectorDelegate>)delegate callBackQueue:(dispatch_queue_t)queue detectionSequence:(NSArray *)arrDetection detectionThreshold:(NSArray *)arrThreshold
{
    if (!arrDetection.count) {
        NSLog(@" ╔———————————— WARNING ————————————╗");
        NSLog(@" |                                 |");
        NSLog(@" |  Please set detection sequence !|");
        NSLog(@" |                                 |");
        NSLog(@" ╚—————————————————————————————————╝");
    } else {
        [self.detector setDelegate:self
                     callBackQueue:queue
                 detectionSequence:arrDetection detectionThreshold:arrThreshold];
        
        _arrDetection = [arrDetection mutableCopy];
    }
    
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
    
    if (_callBackQueue != queue) {
        _callBackQueue = queue;
    }
}

+ (NSString *)getSDKVersion
{
    return [DFActionLivenessDetector getSDKVersion];
}

#pragma - mark Private Methods

- (void)setOutputType:(LivefaceOutputType)iOutputType
{
    if (self.detector) {
        [self.detector setOutputType:iOutputType];
    }
}

- (void)showPromptTextWithType:(LivefaceDetectionType)type detectionIndex:(int)iIndex
{
    UIButton *btnNumber = [self.stepBackGroundView.subviews objectAtIndex:iIndex];
    [btnNumber setHighlighted:YES];
    
    if ([self.imageAnimationView isGIFPlaying]) {
        [self.imageAnimationView stopGIF];
    }
    self.imageAnimationView.gifData = [self gifDataWithDetectionType:type];
    if (![self.imageAnimationView isGIFPlaying]) {
        [self.imageAnimationView startGIF];
    }
}

- (NSData *)gifDataWithDetectionType:(NSInteger)type
{
    NSString *gifImageName = @"";
    switch (type) {
            case LIVE_YAW: {
                gifImageName = @"yaotou.gif";
                break;
            }
            
            case LIVE_BLINK: {
                gifImageName = @"zhayan.gif";
                break;
            }
            
            case LIVE_MOUTH: {
                gifImageName = @"zhangzui.gif";
                break;
            }
            case LIVE_NOD: {
                gifImageName = @"diantou.gif";
                break;
            }
            case LIVE_HOLDSTILL: {
                gifImageName = @"jingzhi.gif";
                break;
            }
    }
    
    NSString *strBundlePath = [[NSBundle mainBundle] pathForResource:@"df_liveness_resource" ofType:@"bundle"];
    NSData *gifData = [NSData dataWithContentsOfFile:[NSString pathWithComponents:@[strBundlePath , @"images" , gifImageName]]];
    return gifData;
}

- (void)stopAudioPlayer
{
    if (self.currentAudioPlayer != nil && [self.currentAudioPlayer isPlaying]) {
        [self.currentAudioPlayer stop];
    }
        [NSObject cancelPreviousPerformRequestsWithTarget:self.currentAudioPlayer selector:@selector(play) object:nil];
    self.currentAudioPlayer.currentTime = 0;
}

#pragma - mark DFActionLivenessDetectorDelegate

- (void)livenessDidStartDetectionWithDetectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex
{
    [self showPromptTextWithType:iDetectionType detectionIndex:iDetectionIndex];
    [self displayViewsIfRunning:YES detectionType:iDetectionType];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(livenessDidStartDetectionWithDetectionType:detectionIndex:)]) {
        dispatch_async(_callBackQueue, ^{
            [self.delegate livenessDidStartDetectionWithDetectionType:iDetectionType detectionIndex:iDetectionType];
        });
    }
}

- (void)videoFrameRate:(int)rate
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoFrameRate:)]) {
        dispatch_async(_callBackQueue, ^{
            [self.delegate videoFrameRate:rate];
        });
    }
}

- (void)livenessDectectingFaceCount:(int)faceCount faceRectStatus:(LivefaceRectStatus)faceRectStatus detectionType:(LivefaceDetectionType)iDetectionType
{
    AVAudioPlayer *tmpAudioPlayer = nil;
    if (faceRectStatus == LivefaceRectStatusSuccess) {
        self.tipFaceView.backgroundColor = [self colorWithHexString:@"00FF8F"];
        self.lblPrompt.text = DFLOCALIZATION(@"DFLiveFaceRectStatusTipSuccess");
        switch ((NSInteger)iDetectionType) {
            case LIVE_YAW: {
                self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessDetectionTipYaw");
                tmpAudioPlayer = self.yawAudioPlayer;
                break;
            }
                
            case LIVE_BLINK: {
                self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessDetectionTipBlink");
                tmpAudioPlayer = self.blinkAudioPlayer;
                break;
            }
                
            case LIVE_MOUTH: {
                self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessDetectionTipMouth");
                tmpAudioPlayer = self.mouthAudioPlayer;
                break;
            }
            case LIVE_NOD: {
                self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessDetectionTipNod");
                tmpAudioPlayer = self.nodAudioPlayer;
                break;
            }
            case LIVE_HOLDSTILL: {
                self.lblPrompt.text = DFLOCALIZATION(@"DFLivenessDetectionTipHoldStill");
                tmpAudioPlayer = self.holdstillAudioPlayer;
                break;
            }
        }
    } else if (faceRectStatus == LivefaceRectStatusMoreThanOne) {
        self.tipFaceView.backgroundColor = [self colorWithHexString:@"FF0000"];
        self.lblPrompt.text = DFLOCALIZATION(@"DFLiveFaceRectStatusTipFaceCountMoreThanOne");
    } else if (faceRectStatus == LivefaceRectStatusLarge) {
        self.tipFaceView.backgroundColor = [self colorWithHexString:@"FF0000"];
        self.lblPrompt.text = DFLOCALIZATION(@"DFLiveFaceRectStatusTipFaceTooLarge");
        tmpAudioPlayer = self.toocloseAudioPlayer;
    } else {
        self.tipFaceView.backgroundColor = [self colorWithHexString:@"FF0000"];
        self.lblPrompt.text = DFLOCALIZATION(@"DFLiveFaceRectStatusTipNoFace");
        tmpAudioPlayer = self.nofaceAudioPlayer;
    }
    if (tmpAudioPlayer != self.currentAudioPlayer) {
        [self stopAudioPlayer];
        self.currentAudioPlayer = tmpAudioPlayer;
        [self.currentAudioPlayer play];
    } else {
        if (![self.currentAudioPlayer isPlaying]) {
            [self.currentAudioPlayer performSelector:@selector(play) withObject:nil afterDelay:1];
        }
    }
}

- (void)livenessTimeDidPast:(double)dPast durationPerModel:(double)dDurationPerModel
{
    if (dDurationPerModel != 0) {
        self.circleView.fAnglePercent = (dPast / dDurationPerModel);
        if (self.delegate && [self.delegate respondsToSelector:@selector(livenessTimeDidPast:durationPerModel:)]) {
            dispatch_async(_callBackQueue, ^{
                [self.delegate livenessTimeDidPast:dPast durationPerModel:dDurationPerModel];
            });
        }
    }
}

- (void)livenessDidSuccessfulGetData:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData
{
    [self resetButtonAndAudioStatus];
    [self displayViewsIfRunning:NO detectionType:-1];
    if (self.delegate && [self.delegate respondsToSelector:@selector(livenessDidSuccessfulGetData:dfImages:dfVideoData:)]) {
        dispatch_async(_callBackQueue, ^{
            [self.delegate livenessDidSuccessfulGetData:data dfImages:arrDFImage dfVideoData:dfVideoData];
        });
    }
}

- (void)livenessDidFailWithErrorType:(LivefaceErrorType)iErrorType detectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex data:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData
{
    [self resetButtonAndAudioStatus];
    [self displayViewsIfRunning:NO detectionType:iDetectionType];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(livenessDidFailWithErrorType:detectionType:detectionIndex:data:dfImages:dfVideoData:)]) {
        dispatch_async(_callBackQueue, ^{
            [self.delegate livenessDidFailWithErrorType:iErrorType detectionType:iDetectionType detectionIndex:iDetectionIndex data:data dfImages:arrDFImage dfVideoData:dfVideoData];
        });
    }
}

- (void)livenessDidCancelWithDetectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex
{
    [self resetButtonAndAudioStatus];
    [self displayViewsIfRunning:NO detectionType:iDetectionType];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(livenessDidCancelWithDetectionType:detectionIndex:)]) {
        dispatch_async(_callBackQueue, ^{
            [self.delegate livenessDidCancelWithDetectionType:iDetectionType detectionIndex:iDetectionIndex];
        });
    }
}

# pragma mark - Funchtion Methods

- (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
            case 3: {// #RGB
                alpha = 1.0f;
                red   = [self colorComponentFrom: colorString start: 0 length: 1];
                green = [self colorComponentFrom: colorString start: 1 length: 1];
                blue  = [self colorComponentFrom: colorString start: 2 length: 1];
                break;
            }
            case 4: {// #ARGB
                alpha = [self colorComponentFrom: colorString start: 0 length: 1];
                red   = [self colorComponentFrom: colorString start: 1 length: 1];
                green = [self colorComponentFrom: colorString start: 2 length: 1];
                blue  = [self colorComponentFrom: colorString start: 3 length: 1];
                break;
            }
            case 6: {// #RRGGBB
                alpha = 1.0f;
                red   = [self colorComponentFrom: colorString start: 0 length: 2];
                green = [self colorComponentFrom: colorString start: 2 length: 2];
                blue  = [self colorComponentFrom: colorString start: 4 length: 2];
                break;
            }
            case 8: {// #AARRGGBB
                alpha = [self colorComponentFrom: colorString start: 0 length: 2];
                red   = [self colorComponentFrom: colorString start: 2 length: 2];
                green = [self colorComponentFrom: colorString start: 4 length: 2];
                blue  = [self colorComponentFrom: colorString start: 6 length: 2];
                break;
            }
        default: {
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
        }
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

@end
