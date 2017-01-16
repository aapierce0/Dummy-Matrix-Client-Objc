//
//  ViewController.m
//  Dummy-Matrix-Client-Objc
//
//  Created by Avery Pierce on 1/16/17.
//  Copyright © 2017 Matrix. All rights reserved.
//

#import "ViewController.h"
#import <MatrixSDK/MatrixSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = @"Loading...";
    
    // Load the public rooms on https://matrix.org
    MXRestClient* client = [[MXRestClient alloc] initWithHomeServer:@"https://matrix.org" andOnUnrecognizedCertificateBlock:nil];
    [client publicRooms:^(NSArray *rooms) {
        self.textView.text = @"";
        
        // Append a line in the text view for each room in the list.
        [rooms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MXPublicRoom *room = obj;
            
            NSString *currentString = self.textView.text;
            if (currentString == nil) { currentString = @""; }
            
            self.textView.text = [currentString stringByAppendingFormat:@"%@\n", room.name];
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
