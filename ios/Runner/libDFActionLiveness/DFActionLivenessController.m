//
//  DFMultipleLivenessController.m
//
//

#import "DFActionLivenessController.h"
#import "DFActionfaceViewController.h"
#import "NSObject+DFAccess.h"
//#import "DFLocalizationsHeader.h"
#import "NSBundle+Localization.h"
#import "Runner-Swift.h"

#define kBoundary @"----DFUploadProtobufFileForAntiHack"

@interface DFActionLivenessController () <DFActionLivenessDetectorDelegate>
{
    NSString *_strJsonCommand;
}

@property (nonatomic , assign) LivefaceOutputType iOutputType;

@property (nonatomic , strong) DFActionfaceViewController *livefaceVC;

@property (nonatomic , assign) BOOL bVoicePromptOn;

@property (nonatomic, copy) NSString *strBundlePath;

@property (nonatomic, assign) BOOL autoAntiHack;

@property (nonatomic, strong) UIView *loadingBgView;

@property (nonatomic, strong) UIImageView *loadingView;

@end

@implementation DFActionLivenessController

- (void)dealloc
{
    [self.livefaceVC removeFromParentViewController];
    self.livefaceVC = nil;
}

#pragma mark - Init

- (instancetype)init
{
    if (self = [super init]) {
        self.bVoicePromptOn = YES;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(224.0 / 255.0) green:(101.0 / 255.0) blue:(44.0 / 255.0) alpha:1];
    
    if (!self.livefaceVC || !_strJsonCommand) {
        [self callBackWithBadJsonError];
        return;
    }
    
    [self addChildViewController:self.livefaceVC];
    [self.view addSubview:self.livefaceVC.view];
}

#pragma mark - Public Methods

- (BOOL)setJsonCommand:(NSString *)strJsonCommand
{
    _strJsonCommand = strJsonCommand;
    _strBundlePath = [[NSBundle mainBundle] pathForResource:@"df_liveness_resource" ofType:@"bundle"];
    
    NSError *error = nil;
    NSDictionary *dicJson = [NSJSONSerialization JSONObjectWithData:[_strJsonCommand dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return NO;
    }
    
    DFActionfaceViewController *liveVC = [self createControllerWithJsonDic:dicJson];
    
    if (!liveVC) {
        return NO;
    }
    self.livefaceVC = liveVC;
    return YES;
}

- (void)cancel
{
    if (!self.childViewControllers.firstObject && self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidCancel)]) {
        [self.delegate actionLivenessDidCancel];
    }
    [(DFActionfaceViewController *)self.childViewControllers.firstObject cancelDetection];
}

- (void)restart
{
    [(DFActionfaceViewController *)self.childViewControllers.firstObject startDetection];
}

- (NSString *)getLivenessVersion
{
    return [DFActionfaceViewController getSDKVersion];
}

- (void)setVoicePromptOn:(BOOL)bVoicePrompt
{
    self.bVoicePromptOn = bVoicePrompt;
    if (self.livefaceVC) {
    }
}

#pragma mark - Private Methods

- (void)selectPlanWithJsonCommand:(NSString *)strJsonCommand
{
    NSError *error = nil;
    NSDictionary *dicJson = [NSJSONSerialization JSONObjectWithData:[strJsonCommand dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        [self callBackWithBadJsonError];
        return;
    }
    
    UIViewController *targetViewController = [self createControllerWithJsonDic:dicJson];
    
    if (!targetViewController) {
        [self callBackWithBadJsonError];
        return;
    }
    [self.livefaceVC.view removeFromSuperview];
    [self.livefaceVC removeFromParentViewController];
    
    [self addChildViewController:targetViewController];
    UIViewController *currentVC = self.livefaceVC;
    
    [self transitionFromViewController:currentVC toViewController:targetViewController duration:0 options:UIViewAnimationOptionTransitionNone animations:NULL completion:NULL];
    [currentVC removeFromParentViewController];
}

- (void)callBackWithBadJsonError
{
    if (!_strBundlePath || [_strBundlePath isEqualToString:@""] || ![[NSFileManager defaultManager] fileExistsAtPath:_strBundlePath]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidFailWithType:DetectionType:DetectionIndex:Data:dfImages:dfVideoData:)]) {
            [self.delegate actionLivenessDidFailWithType:DFActionLivenessInitFaild DetectionType:DFDETECTION_NONE DetectionIndex:0 Data:nil dfImages:nil dfVideoData:nil];
        }
    } else if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidFailWithType:DetectionType:DetectionIndex:Data:dfImages:dfVideoData:)]) {
        [self.delegate actionLivenessDidFailWithType:DFActionLivenessBadJson
                                        DetectionType:DFDETECTION_NONE
                                       DetectionIndex:0
                                                 Data:nil
                                             dfImages:nil
                                          dfVideoData:nil];
    }
}

- (LivefaceOutputType)getPlanInfoWithJsonDic:(NSDictionary *)dicJson
{
    NSString *strPlan = [dicJson objectNotNullForKey:@"plan"];
    if (!strPlan) {
        return 0;
    }
    LivefaceOutputType iOutput = 0;
    NSString *strOutType = [dicJson objectNotNullForKey:@"outType"];
    
    if (!strOutType) {
        return -1;
    }
    
    if ([strOutType isEqualToString:@"multiImg"]) {
        iOutput = LIVE_OUTPUT_MULTI_IMAGE;
    } else if ([strOutType isEqualToString:@"video"]) {
        iOutput = LIVE_OUTPUT_VIDEO;
    } else {
        return -1;
    }
    return iOutput;
}

- (DFActionfaceViewController *)createControllerWithJsonDic:(NSDictionary *)dicJson
{
    NSString *strOutType = [dicJson objectNotNullForKey:@"outType"];
    
    if (!strOutType) {
        return nil;
    }
    NSString *licPath = [[NSBundle mainBundle] pathForResource:@"DFLicense" ofType:@""];
    if (licPath == nil) {
        licPath = [[NSBundle mainBundle] pathForResource:@"Deepfinch" ofType:@"lic"];
    }
    if (licPath == nil) {
        licPath = [[NSBundle mainBundle] pathForResource:@"DeepFinch" ofType:@"lic"];
    }
    DFActionfaceViewController *livefaceVC = [[DFActionfaceViewController alloc] initWithDuration:10.0f
                                                                          resourcesBundlePath:_strBundlePath
                                                                                  licensePath:licPath];
    
    LivefaceOutputType iOutputType = 0;
    
    if ([strOutType isEqualToString:@"multiImg"]) {
        
        iOutputType = LIVE_OUTPUT_MULTI_IMAGE;
    } else if ([strOutType isEqualToString:@"video"]) {
        
        iOutputType = LIVE_OUTPUT_VIDEO;
    } else {
        return nil;
    }
    
    NSArray *arrOptions = [dicJson objectNotNullForKey:@"sequence"];
    NSArray *arrThreshold = [dicJson objectNotNullForKey:@"threshold"];
    
    BOOL autoAntiHack = YES;
    if ([dicJson objectNotNullForKey:@"autoAntiHack"] != nil) {
        autoAntiHack = [[dicJson objectNotNullForKey:@"autoAntiHack"] boolValue];
    }
    self.autoAntiHack = autoAntiHack;
    
    if (!arrOptions || !arrThreshold || (arrOptions.count != arrThreshold.count)) {
        return nil;
    }
    
    NSMutableArray *arrDetectionType = [NSMutableArray array];
    
    for (NSString *strMotion in arrOptions) {
        LivefaceDetectionType iDetectionType = LIVE_BLINK;
        if ([[strMotion uppercaseString] isEqualToString:@"HOLDSTILL"]){
            iDetectionType = LIVE_HOLDSTILL;
        } else if ([[strMotion uppercaseString] isEqualToString:@"BLINK"]) {
            iDetectionType = LIVE_BLINK;
        } else if ([[strMotion uppercaseString] isEqualToString:@"NOD"]) {
            iDetectionType = LIVE_NOD;
        } else if ([[strMotion uppercaseString] isEqualToString:@"MOUTH"]) {
            iDetectionType = LIVE_MOUTH;
        } else if ([[strMotion uppercaseString] isEqualToString:@"YAW"]) {
            iDetectionType = LIVE_YAW;
        } else {
            return nil;
        }
        [arrDetectionType addObject:@(iDetectionType)];
    }
    
    [livefaceVC setDelegate:self callBackQueue:dispatch_get_main_queue() detectionSequence:arrDetectionType detectionThreshold:arrThreshold];
    [livefaceVC setOutputType:iOutputType];
    
    return livefaceVC;
}

#pragma - mark DFActionLivenessDetectorDelegate

- (void)livenessDidStartDetectionWithDetectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidStart)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate actionLivenessDidStart];
        });
    }
}

- (void)livenessTimeDidPast:(double)dPast durationPerModel:(double)dDurationPerModel
{
    
}

- (void)videoFrameRate:(int)rate
{
    
//    printf("%d FPS\n",rate);
}

- (void)livenessDidSuccessfulGetData:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData
{
    if (self.autoAntiHack) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self antihackWithData:data dfImages:arrDFImage dfVideoData:dfVideoData];
        });
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidSuccessfulGetData:dfImages:dfVideoData:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate actionLivenessDidSuccessfulGetData:data dfImages:arrDFImage dfVideoData:dfVideoData];
            });
        }
    }
}


- (void)livenessDidFailWithErrorType:(LivefaceErrorType)iErrorType detectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex data:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData
{
    DFActionLivenessError iDFMultipleError = 0;
    switch (iErrorType) {
        case LIVENESS_INIT_FAILD:
        {
            iDFMultipleError = DFActionLivenessInitFaild;
        }
            break;
            
        case LIVENESS_CAMERA_ERROR:
        {
            iDFMultipleError = DFActionLivenessCameraError;
        }
            break;
            
        case LIVENESS_FACE_CHANGED:
        {
            iDFMultipleError = DFActionLivenessFaceChanged;
        }
            break;
            
        case LIVENESS_INTERNAL_ERROR:
        {
            iDFMultipleError = DFActionLivenessInternalError;
        }
            break;
            
        case LIVENESS_TIMEOUT:
        {
            iDFMultipleError = DFActionLivenessTimeOut;
        }
            break;
            
            
        case LIVENESS_WILL_RESIGN_ACTIVE:
        {
            iDFMultipleError = DFActionLivenessWillResignActive;
        }
            break;
        case LIVENESS_BUNDLEID_ERROR:
        {
            iDFMultipleError = DFActionLivenessBundleIDError;
        }
            break;
        case LIVENESS_AUTH_EXPIRE:
        {
            iDFMultipleError = DFActionLivenessAuthExpire;
        }
            break;
        case LIVENESS_SEQUENCE_ERROR:
        {
            iDFMultipleError = DFActionLivenessSequenceError;
        }
            break;
        case LIVENESS_FACE_MORE_THAN_ONE_ERROR:
        {
            iDFMultipleError = DFActionLivenessFaceMoreThanOneError;
        }
            break;
        case LIVENESS_LICENSE_INVALID:
        {
            iDFMultipleError = DFActionLivenessLicenseInvalid;
        }
            break;
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidFailWithType:DetectionType:DetectionIndex:Data:dfImages:dfVideoData:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate actionLivenessDidFailWithType:iDFMultipleError DetectionType:iDetectionIndex DetectionIndex:iDetectionIndex Data:data dfImages:arrDFImage dfVideoData:dfVideoData];
        });
    }
}

- (void)livenessDidCancelWithDetectionType:(LivefaceDetectionType)iDetectionType detectionIndex:(int)iDetectionIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidCancel)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate actionLivenessDidCancel];
        });
    }
}

#pragma mark - AntiHack

- (void)antihackWithData:(NSData *)encryptData dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData
{
    [self startAnimation:YES];

    NSDictionary *errorTipDict = @{@"INVALID_ARGUMENT": DFLOCALIZATION(@"DFAntihackStatusTip_INVALID_ARGUMENT"),
                                   @"DETETION_FAILED": DFLOCALIZATION(@"DFAntihackStatusTip_DETETION_FAILED"),
                                   @"DOWNLOAD_ERROR": DFLOCALIZATION(@"DFAntihackStatusTip_DOWNLOAD_ERROR"),
                                   @"UNAUTHORIZED": DFLOCALIZATION(@"DFAntihackStatusTip_UNAUTHORIZED"),
                                   @"KEY_EXPIRED": DFLOCALIZATION(@"DFAntihackStatusTip_KEY_EXPIRED"),
                                   @"NO_PERMISSION": DFLOCALIZATION(@"DFAntihackStatusTip_NO_PERMISSION"),
                                   @"OUT_OF_QUOTA": DFLOCALIZATION(@"DFAntihackStatusTip_OUT_OF_QUOTA"),
                                   @"RATE_LIMIT_EXCEEDED": DFLOCALIZATION(@"DFAntihackStatusTip_RATE_LIMIT_EXCEEDED"),
                                   @"NOT_FOUND": DFLOCALIZATION(@"DFAntihackStatusTip_NOT_FOUND"),
                                   @"INTERNAL_ERROR": DFLOCALIZATION(@"DFAntihackStatusTip_INTERNAL_ERROR")};
    
    
    NSString *host_url = FaceLivenessParams.instance.hostUrl;
    NSString *api_id = FaceLivenessParams.instance.apiId;
    NSString *api_secret = FaceLivenessParams.instance.apiSecret;
        
    NSString *antiHackAddress = @"/face/liveness_anti_hack";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", host_url, antiHackAddress]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    NSMutableData *data = [NSMutableData data];
    [data appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Disposition: form-data; name=\"check_image_quality\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Type: text/plain\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"0" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [data appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Disposition: form-data; name=\"liveness_data_file\"; filename=\"liveness_data_file\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:encryptData];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"--%@--", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];

    request.HTTPBody = data;
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"%zd", data.length]forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary] forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:api_id forHTTPHeaderField:@"X_DF_API_ID"];
    [request setValue:api_secret forHTTPHeaderField:@"X_DF_API_SECRET"];

    __weak typeof(self) weakSelf = self;
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *errorTip = DFLOCALIZATION(@"DFAntihackStatusTip_NO_NETWORK");
        float score = 1.0;
        if (data != nil) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (result != nil) {
                NSString *status = [result objectForKey:@"status"];
                if ([status isEqualToString:@"OK"]) {
                    errorTip = nil;
                    score = [[NSString stringWithFormat:@"%@", [result objectForKey:@"score"]] floatValue];
                } else {
                    if ([errorTipDict objectForKey:status]) {
                        errorTip = errorTipDict[status];
                    }
                }
                
                if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(actionLivenessDidSuccessfulWithScore:dfImages:errorTip:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [weakSelf.delegate actionLivenessDidSuccessfulWithScore:score dfImages:arrDFImage errorTip:errorTip];
                    });
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf handleResultWithAntihackScore:score data:encryptData dfImages:arrDFImage dfVideoData:dfVideoData errorTip:errorTip];
        });
    }];
    [task resume];
}

- (void)handleResultWithAntihackScore:(float)score data:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData errorTip:(NSString *)errortip
{
    [self stopAnimation];
    BOOL isHack = score > 0.98 ? YES : NO;
    __weak typeof(self) weakSelf = self;
    if (errortip != nil) {
        [self toastMessage:errortip completeBloack:^{
            [weakSelf callBackWithData:data dfImages:arrDFImage dfVideoData:dfVideoData isHack:isHack];
        }];
    } else {
        [self callBackWithData:data dfImages:arrDFImage dfVideoData:dfVideoData isHack:isHack];
    }
}

- (void)callBackWithData:(NSData *)data dfImages:(NSArray *)arrDFImage dfVideoData:(NSData *)dfVideoData isHack:(BOOL)isHack
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionLivenessDidSuccessfulGetData:dfImages:dfVideoData:isHack:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate actionLivenessDidSuccessfulGetData:data dfImages:arrDFImage dfVideoData:dfVideoData isHack:isHack];
        });
    }
}

- (void)startAnimation:(BOOL)autoCreate
{
    __weak typeof(self) weakSelf = self;
    
    if (autoCreate && !self.loadingView) {
        [self setupLoadingView];
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            weakSelf.loadingBgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        } completion:nil];
    }
    if (self.loadingView != nil) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            weakSelf.loadingView.transform = CGAffineTransformRotate(weakSelf.loadingView.transform, -M_PI_4);
        } completion:^(BOOL finished) {
            [weakSelf startAnimation:NO];
        }];
    }
}

- (void)stopAnimation
{
    [self.loadingView removeFromSuperview];
    [self.loadingBgView removeFromSuperview];
    self.loadingView = nil;
    self.loadingBgView = nil;
}


#pragma mark - Toast and Loading which can be replaced by your own.

- (void)setupLoadingView
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.livefaceVC.view.frame];
    bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
    bgView.userInteractionEnabled = NO;
    self.loadingBgView = bgView;
    [self.view addSubview:self.loadingBgView];
    
    
    UIImageView *loadingView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0 - 24.0, [UIScreen mainScreen].bounds.size.height / 2.0 - 24.0 - 40, 48, 48)];
    loadingView.image = [UIImage imageWithContentsOfFile:[NSString pathWithComponents:@[self.strBundlePath , @"images" , @"loading_circl.png"]]];
    [self.loadingBgView addSubview:loadingView];
    self.loadingView = loadingView;
}

- (void)toastMessage:(NSString *)message completeBloack:(dispatch_block_t)completeBlock
{
    UIFont *font = [UIFont systemFontOfSize:15];
    NSString *tipText = message;
    CGFloat height = 30;
    NSMutableParagraphStyle* paragrap = [[NSMutableParagraphStyle alloc] init];
    NSDictionary* attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragrap};
    CGRect rect = [tipText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width + height, height)];
    tipLabel.layer.cornerRadius = height / 2.0;
    tipLabel.layer.masksToBounds = YES;
    tipLabel.font = font;
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = tipText;
    tipLabel.backgroundColor = [UIColor blackColor];
    tipLabel.alpha = 0.7;
    tipLabel.center = self.view.center;//CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height - 60);
    [self.view addSubview:tipLabel];
    [UIView animateWithDuration:2.0 animations:^{
        tipLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [tipLabel removeFromSuperview];
        if (completeBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock();
            });
        }
    }];
}

@end
