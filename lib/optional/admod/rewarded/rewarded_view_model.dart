import 'dart:io';

import 'package:baseflutter/optional/admod/consent_manager.dart';
import 'package:baseflutter/optional/admod/constant.dart';
import 'package:baseflutter/optional/admod/rewarded/rewarded_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../debug/debug_ext.dart';

part 'rewarded_view_model.g.dart';

@riverpod
class RewardedViewModel extends _$RewardedViewModel {
  final _consentManager = ConsentManager();
  bool _isRewardedAdReady = false;
  int _numRewardLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;

  RewardedAd? _rewardedAd;
  final String _adUnitId = Platform.isAndroid ? ANDROID_REWARD_AD_ID_TEST : IOS_REWARD_AD_ID_TEST;

  @override
  RewardAdsStatus build() {
    ref.listenSelf((prev, next) {
      if (next == RewardAdsStatus.initial) {
        loadAd();
      }
    });
    ref.onDispose(() {
      _rewardedAd?.dispose();
    });
    return RewardAdsStatus.initial;
  }

  void loadAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    state = RewardAdsStatus.loading;

    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          printSuccess('Rewarded ad loaded.');
          _rewardedAd = ad;
          _isRewardedAdReady = true;
          state = RewardAdsStatus.loaded;
          _numRewardLoadAttempts = 0;

          // Optional: Set up full screen content callback to handle errors
          _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              printSuccess('Rewarded ad showed.');
            },
            onAdDismissedFullScreenContent: (ad) {
              printSuccess('Rewarded ad dismissed.');
              ad.dispose();
              _isRewardedAdReady = false;
              _rewardedAd = null;
              state = RewardAdsStatus.finish;
              // Optionally reload the ad
              loadAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              printError('Failed to show rewarded ad: $error');
              _isRewardedAdReady = false;
              ad.dispose();
              _rewardedAd = null;
              state = RewardAdsStatus.finish;
            },
          );
        },
        onAdFailedToLoad: (error) {
          _numRewardLoadAttempts++;
          printError('Failed to load rewarded ad: $error');
          state = RewardAdsStatus.loaded;
          _isRewardedAdReady = false;
        },
      ),
    );
  }

  void showRewardedAd() {
    if (_isRewardedAdReady && _rewardedAd != null) {
      state = RewardAdsStatus.showing;
      _showRewardAds();
    } else {
      state = RewardAdsStatus.error;
      printError('Rewarded ad is not ready.');
    }
  }

  void resetStatus() {
    state = RewardAdsStatus.reset;
  }

  void showAdWithLimitedAttempts() {
    resetStatus();
    if (_numRewardLoadAttempts < maxFailedLoadAttempts) {
      state = RewardAdsStatus.initial;
    }
  }

  void _showRewardAds() {
    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        printSuccess('User earned reward: ${reward.amount} ${reward.type}');
        state = RewardAdsStatus.earned;
      },
    );
  }
}
