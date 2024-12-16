// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:baseflutter/optional/admod/consent_manager.dart';
import 'package:baseflutter/optional/admod/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../presentation/resources/gen/colors.gen.dart';
import 'native_ad_view_model.dart';

class NativePlatformAd extends ConsumerStatefulWidget {
  const NativePlatformAd({
    super.key,
    this.isSizeSmall,
  });

  final bool? isSizeSmall;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NativePlatformAdPageState();
}

class _NativePlatformAdPageState extends ConsumerState<NativePlatformAd> {
  final _consentManager = ConsentManager();

  final double _adAspectRatioSmall = (91 / 355);
  final double _adAspectRatioMedium = (370 / 355);

  NativeAd? _nativeAd;
  final String _adUnitId = Platform.isAndroid ? ANDROID_NATIVE_AD_ID_TEST : IOS_NATIVE_AD_ID_TEST;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isNativeLoaded = ref.watch(nativeAdViewModelProvider.select((value) => value.isNativeLoaded));
      final isAdsVisible = ref.watch(nativeAdViewModelProvider.select((value) => value.isShowNativeAd));

      return isNativeLoaded && _nativeAd != null
          ? Visibility(
              visible: isAdsVisible,
              child: Container(
                color: AppColors.backgroundLightColor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width *
                      (widget.isSizeSmall == true ? _adAspectRatioSmall : _adAspectRatioMedium),
                  width: MediaQuery.of(context).size.width,
                  child: AdWidget(ad: _nativeAd!),
                ),
              ),
            )
          : const SizedBox();
    });
  }

  void _loadAd() async {
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds || _nativeAd != null) {
      return;
    }

    ref.read(nativeAdViewModelProvider.notifier).setIsNativeLoaded(false);

    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        factoryId: 'adFactoryExample',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            // ignore: avoid_print
            print('$NativeAd loaded.');
            ref.read(nativeAdViewModelProvider.notifier).setIsNativeLoaded(true);
          },
          onAdFailedToLoad: (ad, error) {
            // ignore: avoid_print
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
          },
          onAdClicked: (ad) {},
          onAdImpression: (ad) {},
          onAdClosed: (ad) {},
          onAdOpened: (ad) {},
          onAdWillDismissScreen: (ad) {},
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: widget.isSizeSmall == true ? TemplateType.small : TemplateType.medium,
            mainBackgroundColor: const Color(0xfffffbed),
            callToActionTextStyle: NativeTemplateTextStyle(
              textColor: Colors.white,
              style: NativeTemplateFontStyle.monospace,
              size: 16.0,
            ),
            primaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.black,
              style: NativeTemplateFontStyle.bold,
              size: 16.0,
            ),
            secondaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.black,
              style: NativeTemplateFontStyle.italic,
              size: 16.0,
            ),
            tertiaryTextStyle: NativeTemplateTextStyle(
              textColor: Colors.black,
              style: NativeTemplateFontStyle.normal,
              size: 16.0,
            )))
      ..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
