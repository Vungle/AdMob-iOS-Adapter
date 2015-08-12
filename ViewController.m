//
//  ViewController.m
//  RewardBasedVideo
//
//  Created by Imran Khan on 2/9/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

@import GoogleMobileAds;

#import "ViewController.h"

static NSString *const kRequestMessage = @"Request ad from vungle.";
static NSString *const kPresentMessage = @"Present ad from vungle.";

@interface ViewController () <GADRewardBasedVideoAdDelegate>
@property(nonatomic, assign) BOOL adReceivedFromVungle;
@end

@implementation ViewController

- (void)viewDidLoad {
  [GADRewardBasedVideoAd sharedInstance].delegate = self;
}

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
                                           withAdUnitID:@"ca-app-pub-3940256099942544/9998782919"
                                                 userID:@"vungle_user"];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

- (void)appendLog:(NSString *)text {
  self.logView.text = [NSString stringWithFormat:@"%@\n%@", self.logView.text, text];
}

@end
