// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../interstitial/interstitial_ad_view_model.dart';
import '../rewarded/rewarded_state.dart';
import '../rewarded/rewarded_view_model.dart';
import 'open_ad_manager.dart';

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor {
  AppOpenAdManager? appOpenAdManager;
  final WidgetRef widgetRef;

  AppLifecycleReactor({
    required this.appOpenAdManager,
    required this.widgetRef,
  });

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    final rewardStatusProvider = widgetRef.watch(rewardedViewModelProvider);
    final canShowOpenAd =
        rewardStatusProvider != RewardAdsStatus.showing && rewardStatusProvider != RewardAdsStatus.earned;
    final isShowInterstitial =
        widgetRef.watch(interstitialAdViewModelProvider.select((value) => value.isInterstitialShowing));
    if (appState == AppState.foreground && canShowOpenAd && !isShowInterstitial) {
      appOpenAdManager?.showAdIfAvailable();
    }
  }
}
