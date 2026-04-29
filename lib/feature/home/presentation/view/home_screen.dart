import 'package:flutter/material.dart';

import '../../../../core/presentation/banner_ad/banner_ad_widget.dart';
import '../../../../core/presentation/interstitial_ad/interstitial_ad_helper.dart';
import '../../../../core/presentation/rewarded_ad/rewarded_ad_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InterstitialAdHelper interstitialAdHelper = InterstitialAdHelper();
  final RewardedAdHelper rewardedAdHelper = RewardedAdHelper();

  @override
  void initState() {
    super.initState();
    rewardedAdHelper.loadAd();
    interstitialAdHelper.loadAd();
  }

  @override
  void dispose() {
    interstitialAdHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AdMob Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(
              onPressed: () {
                interstitialAdHelper.showAd();
              },
              child: const Text('Show Interstitial Ad'),
            ),
            ElevatedButton(
              onPressed: () {
                rewardedAdHelper.showAd(
                  onRewardEarned: () {
                    debugPrint('Give user coins or unlock content here');
                  },
                );
              },
              child: const Text('Watch Ad and Get Reward'),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: BannerAdWidget()),
    );
  }
}
