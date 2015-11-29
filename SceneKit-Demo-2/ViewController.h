//
//  ViewController.h
//  SceneKit-Demo-2
//
//  Created by Jared Halpern on 11/29/15.
//  Copyright © 2015 Jared Halpern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) SCNView *sceneView;
@property (nonatomic, strong) SCNNode *cameraNode;
@property (nonatomic, strong) SCNNode *groundNode;
@property (nonatomic, strong) SCNNode *lightNode;
@property (nonatomic, strong) SCNNode *buttonNode;
@property (nonatomic, strong) SCNNode *sphere1Node;
@property (nonatomic, strong) SCNNode *sphere2Node;

@end

