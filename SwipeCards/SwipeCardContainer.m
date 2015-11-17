//
//  SwipeCardContainer.m
//  SwipeCards
//
//  Created by Stuart Farmer on 11/17/15.
//  Copyright © 2015 Stuart Farmer. All rights reserved.
//

#import "SwipeCardContainer.h"

#define BUTTONWIDTH 80
#define BUTTONHEIGHT 20

@implementation SwipeCardContainer {
    UIButton *button;
    CGPoint startingPoint;
    float totalDistance;
}

-(void)didMoveToWindow {
    // Draw everything
    button = [[UIButton alloc] initWithFrame:CGRectMake(self.center.x-(BUTTONWIDTH/2), self.center.y-(BUTTONHEIGHT/2), BUTTONWIDTH, BUTTONHEIGHT)];
    button.titleLabel.text = @"Something";
    button.backgroundColor = [UIColor grayColor];
    [self addSubview:button];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Get the starting touch
    UITouch *touch = [touches anyObject];
    startingPoint = [touch locationInView:self];

    // Restart the total distance
    totalDistance = 0;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Move the button (or view in this case) to the amount dragged on the screen
    CGPoint newPoint = [[touches anyObject] locationInView:self];
    CGPoint difference = CGPointSubtract(newPoint, startingPoint);
    button.center = CGPointAdd(button.center, difference);
    startingPoint = newPoint;
    NSLog(@"%f", CGPointGetDistance(newPoint, startingPoint));
    // Add distance to total distance
    totalDistance += CGPointGetDistance(newPoint, startingPoint);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%f", totalDistance);
}

@end