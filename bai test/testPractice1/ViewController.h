//
//  ViewController.h
//  testPractice1
//
//  Created by binh on 3/21/18.
//  Copyright © 2018 binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connector.h"
#import <Toast/Toast.h>
#import "UIView+Toast.h"


@interface User:NSObject
@property NSString *firstName;
@property NSString *lastName;

-(id)init:(NSDictionary*)dict;

@end

@interface NSString (emailValidation)
- (BOOL)isValidEmail;
@end


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSString *fullName;
@property(nonatomic,strong)Connector *connectorClass;
- (IBAction)handleButton:(id)sender;
@end








