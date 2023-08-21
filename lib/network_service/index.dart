import 'dart:typed_data';
import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:rupee_elf/component/order/order_item_list_page.dart';
import 'package:rupee_elf/models/aws_params_model.dart';
import 'package:rupee_elf/models/base_model.dart';
import 'package:rupee_elf/models/certification_info_model.dart';
import 'package:rupee_elf/models/empty_network_result.dart';
import 'package:rupee_elf/models/face_liveness_parameters.dart';
import 'package:rupee_elf/models/feedback_list_model.dart';
import 'package:rupee_elf/models/login_model.dart';
import 'package:rupee_elf/models/ocr_model.dart';
import 'package:rupee_elf/models/order_detail_page_model.dart';
import 'package:rupee_elf/models/order_list_model.dart';
import 'package:rupee_elf/models/product_list_model.dart';
import 'package:rupee_elf/models/purchase_product_model.dart';
import 'package:rupee_elf/models/space_detail_model.dart';
import 'package:rupee_elf/models/user_auth_submit_model.dart';
import 'package:rupee_elf/models/user_info_model.dart';
import 'package:rupee_elf/network/index.dart';
import 'package:rupee_elf/util/commom_toast.dart';
import 'package:rupee_elf/util/md5_util.dart';
import 'package:rupee_elf/util/navigator_key.dart';
import 'package:rupee_elf/util/random_util.dart';

class NetworkService {
  /// first launch
  static firstLaunch() async {
    await _defaultService(path: '/cLqgPJf/jNSuDf');
  }

  // 发送短信验证啊
  static sendSms(String userPhone, Function() success) async {
    var result = await _defaultService(
        path: '/cLqgPJf/aBqgqj', parameters: {'uYYseYrPhone': userPhone});
    var model = EmptyNetworkResult.fromJson(result);
    if (model.rkmectsultCode == 1) {
      success();
    }
  }

  // login
  static Future<LoginModel> login(String phone, String code) async {
    var params = {'uYYseYrPhone': phone, 'lYYogYinCode': code};
    var json =
        await _defaultService(path: '/cLqgPJf/dHbqEa', parameters: params);
    return LoginModel.fromJson(json);
  }

  // 退出登录
  static logout(Function() success) async {
    var result = await _defaultService(path: '/cLqgPJf/HJKfYM');
    var model = BaseModel.fromJson(result);
    if (model.resultCode == 1) {
      success();
    }
  }

  // 登录前首页列表
  static Future<ProductListModel> getProductList() async {
    var result = await _defaultService(path: '/cLqgPJf/JvLpx');
    return ProductListModel.fromJson(result);
  }

  // 获取用户信息, 此接口中含推荐产品的模型
  static Future<UserInfoModel?> getUserInfo({String isRecommend = '0'}) async {
    var result = await _defaultService(
      path: '/cLqgPJf/tuVg/eQmnX',
      parameters: {'iYYsRYecommend': isRecommend},
    );

    UserInfoModel? model =
        await _configNetworkError(UserInfoModel.fromJson(result));

    return model;
  }

  // 获取用户的认证信息
  static Future<CertificationInfoModel?> getCertificationInfo() async {
    var result = await _defaultService(path: '/cLqgPJf/tuVg/IKVwHM');
    CertificationInfoModel info = CertificationInfoModel.fromJson(result);
    return await _configNetworkError(info);
  }

  // 检查用户是否做过活体
  static Future<bool> checkUserLiveness() async {
    UserInfoModel? info = await getUserInfo();
    if (info == null) return false;
    return info.userLiveness == 1;
  }

  // 生成借款订单并上传设备信息
  static Future<PurchaseProductModel?> purchaseProduct(
      Map<String, dynamic> params) async {
    var json =
        await _defaultService(path: '/cLqgPJf/tuVg/mxLKT', parameters: params);
    return await _configNetworkError(PurchaseProductModel.fromJson(json));
  }

  // 用户认证信息提交
  static userAuthSubmit(
      UserAuthSubmitModel submitModel, Function() success) async {
    Map<String, dynamic> params = {'aYYutYhStep': submitModel.aYYutYhStep};
    if (submitModel.aYYutYhStep == '1') {
      params['fYYroYntImage'] = submitModel.fYYroYntImage;
      params['bYYacYkImage'] = submitModel.bYYacYkImage;
      params['pYYanYCardImg'] = submitModel.pYYanYCardImg;
      params['uYYseYrNames'] = submitModel.uYYseYrNames;
      params['aYYadYhaarNumber'] = submitModel.aYYadYhaarNumber;
      params['dYYatYeOfBirth'] = submitModel.dYYatYeOfBirth;
      params['uYYseYrGender'] = submitModel.uYYseYrGender;
      params['aYYddYressDetail'] = submitModel.aYYddYressDetail;
      params['pYYanYNumber'] = submitModel.pYYanYNumber;
    }

    if (submitModel.aYYutYhStep == '2') {
      params['mYYarYriageStatus'] = submitModel.mYYarYriageStatus;
      params['eYYduYcation'] = submitModel.eYYduYcation;
      params['uYYseYrIndustry'] = submitModel.uYYseYrIndustry;
      params['mYYonYthlySalary'] = submitModel.mYYonYthlySalary;
      params['wYYorYkTitle'] = submitModel.wYYorYkTitle;
      params['wYYhaYtsAppAccount'] = submitModel.wYYhaYtsAppAccount;
      params['uYYseYrEmail'] = submitModel.uYYseYrEmail;
      params['aYYppYlyAmount'] = submitModel.aYYppYlyAmount;
      if (submitModel.fYYacYebookId.trim().isNotEmpty) {
        params['fYYacYebookId'] = submitModel.fYYacYebookId;
      }
    }

    if (submitModel.aYYutYhStep == '3') {
      params['cYYonYtactList'] = submitModel.cYYonYtactList;
    }

    if (submitModel.aYYutYhStep == '4') {
      params['bYYanYkCardNo'] = submitModel.bYYanYkCardNo;
      params['bYYanYkCardName'] = submitModel.bYYanYkCardName;
      params['bYYanYkIfscCode'] = submitModel.bYYanYkIfscCode;
    }

    var json =
        await _defaultService(path: '/cLqgPJf/tuVg/hUsKR', parameters: params);
    BaseModel model = BaseModel.fromJson(json);

    if (await _configNetworkError<BaseModel>(model) != null) {
      success();
    }
  }

  // 获取订单列表
  static Future<OrderListModel?> fetchOrderList(OrderType type) async {
    String? orderStatus;
    switch (type) {
      case OrderType.all:
        orderStatus = null;
      case OrderType.pending:
        orderStatus = '1';
      case OrderType.disbursing:
        orderStatus = '2';
      case OrderType.unrepay:
        orderStatus = '3';
      case OrderType.repaied:
        orderStatus = '4';
      case OrderType.denied:
      case OrderType.disbursingFail:
        orderStatus = '5';
      case OrderType.overdue:
        orderStatus = '6';
    }

    var json = await _defaultService(
      path: '/cLqgPJf/tuVg/UMxCO',
      parameters: orderStatus != null ? {'oYYrdYerStatus': orderStatus} : null,
    );

    return await _configNetworkError(OrderListModel.fromJson(json));
  }

  // 查询space详情
  static Future<SpaceDetailModel?> checkUserSpaceDetail(
      String productId) async {
    var json = await _defaultService(
        path: '/cLqgPJf/tuVg/wTLWv', parameters: {'pYYroYductId': productId});
    return await _configNetworkError(SpaceDetailModel.fromJson(json));
  }

  static Future<OrderDetailPageModel?> getOrderDetail(
      String orderNumber) async {
    var json = await _defaultService(
      path: '/cLqgPJf/tuVg/iuVeV',
      parameters: {'lYYoaYnOrderNo': orderNumber},
    );
    return await _configNetworkError(OrderDetailPageModel.fromJson(json));
  }

  // 提交反馈
  static Future<BaseModel?> submitFeedback({
    required String orderNumber,
    required String feedBackType,
    required String feedBackContent,
    required String feedBackImg,
  }) async {
    var json = await _defaultService(path: '/cLqgPJf/tuVg/yMpgc', parameters: {
      'lYYoaYnOrderNo': orderNumber,
      'fYYeeYdBackType': feedBackType,
      'fYYeeYdBackContent': feedBackContent,
      'fYYeeYdBackImg': feedBackImg,
    });

    return await _configNetworkError(BaseModel.fromJson(json));
  }

  // 反馈列表
  static Future<FeedbackListModel?> getFeedbackList() async {
    var json = await _defaultService(path: '/cLqgPJf/tuVg/muQPD');
    FeedbackListModel model = FeedbackListModel.frontJson(json);
    return await _configNetworkError(model);
  }

  // 人脸认证 SDK 参数获取
  static Future<FaceLivenessParameters?> getFaceLivenessParams() async {
    var json = await _defaultService(
        path: '/cLqgPJf/tuVg/kBykM',
        parameters: {'uYYseYrFaceStep': 'license'});
    return _configNetworkError(FaceLivenessParameters.fromJson(json));
  }

  // 人脸认证图片上传 + 人脸认证第二步
  static Future<BaseModel?> uploadImgAndAuthFace(
      String imgPath, String score) async {
    EasyLoading.show(
        status: 'Authenticating...', maskType: EasyLoadingMaskType.black);
    String imageUrl = await awsImageUpload(imgPath);
    var json = await _defaultService(path: '/cLqgPJf/tuVg/kBykM', parameters: {
      'uYYseYrFaceStep': 'liveness',
      'lYYivYenessImg': imageUrl,
      'lYYivYenessScore': score
    });
    EasyLoading.dismiss();
    return _configNetworkError(BaseModel.fromJson(json));
  }

  // OCR 识别
  static Future<OcrModel?> ocrRecgonizer(
      String filePath, String ocrType) async {
    EasyLoading.show(
        status: 'identifying...', maskType: EasyLoadingMaskType.black);
    String imageUrl = await awsImageUpload(filePath);
    var json = await _defaultService(
      path: '/cLqgPJf/tuVg/sKsiv',
      parameters: {'iYYmaYgeUrl': imageUrl, 'oYYcrYType': ocrType},
      showLoading: false,
    );
    EasyLoading.dismiss();
    OcrModel model = OcrModel.fromJson(json);
    return await _configNetworkError<OcrModel>(model);
  }

  // AWS图片上传
  static Future<String> awsImageUpload(String filePath) async {
    var result = await _defaultService(
      path: '/cLqgPJf/tuVg/lmTHO',
      showLoading: false,
      showErrorMessage: true,
    );
    AwsParamsModel params = AwsParamsModel.fromJson(result);

    AwsClientCredentials credentials = AwsClientCredentials(
      accessKey: params.credentials.accessKeyId,
      secretKey: params.credentials.secretAccessKey,
      sessionToken: params.credentials.sessionToken,
    );
    S3 client = S3(
      region: params.awsRegion,
      credentials: credentials,
    );

    // 配置图片路径
    var date = formatDate(DateTime.now(), ['yyyy', '-', 'mm', '-', 'dd']);
    String objectKey =
        'india/img/$date/${RandomUtil.generateRandomString(32)}.jpg';
    Uint8List imgData = await compressImageToLower200kB(filePath);
    PutObjectOutput _ = await client.putObject(
      bucket: params.awsBucket,
      key: objectKey,
      body: imgData,
      contentType: 'image/jpeg',
    );
    return objectKey;
  }

  // 压缩图片到200kb
  static Future<Uint8List> compressImageToLower200kB(String filePath) async {
    Uint8List imageCompressed = Uint8List(0);
    for (int i = 0; i < 100; i++) {
      Uint8List? stempList = await FlutterImageCompress.compressWithFile(
        filePath,
        minWidth: 1024,
        minHeight: 768,
        quality: 100 - i,
      );
      if (stempList != null && stempList.length <= 200000) {
        imageCompressed = stempList;
      }
    }
    return imageCompressed;
  }

  // 处理 API 内部报错
  static Future<T?> _configNetworkError<T extends BaseModel>(T model) async {
    if (model.resultCode == 1) {
      return model;
    }

    if (model.resultCode == -1) {
      // 去登录页面
      BuildContext? context = NavigatorKey.navKey.currentState?.context;
      if (context != null) {
        await Navigator.of(context).pushNamed('/login');
        return null;
      }
    }

    if (model.resultCode == 0) {
      await CommonToast.showToast(model.resultMsg);
      return null;
    }

    return null;
  }

  // 统一处理网络请求服务
  static Future<dynamic> _defaultService({
    required String path,
    Map<String, dynamic>? parameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) async {
    var formData = FormData.fromMap(_configParameters(parameters));

    return await HttpUtils.post(
      path: path.trim(),
      data: formData,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  // 统一处理参数签名
  static Map<String, dynamic> _configParameters(
      Map<String, dynamic>? parameters) {
    Map<String, dynamic> newParams;

    if (parameters == null) {
      newParams = {'nYYonYcestr': RandomUtil.generateRandomString(30)};
    } else {
      newParams = Map.from(parameters);
      newParams['nYYonYcestr'] = RandomUtil.generateRandomString(30);
    }

    String signKey = '&signKey=iYeXsbQTefsNWaAyFSDRBnkb';
    String keyString = _sortedMapWith(newParams) + signKey;
    newParams['rYYeqYSign'] = MD5Util.md5String(keyString);
    return newParams;
  }

  // 参数排序
  static String _sortedMapWith(Map<String, dynamic> params) {
    List<String> allKeys = params.keys.toList();
    allKeys.sort(
        (left, right) => left.toLowerCase().compareTo(right.toLowerCase()));

    var mapString = '';
    for (int i = 0; i < allKeys.length; i++) {
      String key = allKeys[i];
      String value = '${params[key]}';

      if (i == 0) {
        mapString = '$key=$value';
      } else {
        mapString = '$mapString&$key=$value';
      }
    }
    return mapString;
  }
}
