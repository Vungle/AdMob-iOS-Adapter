//
//  ViewController.h
//  RewardBasedVideo
//
//  Created by Imran Khan on 2/9/15.
//  Copyright (c) 2015 Google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIButton *RBVVungleButton;
@property(nonatomic, strong) IBOutlet UIButton *VungleInterstitialButton;
@property(nonatomic, strong) IBOutlet UITextView *logView;

- (IBAction)onRequestRBVFromVungle:(id)sender;
- (IBAction)onRequestInterstitialFromVungle:(id)sender;

@end
