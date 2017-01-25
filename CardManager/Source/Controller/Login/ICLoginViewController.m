//
//  ICLoginViewController.m
//  CardManager
//
//  Created by Luiz Claudio Vasconcellos Oliveira on 23/09/16.
//  Copyright © 2016 Itaú Card. All rights reserved.
//

#import "ICLoginViewController.h"
#import "UITextFieldLimit.h"
#import "ICValidateStringBO.h"
#import "ICTestNetworkConnectionProvider.h"
#import "ICLoginManager.h"

@interface ICLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextFieldLimit *userMailTextField;
@property (weak, nonatomic) IBOutlet UITextFieldLimit *userPasswordTextField;
@property (strong, nonatomic) ICLoginManager *manager;

@property (strong, nonatomic) ICUser *loggedUser;


@end

@implementation ICLoginViewController


#define USER_MAIL_MAX_LENGTH 100
#define USER_PASSWORD_MAX_LENGTH 6


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //limita a quantidade de caracteres dos campos
    [_userMailTextField setLimit:USER_MAIL_MAX_LENGTH];
    [_userPasswordTextField setLimit:USER_PASSWORD_MAX_LENGTH];
    
    //retira o texto do botão back
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
    //altera a cor do placeholder dos textfields
    [self.userMailTextField setValue:[UIColor whiteColor]
                          forKeyPath:@"_placeholderLabel.textColor"];
    [self.userPasswordTextField setValue:[UIColor whiteColor]
                          forKeyPath:@"_placeholderLabel.textColor"];
}

//exibe e esconde a barra na tela de login
// fonte: http://stackoverflow.com/questions/845583/iphone-hide-navigation-bar-only-on-first-page
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

#pragma mark - Getters/Setters
- (ICLoginManager *)manager {
    if (!_manager) {
        _manager = [ICLoginManager new];
    }
    
    return _manager;
}

- (ICUser *)currentUser {
    return self.loggedUser;
}

//- (NSString *)userText {
//    NSString *user = self.userMailTextField.text;
//    
//    return user;
//}
//
//- (NSString *)passwordText {
//    NSString *password = self.userPasswordTextField.text;
//    
//    return password;
//}



#pragma mark - Action
- (IBAction)loginButton:(id)sender {
    
    //valida se os campos foram preenchidos
    if(![self validateFields]){
        return;
    }
    
    //valida se o dispositivo esta conectado a internet
    if (![self validateNetworkConnection]){
        return;
    }
    
    //TODO:: fazer loading.
    
    //TODO:: acessar o serviço.
    [self loginWithUsername:self.userMailTextField.text password:self.userPasswordTextField.text];
    
    //TODO:: carregar os dados recebidos em memória ( userDefaults ).
    
    //TODO:: exibir erro, se o servico der erro.
    
    //TODO:: direcionar para a tela principal do aplicativo.
}


#pragma mark - other methods
-(BOOL) validateFields{
    if ([self.userMailTextField.text isEqualToString:@""] || [self.userPasswordTextField.text isEqualToString:@""]){
        UIAlertController *blankFieldsAlertControler = [UIAlertController alertControllerWithTitle:@"Card Manager"
                                                                                           message:@"Favor informar e-mail e senha."
                                                                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButtonBlankFieldsAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                 style:UIAlertActionStyleDefault
                                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                                   [self dismissViewControllerAnimated:YES completion:nil];
                                                                               }];
        [blankFieldsAlertControler addAction:okButtonBlankFieldsAlertAction];
        [self presentViewController:blankFieldsAlertControler animated:YES completion:nil];
        return NO;
    } else if (![ICValidateStringBO isValidMailType:_userMailTextField.text]){
        //alerta para caso o e-mail não seja um padrao valido
        UIAlertController *validateMailFieldsAlertControler = [UIAlertController alertControllerWithTitle:@"Card Manager"
                                                                                                  message:@"campos inválidos, verifique e tente novamente"//@"Favor informar um e-mail válido"
                                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButtonValidateMailFieldsAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                        style:UIAlertActionStyleDefault
                                                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                                                      }];
        [validateMailFieldsAlertControler addAction:okButtonValidateMailFieldsAlertAction];
        [self presentViewController:validateMailFieldsAlertControler animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(BOOL) validateNetworkConnection{
    if (![ICTestNetworkConnectionProvider isNetworkAvailable]) {
        //alerta que nao tem conexao
        UIAlertController *validateNetworkConnectionAlertControler = [UIAlertController alertControllerWithTitle:@"Card Manager"
                                                                                                         message:@"não há conexão com a internet, por favor tente mais tarde."
                                                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButtonValidateNetworkConnectionAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                               style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                                                             }];
        [validateNetworkConnectionAlertControler addAction:okButtonValidateNetworkConnectionAlertAction];
        [self presentViewController:validateNetworkConnectionAlertControler animated:YES completion:nil];
        return NO;
    }
    return YES;
}


- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    typeof(self) __weak __block weakSelf = self;
    //[self.mainView showLoadingView:YES];
    
    [self.manager loginWithUsername:username password:password withCompletionBlock:^(ICUser *user, BOOL success) {
        [weakSelf handleLoginResponse:success withUser:user];
    }];
}

- (void)handleLoginResponse:(BOOL)status withUser:(ICUser *)user {
    //[self.mainView showLoadingView:NO];
    
    if (status) {
        self.loggedUser = user;
        //[self performSegueWithIdentifier:kFromLoginViewToWelcomeViewSegue sender:nil];
        UIAlertController *validateNetworkConnectionAlertControler = [UIAlertController alertControllerWithTitle:@"Card Manager"
                                                                                                         message:@"logado!!!"
                                                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButtonValidateNetworkConnectionAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                               style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                                                             }];
        [validateNetworkConnectionAlertControler addAction:okButtonValidateNetworkConnectionAlertAction];
        [self presentViewController:validateNetworkConnectionAlertControler animated:YES completion:nil];
    } else {
        UIAlertController *validateNetworkConnectionAlertControler = [UIAlertController alertControllerWithTitle:@"Card Manager"
                                                                                                         message:@"ocorreu um erro ao tentar se conectar, tente novamente mais tarde."
                                                                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButtonValidateNetworkConnectionAlertAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                               style:UIAlertActionStyleDefault
                                                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                                                             }];
        [validateNetworkConnectionAlertControler addAction:okButtonValidateNetworkConnectionAlertAction];
        [self presentViewController:validateNetworkConnectionAlertControler animated:YES completion:nil];
    }
}



@end
