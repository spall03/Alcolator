//
//  ViewController.m
//  Alcolator
//
//  Created by Stephen Palley on 12/11/14.
//  Copyright (c) 2014 Steve Palley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}

-(void)loadView
{
    self.view = [[UIView alloc]init]; //this is the main view that everything else fits into
    
    UITextField *textField = [[UITextField alloc]init]; //for entering beer alc %
    UISlider *slider = [[UISlider alloc]init]; //for controlling # of beers
    UILabel *beers = [[UILabel alloc]init]; //for displaying # of beers
    UILabel *label = [[UILabel alloc]init]; //for displaying result (# of wine glasses)
    UIButton *button = [[UIButton alloc]init]; //for initiating calculation
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init]; //for removing keyboard
    
    //add all of these UI elements as subviews of the main screen
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:beers];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //connect UI elements to properties so that the program can receive user input
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.beerLabel = beers;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; 
    //self.title = NSLocalizedString(@"Wine", @"Wine");
    
    
    
    self.beerPercentTextField.delegate = self; //this instance of viewDidLoad is the text field's delegate, meaning it can respond to the text field's default behavior (text entry)
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer Percent Placeholder Text"); //set default text for text field
    
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged]; //connects IBAction manually, meaning that when the slider's value is changed, sliderValueDidChange gets fired
    self.beerCountSlider.minimumValue = 1; //sets minimum and maximum values for the slider
    self.beerCountSlider.maximumValue = 10;
    
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside]; //connects button press to method
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate", @"Calculate command") forState:UIControlStateNormal]; //set button title
    
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)]; //calls tap method when tap detected
    
    self.beerLabel.numberOfLines = 0;
    self.beerLabel.text = @"1 beer"; //the app starts on one beer by default
    
    self.resultLabel.numberOfLines = 0; //no maximum number of lines for resultlabel
    
    //now we're going to clean up the UI's colors and fonts
    
    self.resultLabel.backgroundColor = [UIColor cyanColor];
    //self.resultLabel.alpha = .1;
    self.resultLabel.textColor = [UIColor redColor];
    self.resultLabel.font = [UIFont fontWithName:@"Courier" size:20];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    self.calculateButton.backgroundColor = [UIColor blackColor];
    
    self.beerLabel.textAlignment = NSTextAlignmentCenter;
    self.beerLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    
    self.beerPercentTextField.backgroundColor = [UIColor lightGrayColor];
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect viewRect = self.view.frame;
    
    //UI dimensions
    CGFloat viewWidth = viewRect.size.width; //allows UI to resize properly
    CGFloat viewHeight = viewRect.size.height;
    CGFloat topOffset = 60;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = viewHeight / 12;
    
    self.beerPercentTextField.frame = CGRectMake(padding, topOffset, itemWidth, itemHeight); //0,0 is top left corner of the screen
    
    //place the rest of the subviews relative to the text field
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.beerLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfBeerLabel = CGRectGetMaxY(self.beerLabel.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfBeerLabel + padding, itemWidth, itemHeight * 2);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender
{
    NSString *enteredText = sender.text;
    float enteredValue = [enteredText floatValue];
    
    if (enteredValue == 0)
    {
        sender.text = nil;
    }

}

- (void)sliderValueDidChange:(UISlider *)sender
{
    NSLog(@"Slider value changed to %f", sender.value);
    
    int numberOfBeers = self.beerCountSlider.value;
    NSString *beerText;
    
    if (numberOfBeers == 1)
    {
        beerText = @"beer";
    }
    else
    {
        beerText = @"beers";
    }
    
    NSString *resultText = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    self.beerLabel.text = resultText;
    
    
    //self.beerNumberLabel.text
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]]; //update badge in tab bar with number of beers

}

- (void)buttonPressed:(UIButton *)sender
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesOfBeerInAGlass = 12;
    
    float alcPercentageOfBeer = [self.beerPercentTextField.text floatValue]/100;
    float ouncesOfAlcoholPerBeer = ouncesOfBeerInAGlass * alcPercentageOfBeer;
    float totalOuncesOfAlcohol = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;
    float alcPercentageOfWine = .13;
    float ouncesOfAlcoholInOneWineGlass = ouncesInOneWineGlass * alcPercentageOfWine;
    
    float numberOfWineGlassesForEquivalentAlcoholAmount = totalOuncesOfAlcohol / ouncesOfAlcoholInOneWineGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1)
    {
        beerText = NSLocalizedString(@"beer contains", @"singular beer");
    }
    else
    {
        beerText = NSLocalizedString(@"beers contain", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1)
    {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    else
    {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
    
    self.title = [NSString stringWithFormat:(@"Wine (%.1f %@)"), numberOfWineGlassesForEquivalentAlcoholAmount, wineText];

}
- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender
{
    [self.beerPercentTextField resignFirstResponder];

}

@end
