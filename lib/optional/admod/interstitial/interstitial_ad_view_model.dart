import 'dart:async';
import 'dart:io';

import 'package:baseflutter/optional/admod/consent_manager.dart';
import 'package:baseflutter/optional/admod/constant.dart';
import 'package:baseflutter/optional/admod/interstitial/interstitial_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../debug/debug_ext.dart';

part 'interstitial_ad_view_model.g.dart';

@riverpod
class InterstitialAdViewModel extends _$InterstitialAdViewModel {
  final int _limitShowInterstitialAd = 4;
  int _numberOfShowInterstitialAd = 0;
  Completer _completer = Completer();
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;
  final _consentManager = ConsentManager();

  @override
  InterstitialState build() {
    createInterstitialAd();
    ref.onDispose(() {
      _interstitialAd?.dispose();
    });
    return InterstitialState(isInterstitialShowing: false);
  }

  void createInterstitialAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    InterstitialAd.load(
        adUnitId: Platform.isAndroid ? ANDROID_INTERSTITIAL_AD_ID_TEST : IOS_INTERSTITIAL_AD_ID_TEST,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      _completer.complete();
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        printSuccess("InterstitialAd ads finish");
        ad.dispose();
        createInterstitialAd();
        state = state.copyWith(isInterstitialShowing: false);
        _completer.complete();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
        state = state.copyWith(isInterstitialShowing: false);
        _completer.complete();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  Future<void> showAdIfNeed() {
    _completer = Completer();
    if (_numberOfShowInterstitialAd > _limitShowInterstitialAd) {
      _numberOfShowInterstitialAd = 0;
      showInterstitialAd();
      state = state.copyWith(isInterstitialShowing: true);
    } else {
      _numberOfShowInterstitialAd++;
      _completer.complete();
    }
    return _completer.future;
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
