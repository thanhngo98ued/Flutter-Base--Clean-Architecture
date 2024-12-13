import 'package:baseflutter/optional/admod/native/native_ad_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_ad_view_model.g.dart';

@riverpod
class NativeAdViewModel extends _$NativeAdViewModel {
  final needShowNativeAdScreen = [];

  @override
  AdsState build() {
    return AdsState(
      isLoading: false,
      isNativeLoaded: false,
      isShowNativeAd: false,
    );
  }

  void setIsNativeLoaded(bool isNativeLoaded) {
    state = state.copyWith(isNativeLoaded: isNativeLoaded);
  }

  void setIsShowNativeAd(String currentRootLocation) {
    state = state.copyWith(isShowNativeAd: needShowNativeAdScreen.contains(currentRootLocation));
  }
}
