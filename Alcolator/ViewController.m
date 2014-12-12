//
//  ViewController.m
//  Alcolator
//
//  Created by Stephen Palley on 12/11/14.
//  Copyright (c) 2014 Steve Palley. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *beerNumberLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    NSString *enteredText = sender.text;
    float enteredValue = [enteredText floatValue];
    
    if (enteredValue == 0)
    {
        sender.text = nil;
    }

}

- (IBAction)sliderValueDidChange:(UISlider *)sender
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
    
    self.beerNumberLabel.text = resultText;
    
    
    //self.beerNumberLabel.text
    [self.beerPercentTextField resignFirstResponder];

}

- (IBAction)buttonPressed:(UIButton *)sender
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
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
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
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;

}
- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender
{
    [self.beerPercentTextField resignFirstResponder];

}

@end
