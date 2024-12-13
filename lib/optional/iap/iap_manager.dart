import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'iap_manager_state.dart';

part 'iap_manager.g.dart';

@riverpod
class IapManager extends _$IapManager {
  final List<String> _kProductIds = <String>["randomizerpro.1year", "randomizerpro.lifetime.premium"];
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];

  @override
  Future<IapManagerState> build() async {
    final isAccountPremium = await getIsPremium();
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      print("$error");
    });
    initStoreInfo();

    return IapManagerState(
      isSubscribe1YearSelected: true,
      isPremiumAccount: isAccountPremium ?? false,
    );
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _products = <ProductDetails>[];
      state = AsyncData(state.requireValue.copyWith(isAvailablePremium: false));
      return;
    }

    await _inAppPurchase.restorePurchases();

    final ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    _products = productDetailResponse.productDetails;
    state = AsyncData(state.requireValue.copyWith(
        isAvailablePremium: isAvailable,
        oneYearPremium: _products.where((e) => e.id == "randomizerpro.1year").first,
        lifeTimePremium: _products.where((e) => e.id == "randomizerpro.lifetime.premium").first));
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    if (purchaseDetailsList.isEmpty) {
      state = AsyncData(state.requireValue.copyWith(isPremiumAccount: false));
    }
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("_listenToPurchaseUpdated pending");
        setIsPremiumAccount(false);
        state = AsyncData(state.requireValue.copyWith(isPremiumAccount: false));
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print("_listenToPurchaseUpdated error");
          setIsPremiumAccount(false);
          state = AsyncData(state.requireValue.copyWith(isPremiumAccount: false));
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          print("_listenToPurchaseUpdated restored");
          setIsPremiumAccount(true);
          state = AsyncData(state.requireValue.copyWith(isPremiumAccount: true));
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void buyProduct() {
    final isOneYearSelected = state.requireValue.isSubscribe1YearSelected ?? true;
    final oneYearProduct = state.requireValue.oneYearPremium;
    final lifeTimeProduct = state.requireValue.lifeTimePremium;
    if (!Platform.isAndroid) return;
    if (_products.isEmpty) return;
    final purchaseParam = GooglePlayPurchaseParam(
        productDetails: isOneYearSelected ? oneYearProduct! : lifeTimeProduct!, changeSubscriptionParam: null);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void setIsSelectSubscribeFree(bool isSelected) {
    state = AsyncData(state.requireValue.copyWith(isSubscribe1YearSelected: isSelected));
  }

  Future<bool?> getIsPremium() async {
    return null;

    //todo
  }

  void setIsPremiumAccount(bool isPremium) async {
    //todo
  }

  void setNumberClickToShowAds({int? numberClick, bool? isClear}) async {
    if (state.requireValue.isPremiumAccount) return;
    final number = isClear != true ? ((state.valueOrNull?.numberClickToShowAds ?? 0) + (numberClick ?? 0)) : 0;
    state = AsyncData(state.requireValue.copyWith(numberClickToShowAds: number));
  }
}
