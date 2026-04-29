import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdHelper {
  RewardedAd? _rewardedAd;

  // Android Test Rewarded ID
  final String adUnitId = 'ca-app-pub-3940256099942544/5224354917';

  void loadAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugPrint('Rewarded ad loaded');

          _rewardedAd = ad;

          _rewardedAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  debugPrint('Rewarded ad dismissed');
                  ad.dispose();

                  loadAd();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  debugPrint('Rewarded ad failed to show: $error');
                  ad.dispose();

                  loadAd();
                },
              );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Rewarded ad failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  void showAd({
    required VoidCallback onRewardEarned,
  }) {
    if (_rewardedAd == null) {
      debugPrint('Rewarded ad not ready');
      return;
    }

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');

        onRewardEarned();
      },
    );

    _rewardedAd = null;
  }

  void dispose() {
    _rewardedAd?.dispose();
  }
}