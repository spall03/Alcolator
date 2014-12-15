//
//  MainMenuViewController.m
//  Alcolator
//
//  Created by Stephen Palley on 12/15/14.
//  Copyright (c) 2014 Steve Palley. All rights reserved.
//

#import "MainMenuViewController.h"
#import "WhiskeyViewController.h"
#import "ViewController.h"

@interface MainMenuViewController ()

@property (nonatomic, strong) UIButton *wineButton;
@property (nonatomic, strong) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void)loadView
{
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem]; //create system-type buttons for the two choices
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine") forState:UIControlStateNormal]; //set button titles
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside]; //link buttons to action calls when touched by user
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = [[UIView alloc]init]; //new main view for this screen
    [self.view addSubview:self.wineButton]; //add buttons to main view
    [self.view addSubview:self.whiskeyButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
    
}

- (void)viewWillLayoutSubviews
{
 
    [super viewWillLayoutSubviews];
    
    CGRect wineButtonFrame, whiskeyButtonFrame;
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge); //chop the main view in half and put a button in each half
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
    
}

- (void) winePressed:(UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init]; //create a new wine page
    [self.navigationController pushViewController:wineVC animated:YES]; //"link" to that page
}

- (void) whiskeyPressed:(UIButton *) sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init]; //create a new whiskey page
    [self.navigationController pushViewController:whiskeyVC animated:YES]; //"link" to that page
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
