//
//  ViewController.m
//  ARSimpleClub
//
//  Created by HanGyo Jeong on 25/12/2018.
//  Copyright © 2018 HanGyoJeong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) SCNScene *scene;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) BOOL planeFound;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupLabel];
    [self setupSceneView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupScene];
    [self startSession];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)setupLabel{
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.text = @"Please Find a Dance Floor";
}

- (void)setupSceneView{
    self.sceneView.delegate = self;
    self.sceneView.autoenablesDefaultLighting = YES;
}

- (void)setupScene{
    self.scene = [SCNScene new];
    self.sceneView.scene = self.scene;
}

- (void)startSession{
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    configuration.planeDetection = ARWorldAlignmentGravityAndHeading;
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)showDiscoBallWithAnchor:(ARPlaneAnchor *)anchor onNode:(SCNNode *)node{
    SCNNode *plane = [self planeFromAnchor:anchor];
    SCNNode *discoBall = [self discoBall:plane];
    
    [plane addChildNode:discoBall];
    [node addChildNode:plane];
}

#pragma mark - ARSCNViewDelegate
/*
 Tells the delegate that a SceneKit node corresponding to a new AR anchor has been added to the scene
 */
- (void)renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor{
    if(self.planeFound == NO){
        if([anchor isKindOfClass:[ARPlaneAnchor class]]){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.planeFound = YES;
                self.statusLabel.text = @"DANCEFLOOR FOUND!!!";
                
                ARPlaneAnchor *placeAnchor = (ARPlaneAnchor *)anchor;
                [self showDiscoBallWithAnchor:placeAnchor onNode:node];
            });
        }
    }
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

#pragma marker - Node Builders
- (SCNNode *)planeFromAnchor:(ARPlaneAnchor *)anchor{
    SCNPlane *plane = [SCNPlane planeWithWidth:anchor.extent.x height:anchor.extent.z];
    plane.firstMaterial.diffuse.contents = [UIColor clearColor];
    
    SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
    planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    planeNode.transform = SCNMatrix4MakeRotation(-M_PI * 0.5, 1, 0, 0);
    
    return planeNode;
}

- (SCNNode *)discoBall:(SCNNode *)node{
    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.1];
    sphere.firstMaterial.diffuse.contents = [UIImage imageNamed:@"disco"];
    
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    //sphereNode.position = SCNVector3Make(0, 0, 3);
    sphereNode.position = node.position;
    return sphereNode;
}

@end
