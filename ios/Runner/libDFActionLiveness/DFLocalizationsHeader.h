//
//  DFLocalizationsHeader.h
//  DFActionLiveness
//
//

#ifndef LocalizationsHeader_h
#define LocalizationsHeader_h

#define DFLivenessDocTitle @"SDK集成文档"

#define DFLivenessTitle @"动作活体检测"
#define DFLivenessAntiReusltPass @"活体检测通过"
#define DFLivenessAntiReusltUnpass @"活体检测未通过"
#define DFLivenessConfirm @"确认"
#define DFLivenessCancel @"取消"
#define DFLivenessTryAgain @"再试一次"

#define DFLivenessDetectionErrorTipLight @"光线充足"
#define DFLivenessDetectionErrorTipGlasses @"请取下眼镜"
#define DFLivenessDetectionErrorTipTime @"放缓速度"

#define DFLivenessTipInitFaild @"算法SDK初始化失败：可能是授权文件或模型路径错误，SDK权限过期，包名绑定错误"
#define DFLivenessTipCameraError @"相机权限获取失败或权限被拒绝"
#define DFLivenessTipFaceChanged @"未检测到人脸，请重试"
#define DFLivenessTipTimeOut @"动作超时"
#define DFLivenessTipWillResignActive @"活体检测失败, 请保持前台运行,点击确定重试"
#define DFLivenessTipInternalError @"内部错误"
#define DFLivenessTipBadJson @"bad json"
#define DFLivenessTipBundleIDError @"程序包名和license绑定包名不符，请使用正确的license文件"
#define DFLivenessTipSequenceError @"动作序列错误(以静默开始且只有一个静默动作)"
#define DFLivenessTipAuthExpire @"设备时间不在license有效期内，请使用有效的license文件"
#define DFLivenessTipLicenseInvalid @"授权文件不合法或为空"

#define DFLivenessTipFaceMoreThanOneError @"多张人脸, 请重试"
#define DFLivenessDetectionTipYaw @"请摇摇头"
#define DFLivenessDetectionTipBlink @"请眨眨眼"
#define DFLivenessDetectionTipMouth @"请张张嘴"
#define DFLivenessDetectionTipNod @"请点点头"
#define DFLivenessDetectionTipHoldStill @"请保持静止"

#define DFLiveFaceRectStatusTipSuccess @"请保持静止"
#define DFLiveFaceRectStatusTipFaceCountMoreThanOne @"请保持单个人脸在圈内"
#define DFLiveFaceRectStatusTipFaceTooLarge @"请离远一点点"
#define DFLiveFaceRectStatusTipNoFace @"请将人脸置于圈中"

#define DFAntihackStatusTip_INVALID_ARGUMENT @"请求参数错误"
#define DFAntihackStatusTip_DETETION_FAILED @"图片检测失败"
#define DFAntihackStatusTip_DOWNLOAD_ERROR @"网络地址图片获取失败"
#define DFAntihackStatusTip_UNAUTHORIZED @"未授权或授权失败"
#define DFAntihackStatusTip_KEY_EXPIRED @"账号过期"
#define DFAntihackStatusTip_NO_PERMISSION @"无调用权限"
#define DFAntihackStatusTip_OUT_OF_QUOTA @"调用次数超出限额"
#define DFAntihackStatusTip_RATE_LIMIT_EXCEEDED @"调用频率超出限额"
#define DFAntihackStatusTip_NOT_FOUND @"请求路径错误"
#define DFAntihackStatusTip_INTERNAL_ERROR @"服务器内部错误"
#define DFAntihackStatusTip_NO_NETWORK @"无网络"
#define DFAntihackStatusTip_UNKNOWN @"未知错误"

#endif /* DFLocalizationsHeader_h */
