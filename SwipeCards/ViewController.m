//
//  ViewController.m
//  SwipeCards
//
//  Created by Stuart Farmer on 11/17/15.
//  Copyright © 2015 Stuart Farmer. All rights reserved.
//

#import "ViewController.h"
#import "SwipeCardContainer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SwipeCardContainer *container = [[SwipeCardContainer alloc] initWithFrame:self.view.frame];
    [self.view addSubview:container];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
