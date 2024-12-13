// ignore_for_file: public_member_api_docs, sort_constructors_first
class InterstitialState {
  final bool isInterstitialShowing;
  InterstitialState({
    required this.isInterstitialShowing,
  });

  InterstitialState copyWith({
    bool? isInterstitialShowing,
  }) {
    return InterstitialState(
      isInterstitialShowing: isInterstitialShowing ?? this.isInterstitialShowing,
    );
  }
}
