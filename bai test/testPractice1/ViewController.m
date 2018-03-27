//
//  ViewController.m
//  testPractice1
//
//  Created by binh on 3/21/18.
//  Copyright © 2018 binh. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "Service.h"

// class User
@implementation User
@synthesize firstName,lastName;
-(id)init:(NSDictionary *)dict{
    firstName = [dict objectForKey:@"firstname"];
    lastName = [dict objectForKey:@"lastname"];
    return self;
}
@end

@implementation ViewController
@synthesize userName,password;
@synthesize fullName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    userName.text = @"test%40simicart.com";
    password.text = @"123456";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)handleButton:(id)sender {
    // replace charactor url
    NSString *url = @"http://dev-magento19.jajahub.com/simiconnector/rest/v2/customers/login?email=[thisIsemail]&is_demo=1&password=[thisIsPassWord]";
    url = [url stringByReplacingOccurrencesOfString:@"[thisIsemail]" withString:userName.text];
    url = [url stringByReplacingOccurrencesOfString:@"[thisIsPassWord]" withString:password.text];
    // get data
    [Service getData:url block:^(NSDictionary *dict) {
        NSDictionary *customer = [dict objectForKey:@"customer"];
        User *user = [[User alloc]init:customer];
        fullName = [[NSString alloc] initWithFormat:@"%@ %@", user.firstName,user.lastName];
        // send data to connector class
        Connector *connectorClass = [[Connector alloc] init];
        connectorClass.stringToPass = fullName;
        // check user availble
        if (user.firstName.length != 0) {
            ViewController1 *vc1 = [[ViewController1 alloc]init];
            vc1.connectorClass = connectorClass;
            [self.navigationController pushViewController:vc1 animated:true];
        }else{
            [self.view makeToast:@"invalid email or password"];
        }
    }];
}

// handle when keyboard show or hide
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // check device landscape portrait
    if ([[UIDevice currentDevice]orientation] != UIInterfaceOrientationPortrait){
        [UIView animateWithDuration:0.25 animations:^{
            [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
        }];
//        [self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait];
    }
}

// this should go off
-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}

// valid email
@end
@implementation NSString (emailValidation) // need this implementation
-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
@end

