import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'index.dart';

/// http工具类，基于[Dio]实现
class HttpUtil {
  late final Dio http;

  static final HttpUtil _instance = HttpUtil._();

  factory HttpUtil() => _instance;

  HttpUtil._() {
    http = createDio();
    http.interceptors
      ..add(getRetryInterceptor(http))
      ..add(errorInterceptor());
  }

  /// get请求
  static Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    // 取消请求token，如果未传入，则使用默认的cancelToken
    CancelToken? cancelToken,
    // 是否开启缓存，若为true，接口响应成功后数据将会保存于本地，key为url
    bool? enableCache = false,
    // 是否使用缓存数据，如果本地存在数据，则直接返回本地数据，不会发送请求，
    // 你可以在缓存拦截器中自定义缓存时间，如果用户处于无网络状态，则直接响应缓存数据。
    bool? useCache = false,
    // 是否显示全局异常消息，如果为true，last_interceptor拦截器将会显示网络错误
    bool? showGlobalException = true,
    // 是否显示接口异常消息，如果为true，error_interceptor拦截器将会显示服务器内部错误
    bool? showServerException = true,
    // 接口请求完成后是否关闭全局loading（如果页面没有loading弹窗，则不做任何操作），
    // 如果你需要执行多个请求，同时又希望它们共用一个Loading弹窗，那么你应该将它设为false
    bool? closeLoading = true,
    // 强制使用mock数据，注意：你需要在mock文件中声明此接口的数据
    bool? useMockData = false,
  }) async {
    Options requestOptions;
    if (options != null) {
      options.extra ??= {};
      requestOptions = options;
    } else {
      requestOptions = Options(extra: {});
    }
    requestOptions.extra!['apiUrl'] = url;
    requestOptions.extra!['useCache'] = useCache;
    requestOptions.extra!['enableCache'] = enableCache;
    requestOptions.extra!['showGlobalException'] = showGlobalException;
    requestOptions.extra!['showServerException'] = showServerException;
    requestOptions.extra!['closeLoading'] = closeLoading;
    requestOptions.extra!['useMockData'] = useMockData;
    try {
      var res = await _instance.http.get<T>(
        url,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 创建一个通用的dio实例
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        // 连接服务器超时时间
        connectTimeout: const Duration(milliseconds: isRelease ? 10000 : 5000),
        // 两次数据流数据接收的最长间隔时间
        receiveTimeout: const Duration(milliseconds: isRelease ? 10000 : 5000),
      ),
    );
    return dio;
  }

  /// http重试请求拦截器
  static Interceptor getRetryInterceptor(Dio dio) {
    return RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 1),
        Duration(seconds: 1),
      ],
    );
  }

  /// http通用错误拦截器
  static errorInterceptor() {
    return InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) async {
        if (response.requestOptions.extra['closeLoading'] == true) {
          await LoadingUtil.close();
        }
        return handler.resolve(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        LoggerUtil.e(e, '全局Http请求异常：${e.requestOptions.uri}');
        if (e.requestOptions.extra['closeLoading'] == true) {
          await LoadingUtil.close();
        }
        String errorMsg = '';
        switch (e.type) {
          case DioExceptionType.sendTimeout:
          case DioExceptionType.connectionTimeout:
            errorMsg = '服务器连接超时，请稍后重试！';
            break;
          case DioExceptionType.receiveTimeout:
            errorMsg = '服务器响应超时，请稍后重试！';
            break;
          case DioExceptionType.badResponse:
            if (e.message != null && e.message!.contains('404')) {
              errorMsg = '请求接口404';
            } else {
              errorMsg = '无效请求';
            }
            break;
          case DioExceptionType.connectionError:
            errorMsg = '服务器连接错误';
            break;
          case DioExceptionType.badCertificate:
            errorMsg = '服务证书错误';
            break;
          case DioExceptionType.cancel:
            break;
          case DioExceptionType.unknown:
            if (e.error is SocketException) {
              errorMsg = '网络连接错误，请检查网络连接！';
            } else {
              errorMsg = '网络连接出现未知错误！';
            }
            break;
        }
        if (e.requestOptions.extra['showGlobalException'] == true) {
          if (errorMsg != '') ToastUtil.showErrorToast(errorMsg);
        }
        return handler.reject(e);
      },
    );
  }
}

/// 自定义HttpClient，取消验证https证书是否有效
class GlobalHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
