//
//  ViewController.m
//  RewardBasedVideo
//
//  Created by Imran Khan on 2/9/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

@import GoogleMobileAds;

#import "ViewController.h"

static NSString *const kRequestMessage = @"Request RewardBased ad from vungle.";
static NSString *const kPresentMessage = @"Present RewardBased ad from vungle.";

static NSString *const kRequestInterstitialMessage = @"Request Interstitial ad from vungle.";
static NSString *const kPresentInterstitialMessage = @"Present Interstitial ad from vungle.";

static NSString *const UnitIDrewardBased = @"ca-app-pub-3940256099942544/9998782919";//rewardBasedVideo

static NSString *const UnitIDInterstitial = @"ca-app-pub-1812018162342166/7341265538";//Interstitial

@interface ViewController () <GADRewardBasedVideoAdDelegate, GADInterstitialDelegate>
@property(nonatomic, assign) BOOL interstitialAdReceivedFromVungle;
@property(nonatomic, assign) BOOL adReceivedFromVungle;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation ViewController

- (void)viewDidLoad {
  [GADRewardBasedVideoAd sharedInstance].delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)appendLog:(NSString *)text {
	self.logView.text = [NSString stringWithFormat:@"%@\n%@", self.logView.text, text];
}

#pragma mark RewardBasedVideoAd

- (void)resetRequest {
  _adReceivedFromVungle = NO;
  [_RBVVungleButton setTitle:kRequestMessage forState:UIControlStateNormal];
}

- (void)onRequestRBVFromVungle:(id)sender {
	if (_adReceivedFromVungle) {
		[[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
	} else {
		[self resetRequest];
		[[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
											   withAdUnitID:UnitIDrewardBased
													 userID:@"vungle_user"];
        [self appendLog:@"Requesting reward based video ad..."];
	}
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	_adReceivedFromVungle = YES;
	[_RBVVungleButton setTitle:kPresentMessage forState:UIControlStateNormal];
	
	[self appendLog:@"Reward based video ad is received."];
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	[self appendLog:@"Opened reward based video ad."];
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	[self appendLog:@"Reward based video ad started playing."];
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	[self appendLog:@"Reward based video ad is closed."];
	[self resetRequest];
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
	NSString *rewardMessage =
	[NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
	 reward.type,
	 [reward.amount doubleValue]];
	[self appendLog:rewardMessage];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	[self appendLog:@"Reward based video ad will leave application."];
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
	didFailToLoadwithError:(NSError *)error {
	[self appendLog:@"Reward based video ad failed to load."];
}


#pragma mark InterstitialAd

- (void)resetInterstitialRequest {
	_interstitialAdReceivedFromVungle = NO;
	[_VungleInterstitialButton setTitle:kRequestInterstitialMessage forState:UIControlStateNormal];
}

- (IBAction)onRequestInterstitialFromVungle:(id)sender{
	if (_interstitialAdReceivedFromVungle) {
		[self.interstitial presentFromRootViewController:self];
	} else {
		[self resetInterstitialRequest];
		self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:UnitIDInterstitial];
		self.interstitial.delegate = self;
		GADRequest *request = [GADRequest request];
		//test ad from admob
		//request.testDevices = @[kGADSimulatorID];
		[self.interstitial loadRequest:request];
        [self appendLog:@"Requesting interstitial ad..."];
	}
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
	_interstitialAdReceivedFromVungle = YES;
	[_VungleInterstitialButton setTitle:kPresentInterstitialMessage forState:UIControlStateNormal];
	
	[self appendLog:@"Interstitial ad is received."];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
	[self appendLog:@"Interstitial ad failed to load."];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
	[self appendLog:@"Opened interstitial ad."];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
	[self appendLog:@"Interstitial ad is closed."];
	[self resetInterstitialRequest];
}

@end
