import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  InterstitialAd? _interstitialAd;

  // Android Test Interstitial ID
  final String adUnitId = 'ca-app-pub-3940256099942544/1033173712';

  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('Interstitial loaded');

          _interstitialAd = ad;

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {
                  debugPrint('Interstitial showed');
                },
                onAdDismissedFullScreenContent: (ad) {
                  debugPrint('Interstitial dismissed');
                  ad.dispose();

                  // Load another ad for next time
                  loadAd();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  debugPrint('Interstitial failed to show: $error');
                  ad.dispose();

                  loadAd();
                },
              );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Interstitial failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  void showAd() {
    if (_interstitialAd == null) {
      debugPrint('Interstitial not ready');
      return;
    }

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}