//
//  ICRegisterViewController.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 23/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICRegisterViewController.h"
#import "CardIO.h"
#import "UITextFieldLimit.h"

@interface ICRegisterViewController ()
@property (strong, nonatomic) NSString *completeCardNumber;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UITextFieldLimit *nameTextField;
@property (weak, nonatomic) IBOutlet UITextFieldLimit *mailTextField;
@property (weak, nonatomic) IBOutlet UITextFieldLimit *cellphoneTextField;
@property (weak, nonatomic) IBOutlet UITextFieldLimit *cardNumberTextField;

//@property (weak, nonatomic) IBOutlet UITextField *userCredCardTextField;
@end

@implementation ICRegisterViewController

#define USER_NAME_MAX_LENGTH 100
#define USER_MAIL_MAX_LENGTH 100
#define USER_CELLPHONE_MAX_LENGTH 11
#define USER_CARDNUMBER_MAX_LENGTH 20

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //altera a cor da barra de navegacao
    //fonte:http://stackoverflow.com/questions/20129924/how-to-change-the-background-color-of-navigationbar-in-ios-7
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    //habilita ou desabilita o botao para se registrar de acordo com o preenchimento dos campos
    self.registerButton.enabled = [self isFullFilled];
    
    //limita a quantidade de caracteres dos campos
    [_nameTextField setLimit:USER_NAME_MAX_LENGTH];
    [_mailTextField setLimit:USER_MAIL_MAX_LENGTH];
    [_cellphoneTextField setLimit:USER_CELLPHONE_MAX_LENGTH];
    [_cardNumberTextField setLimit:USER_CARDNUMBER_MAX_LENGTH];
    
    
    //retira o texto do botão back
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanCardButton:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (IBAction)registerButton:(id)sender {
 
}

- (IBAction)agreeButon:(id)sender {
    if ([self.agreeButton.currentImage  isEqual:[UIImage imageNamed:@"CheckBoxOff"]]) {
        [self.agreeButton setImage:[UIImage imageNamed:@"CheckBoxOn"]
                          forState:UIControlStateNormal];
        self.registerButton.enabled = [self isFullFilled];
    }else{
        [self.agreeButton setImage:[UIImage imageNamed:@"CheckBoxOff"]
                          forState:UIControlStateNormal];
        self.registerButton.enabled = [self isFullFilled];
    }
    
}

#pragma mark - card scan methods

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    self.cardNumberTextField.text = info.redactedCardNumber;
    self.completeCardNumber = info.cardNumber;
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - other methods
- (BOOL)isFullFilled{
    if ([self.agreeButton.currentImage  isEqual:[UIImage imageNamed:@"CheckBoxOff"]]
        || [self.nameTextField.text isEqualToString:@""]
        || [self.mailTextField.text isEqualToString:@""]
        || [self.cellphoneTextField.text isEqualToString:@""]
        || [self.cardNumberTextField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

#pragma mark - TextFields events
- (IBAction)nameEdited:(id)sender {
    self.registerButton.enabled = [self isFullFilled];
}

- (IBAction)mailEdited:(id)sender {
    self.registerButton.enabled = [self isFullFilled];
}

- (IBAction)cellPhoneEdited:(id)sender {
    self.registerButton.enabled = [self isFullFilled];
}

- (IBAction)cardNumberEdited:(id)sender {
    self.registerButton.enabled = [self isFullFilled];
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