//
//  ViewController.m
//  MyFlutter
//
//  Created by lizihong on 2020/1/21.
//  Copyright © 2020 AL. All rights reserved.
//

#import "ViewController.h"
@import Flutter;
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showFlutter:(id)sender {
    FlutterEngine *flutterEngine =
    ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    //FlutterViewController *flutterViewController = [FlutterViewController new];
    //[flutterViewController setInitialRoute:@"/route1"];
    //[flutterViewController pushRoute:@"/route1"];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

@end
