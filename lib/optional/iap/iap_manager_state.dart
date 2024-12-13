import 'package:in_app_purchase/in_app_purchase.dart';

class IapManagerState {
  IapManagerState({
    this.isSubscribe1YearSelected,
    this.isPremiumAccount = false,
    this.oneYearPremium,
    this.lifeTimePremium,
    this.isAvailablePremium,
    this.numberClickToShowAds,
  });

  bool? isAvailablePremium;
  bool? isSubscribe1YearSelected;
  bool isPremiumAccount;
  ProductDetails? oneYearPremium;
  ProductDetails? lifeTimePremium;
  int? numberClickToShowAds;

  IapManagerState copyWith({
    bool? isAvailablePremium,
    bool? isSubscribe1YearSelected,
    bool? isPremiumAccount,
    ProductDetails? oneYearPremium,
    ProductDetails? lifeTimePremium,
    int? numberClickToShowAds,
  }) {
    return IapManagerState(
      isAvailablePremium: isAvailablePremium ?? this.isAvailablePremium,
      isSubscribe1YearSelected: isSubscribe1YearSelected ?? this.isSubscribe1YearSelected,
      isPremiumAccount: isPremiumAccount ?? this.isPremiumAccount,
      oneYearPremium: oneYearPremium ?? this.oneYearPremium,
      lifeTimePremium: lifeTimePremium ?? this.lifeTimePremium,
      numberClickToShowAds: numberClickToShowAds ?? this.numberClickToShowAds,
    );
  }
}
