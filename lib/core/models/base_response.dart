class BaseResponse<T extends dynamic> {
  final bool success;
  final T? payload;
  final String? error;

  BaseResponse({required this.success, this.payload, this.error});

  factory BaseResponse.error({String? errorDescription}) => BaseResponse<T>(success: false, error: errorDescription);
  factory BaseResponse.success(dynamic payload) => BaseResponse<T>(success: true, payload: payload);
}
