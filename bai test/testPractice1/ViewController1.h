//
//  ViewController1.h
//  testPractice1
//
//  Created by binh on 3/22/18.
//  Copyright © 2018 binh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connector.h"

@interface ViewController1 : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl;

@property (nonatomic,strong)Connector *connectorClass;

@end
