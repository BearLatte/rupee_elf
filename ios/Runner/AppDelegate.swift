import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let vc = window.rootViewController as! FlutterViewController
        
        // 创建一个接收 flutter 消息的通道
        let methodChanel = FlutterMethodChannel(name: "product_detail/authLiveness", binaryMessenger: vc as! FlutterBinaryMessenger)
        methodChanel.setMethodCallHandler { call, result in
            if call.method == "go2authFace" {
                let params = call.arguments as! [String : String]
                FaceLivenessParams.instance.apiId = params["apiId"] ?? ""
                FaceLivenessParams.instance.apiSecret = params["apiSecret"] ?? ""
                FaceLivenessParams.instance.hostUrl = params["hostUrl"] ?? ""
                self.go2faceLiveness(vc: vc)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private var livenessVC : DFActionfaceViewController!
}

extension AppDelegate {
    // 配置活体控制器
    func go2faceLiveness(vc : UIViewController) {
        // 资源路径
        let sourcePath = Bundle.main.path(forResource: "df_liveness_resource", ofType: "bundle")
        // 授权文件路径
        let licensePath = Bundle.main.path(forResource: "DFLicense", ofType: "")
        
        let arrLivenessSequence  = [0, 1, 2, 3, 4]
        let arrThreshold = [0.7 , 0.7 , 0.7, 0.7 , 0.7]

        // 创建控制器
        guard let liveness = DFActionfaceViewController(duration: 10.0, resourcesBundlePath: sourcePath, licensePath: licensePath) else {return}
        livenessVC = liveness
        
        livenessVC.setDelegate(self, callBack: DispatchQueue.main, detectionSequence: [], detectionThreshold: arrThreshold)
        
        livenessVC.setOutputType(.LIVE_OUTPUT_MULTI_IMAGE)
        
        livenessVC.view.backgroundColor = UIColor(red: 224.0 / 255.0, green: 101.0 / 255.0, blue: 44.0 / 255.0, alpha: 1)
        
      
        let nav = UINavigationController(rootViewController: livenessVC)
        nav.modalPresentationStyle = .fullScreen
        
        vc.present(nav, animated: true) {
            self.livenessVC.startDetection()
        }
    }
    
    @objc func backBtnAction() {
        livenessVC.dismiss(animated: true)
    }
}

extension AppDelegate: DFActionLivenessDetectorDelegate {
    func livenessDidStartDetection(with iDetectionType: LivefaceDetectionType, detectionIndex iDetectionIndex: Int32) {
        print("DEBUG: 开始活体检测")
    }
    func livenessDidSuccessfulGet(_ data: Data?, dfImages arrDFImage: [Any]?, dfVideoData: Data?) {
    }
    
    func livenessDidFailWith(_ iErrorType: LivefaceErrorType, detectionType iDetectionType: LivefaceDetectionType, detectionIndex iDetectionIndex: Int32, data: Data?, dfImages arrDFImage: [Any]?, dfVideoData: Data?) {
    }
    
    func livenessDidCancel(with iDetectionType: LivefaceDetectionType, detectionIndex iDetectionIndex: Int32) {
    }
    

}
