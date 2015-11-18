//
//  SwipeCard.m
//  SwipeCards
//
//  Created by Stuart Farmer on 11/17/15.
//  Copyright © 2015 Stuart Farmer. All rights reserved.
//

#import "SwipeCard.h"

@implementation SwipeCard

-(void)didMoveToWindow {
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.superview.frame.size.width-20, self.superview.frame.size.height-20)];
    self.testLabel.text = @"Hello!";
}

@end
