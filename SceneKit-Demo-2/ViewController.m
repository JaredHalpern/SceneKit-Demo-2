//
//  ViewController.m
//  SceneKit-Demo-2
//
//  Created by Jared Halpern on 11/29/15.
//  Copyright © 2015 Jared Halpern. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.sceneView = [[SCNView alloc] initWithFrame:self.view.frame];
  self.sceneView.scene = [SCNScene scene];
  [self.view addSubview:self.sceneView];
  
  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneTapped:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;
  tapGestureRecognizer.numberOfTouchesRequired = 1;
  [self.sceneView addGestureRecognizer:tapGestureRecognizer];
  
  SCNFloor *groundGeometry = [SCNFloor floor];
  groundGeometry.reflectivity = 0;
  SCNMaterial *groundMaterial = [SCNMaterial material];
  groundMaterial.diffuse.contents = [UIColor blueColor];
  groundGeometry.materials = @[groundMaterial];
  self.groundNode = [SCNNode nodeWithGeometry:groundGeometry];
  
  SCNCamera *camera = [SCNCamera camera];
  camera.zFar = 10000;
  
  self.cameraNode = [SCNNode node];
  self.cameraNode.camera = camera;
  self.cameraNode.position = SCNVector3Make(-20, 15, 20);
  
  SCNLookAtConstraint *constraint = [SCNLookAtConstraint lookAtConstraintWithTarget:self.groundNode];
  constraint.gimbalLockEnabled = YES;
  self.cameraNode.constraints = @[constraint];
  
  SCNLight *ambientLight = [SCNLight light];
  ambientLight.color = [UIColor darkGrayColor];
  ambientLight.type = SCNLightTypeAmbient;
  self.cameraNode.light = ambientLight;
  
  SCNLight *spotLight = [SCNLight light];
  spotLight.type = SCNLightTypeSpot;
  spotLight.castsShadow = YES;
  spotLight.spotInnerAngle = 70.0;
  spotLight.spotOuterAngle = 90.0;
  spotLight.zFar = 500;
  
  self.lightNode = [SCNNode node];
  self.lightNode.light = spotLight;
  self.lightNode.position = SCNVector3Make(0, 25., 25.);
  self.lightNode.constraints = @[constraint];
  
  SCNSphere *sphereGeometry = [SCNSphere sphereWithRadius:1.5];
  SCNMaterial *sphereMaterial = [SCNMaterial material];
  sphereMaterial.diffuse.contents = [UIColor greenColor];
  sphereGeometry.materials = @[sphereMaterial];
  self.sphere1Node = [SCNNode nodeWithGeometry:sphereGeometry];
  self.sphere1Node.position = SCNVector3Make(-5, 1.5, 0);
  self.sphere2Node = [SCNNode nodeWithGeometry:sphereGeometry];
  self.sphere2Node.position = SCNVector3Make(5, 1.5, 0);

  SCNBox *buttonGeometry = [SCNBox boxWithWidth:4 height:1 length:4 chamferRadius:0];
  SCNMaterial *buttonMaterial = [SCNMaterial material];
  buttonMaterial.diffuse.contents = [UIColor redColor];
  buttonGeometry.materials = @[buttonMaterial];
  self.buttonNode = [SCNNode nodeWithGeometry:buttonGeometry];
  self.buttonNode.position = SCNVector3Make(-5, 0, 8);
  
  [self.sceneView.scene.rootNode addChildNode:self.cameraNode];
  [self.sceneView.scene.rootNode addChildNode:self.groundNode];
  [self.sceneView.scene.rootNode addChildNode:self.lightNode];
  [self.sceneView.scene.rootNode addChildNode:self.buttonNode];
  [self.sceneView.scene.rootNode addChildNode:self.sphere1Node];
  [self.sceneView.scene.rootNode addChildNode:self.sphere2Node];
  
}

- (void)sceneTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.sceneView];
    NSArray *hitResults = [self.sceneView hitTest:location options:nil];
    if (hitResults.count > 0) {
        SCNHitTestResult *hitTestResult = (SCNHitTestResult *)hitResults[0];
        SCNNode *node = hitTestResult.node;

      if (node == self.buttonNode) {
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        SCNMaterial *material = node.geometry.materials[0];
        material.diffuse.contents = [UIColor whiteColor];
        [SCNTransaction commit];
        
        SCNAction *action = [SCNAction moveBy:SCNVector3Make(0, -0.8, 0) duration:0.5];
        [node runAction:action];
      }
      
    }
    
}

@end
