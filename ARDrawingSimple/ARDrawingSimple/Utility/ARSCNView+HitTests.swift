//
//  ARSCNView+HitTests.swift
//  ARDrawingSimple
//
//  Created by HanGyo Jeong on 06/01/2019.
//  Copyright © 2019 HanGyoJeong. All rights reserved.
//

import Foundation
import ARKit

extension ARSCNView{
    func setUp(){
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = false
        
        preferredFramesPerSecond = 60
        contentScaleFactor = 1.3
        
        if let camera = pointOfView?.camera{
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = -1
            camera.minimumExposure = -1
            camera.maximumExposure = 3
        }
    }
}
