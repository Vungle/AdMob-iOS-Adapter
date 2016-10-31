//
//  OptionsViewController.m
//  VungleRewardBasedVideo
//
//  Created by Admin on 9/26/16.
//  Copyright © 2016 Vungle. All rights reserved.
//

#import "OptionsViewController.h"

NSString * const kVungleOptionUserId = @"userId";
NSString * const kVungleOptionMuted = @"muted";

@interface OptionsViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *userId;
@property (nonatomic, weak) IBOutlet UISwitch *mute;

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userId.text = [defaults stringForKey:kVungleOptionUserId];
    self.mute.on = [defaults boolForKey:kVungleOptionMuted];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userId.text forKey:kVungleOptionUserId];
    [defaults setBool:self.mute.on forKey:kVungleOptionMuted];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
