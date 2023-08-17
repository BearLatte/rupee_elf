import UIKit
import Flutter
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        currentController = window.rootViewController as? FlutterViewController
        
        // 创建一个接收 flutter 消息的通道
        methodChanel = FlutterMethodChannel(name: "com.product.detail.MethodChanel", binaryMessenger: currentController as! FlutterBinaryMessenger)
        methodChanel.setMethodCallHandler { call, result in
            if call.method == "go2authFace" {
                let params = call.arguments as! [String : String]
                FaceLivenessParams.instance.apiId = params["apiId"] ?? ""
                FaceLivenessParams.instance.apiSecret = params["apiSecret"] ?? ""
                FaceLivenessParams.instance.hostUrl = params["hostUrl"] ?? ""
                self.go2faceLiveness()
            }
            
            if call.method == "getStoageInfo" {
                let totalStorage = "\(UIDevice.current.totalDiskSpaceInBytes)"
                let freeStorage = "\(UIDevice.current.freeDiskSpaceInBytes)"
                let percentOfUsedStorage = Double(UIDevice.current.totalDiskSpaceInBytes - UIDevice.current.freeDiskSpaceInBytes) / Double(UIDevice.current.totalDiskSpaceInBytes) * 100
                result(["internalTotalStorage": totalStorage, "internalUsableStorage":freeStorage, "percentValue" : "\(percentOfUsedStorage)%", "model":UIDevice.current.modelName, "brightness": String(format: "%.0f", UIScreen.main.brightness * 100.0)]);
            }
            
            if call.method == "reverseGeocodeLocation" {
                let params = call.arguments as! [String : Any]
                let latitude = params["latitude"] as? Double
                let longitude = params["longitude"] as? Double
                let location = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
                let geoCoder = CLGeocoder();
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    guard let placemark = placemarks?.first else {return}
                    DispatchQueue.main.async {
                        result(["state" : placemark.administrativeArea,"city": placemark.locality])
                    }
                    
                }
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private var livenessVC : DFActionLivenessController!
    private var currentController : FlutterViewController!
    private var methodChanel : FlutterMethodChannel!
}

extension AppDelegate {
    // 配置活体控制器
    func go2faceLiveness() {
        let outType = "multiImg"
        let sequence = ["HOLDSTILL", "BLINK", "MOUTH", "NOD", "YAW"]
        let threshold = [0.7, 0.7, 0.7, 0.7, 0.7]
        let dict : [String : Any] = ["sequence" : sequence, "outType": outType, "threshold": threshold, "autoAntiHack" : true]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict),
              let strJson = String(data: data, encoding: .utf8) else {
            return
        }
        
        livenessVC = DFActionLivenessController()
        livenessVC.setJsonCommand(strJson)
        livenessVC.delegate = self
        livenessVC.modalPresentationStyle = .fullScreen
        
        currentController.present(livenessVC, animated: true) {
            self.livenessVC.restart()
        }
    }
}

extension AppDelegate: DFActionLivenessDelegate {
    func actionLivenessDidSuccessfulGet(_ encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!, isHack: Bool) {
        
    }
    
    
    func actionLivenessDidSuccessfulGet(_ encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!) {
        
    }
    
    func actionLivenessDidSuccessful(withScore score: CGFloat, dfImages arrDFImage: [Any]!, errorTip: String!) {
        DispatchQueue.main.async {
            self.livenessVC.dismiss(animated: true)
        }


        if let image = (arrDFImage?.last as? DFImage)?.image,let data = image.jpegData(compressionQuality: 1) {
            let imgPath = NSTemporaryDirectory() + "temp.jpg"
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: imgPath) {
                // 删除文件
                guard (try? fileManager.removeItem(atPath: imgPath)) != nil else {
                    return
                }
            }

            // 写入文件
            let isSuccess = FileManager.default.createFile(atPath: imgPath, contents: data)

            if(isSuccess) {
                methodChanel.invokeMethod("livenessCompleted", arguments: ["imgPath": imgPath, "score": "\(score)"])
            }
        }
    }
    
    func actionLivenessDidFail(withType iErrorType: DFActionLivenessError, detectionType iDetectionType: DFDetectionType, detectionIndex iIndex: Int, data encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!) {
        if iErrorType == .faceChanged && iIndex == 0 {
            livenessVC.restart()
            return
        }

        switch iErrorType {
        case .initFaild:
            showAlert(message: "SDK initialization failed")
        case .cameraError:
            showAlert(message: "Camera permission acquisition failed")
        case .faceChanged:
            showAlert(message: "No face detected,please try again.")
        case .timeOut:
            showAlert(message: "Detection timeout")
        case .willResignActive:
            showAlert(message: "App is about to be suspended")
        case .internalError:
            showAlert(message: "Internal error")
        case .bundleIDError:
            showAlert(message: "The package name in the license does not match with application ID, please use the right license file")
        case .sequenceError:
            showAlert(message: "Action sequence error")
        case .authExpire:
            showAlert(message: "Device time is not within the validity period of the license, pls use the valid license")
        case .faceMoreThanOneError:
            showAlert(message: "Multiple faces detected, please try again")
        case .licenseInvalid:
            showAlert(message: "License file invalid")
        case .badJson:
            showAlert(message: "Bad json profile")
        @unknown default:
            break
        }

    }
    
    func actionLivenessDidCancel() {
        methodChanel.invokeMethod("livenessCancel", arguments: nil)
    }

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            ErrorAlertView.showAlert(with: message) {
                self.livenessVC.dismiss(animated: true)
                self.livenessVC.cancel()
            } confirmAction: {
                self.livenessVC.restart()
            }
        }
    }
}
