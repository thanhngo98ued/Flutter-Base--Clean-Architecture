// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdsState {
  final bool isLoading;
  final bool isNativeLoaded;
  final bool isShowNativeAd;

  AdsState({
    required this.isLoading,
    required this.isNativeLoaded,
    required this.isShowNativeAd,
  });

  AdsState copyWith({
    bool? isLoading,
    bool? isNativeLoaded,
    bool? isShowNativeAd,
  }) {
    return AdsState(
      isLoading: isLoading ?? this.isLoading,
      isNativeLoaded: isNativeLoaded ?? this.isNativeLoaded,
      isShowNativeAd: isShowNativeAd ?? this.isShowNativeAd,
    );
  }
}
