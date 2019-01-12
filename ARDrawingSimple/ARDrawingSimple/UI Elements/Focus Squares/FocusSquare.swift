//
//  FocusSquare.swift
//  ARDrawingSimple
//
//  Created by HanGyo Jeong on 06/01/2019.
//  Copyright © 2019 HanGyoJeong. All rights reserved.
//

import Foundation
import ARKit

class FocusSquare: SCNNode
{
    // MARK: - Focus Square Configuration Properties
    
    // Original size of the focus square in m.
    private let focusSquareSize: Float = 0.17
    
    // Thickness of the focus square lines in m.
    private let focusSquareThickness: Float = 0.018
    
    // Scale factor for the focus square when it is closed, w.r.t. the original size.
    private let scaleForClosedSquare: Float = 0.97
    
    // Side length of the focus square segments when it is open (w.r.t. to a 1x1 square).
    private let sideLengthForOpenSquareSegments: CGFloat = 0.2
    
    // Duration of the open/close animation
    private let animationDuration = 0.7
    
    // Color of the focus square
    static let primaryColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1) // base yellow
    static let primaryColorLight = #colorLiteral(red: 1, green: 0.9254901961, blue: 0.4117647059, alpha: 1) // light yellow
    
    // For scale adapdation based on the camera distance, see the `scaleBasedOnDistance(camera:)` method.
    
    // MARK: - Position Properties
    
    var lastPositionOnPlane: float3?
    var lastPosition: float3?
    
    // MARK: - Other Properties
    
    private var isOpen = false
    private var isAnimating = false
    
    // use average of recent positions to avoid jitter
    private var recentFocusSquarePositions: [float3] = []
    private var anchorsOfVisitedPlanes: Set<ARAnchor> = []
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        self.opacity = 0.0
        self.addChildNode(focusSquareNode)
        open()
    }
    
    private func open(){
        
    }
    
    private lazy var focusSquareNode: SCNNode = {
        /*
         The focus square consists of eight segments as follows, which can be individually animated.
         
         s1  s2
         _   _
         s3 |     | s4
         
         s5 |     | s6
         -   -
         s7  s8
         */
        let s1 = Segment(name: "s1", corner: .topLeft, alignment: .horizontal)
        let s2 = Segment(name: "s2", corner: .topRight, alignment: .horizontal)
        let s3 = Segment(name: "s3", corner: .topLeft, alignment: .vertical)
        let s4 = Segment(name: "s4", corner: .topRight, alignment: .vertical)
        let s5 = Segment(name: "s5", corner: .bottomLeft, alignment: .vertical)
        let s6 = Segment(name: "s6", corner: .bottomRight, alignment: .vertical)
        let s7 = Segment(name: "s7", corner: .bottomLeft, alignment: .horizontal)
        let s8 = Segment(name: "s8", corner: .bottomRight, alignment: .horizontal)
    }
}
