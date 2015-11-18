//
//  SwipeCardContainer.m
//  SwipeCards
//
//  Created by Stuart Farmer on 11/17/15.
//  Copyright © 2015 Stuart Farmer. All rights reserved.
//

#import "SwipeCardContainer.h"

#define VIEWWIDTH 80
#define VIEWHEIGHT 20

#define DISTANCETHRESHOLD 50
#define ANGLETHRESHOLD 50

#define CARDMARGIN 20

@implementation SwipeCardContainer {
    SwipeCard *swipeView;
    CGPoint startingPoint;
    CGPoint firstPoint;
    CGPoint currentPoint;
    CGPoint upVector;
    float totalDistance;
}

-(void)didMoveToWindow {
    
    self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:246.0f/255.0f blue:200.0f/255.0f alpha:1];
    // Set upVector for comparing angles against
    upVector.x = 0;
    upVector.y = 1;
    
    // Draw everything
    swipeView = [[SwipeCard alloc] initWithFrame:CGRectMake(CARDMARGIN, CARDMARGIN, self.frame.size.width-(CARDMARGIN*2), self.frame.size.height-(CARDMARGIN*2))];
    swipeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:swipeView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Get the starting touch
    UITouch *touch = [touches anyObject];
    startingPoint = swipeView.center;
    firstPoint = [touch locationInView:self];
    currentPoint = [touch locationInView:self];

    // Reset the total distance
    totalDistance = 0;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Move the view (or view in this case) to the amount dragged on the screen
    CGPoint newPoint = [[touches anyObject] locationInView:self];
    CGPoint difference = CGPointSubtract(newPoint, currentPoint);
    swipeView.center = CGPointAdd(swipeView.center, difference);
    
    // Color UI elements if view is within valid zone
    if ([self viewIsWithinValidZone:swipeView]) {
        // Add delegate method here
        swipeView.backgroundColor = [UIColor greenColor];
    } else {
        // Add delegate method here
        swipeView.backgroundColor = [UIColor whiteColor];
    }
    
    // Set current point to new point
    currentPoint = newPoint;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Check if the view is in valid zone
    if ([self viewIsWithinValidZone:swipeView]) {
        // Add delegate method here
        NSLog(@"It's good!");
    } else {
        // Add delegate method here
        NSLog(@"It's bad...");
    }
    
    // Animate view away
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint difference = CGPointSubtract(swipeView.center, startingPoint);
        CGPoint multiple = CGPointMultiply(difference, 10);
        swipeView.center = CGPointAdd(swipeView.center, multiple);
        swipeView.alpha = 0;
    } completion:^(BOOL finished) {
         // Reset the view
        swipeView.center = startingPoint;
        swipeView.alpha = 1;
        swipeView.backgroundColor = [UIColor whiteColor];
    }];
}

-(BOOL)viewIsWithinValidZone:(UIView *)view {
    // Calculate the current angle
    CGPoint distanceFromStartingPoint = CGPointSubtract(startingPoint, view.center);
    CGFloat angle = CGPointGetAngleBetween(distanceFromStartingPoint, upVector) * (180 / M_PI);
    
    // Color view appropriately if it is within the 'good' zone
    if (angle < ANGLETHRESHOLD && CGPointGetDistance(startingPoint, view.center) > DISTANCETHRESHOLD) return true;
    else return false;
}

@end