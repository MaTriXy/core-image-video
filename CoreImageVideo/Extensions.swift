//
//  Extensions.swift
//  CoreImageVideo
//
//  Created by Chris Eidhof on 03/04/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import AVFoundation

extension CGAffineTransform {
    
    init(rotatingWithAngle angle: CGFloat) {
        let t = CGAffineTransform(rotationAngle: angle)
        self.init(a: t.a, b: t.b, c: t.c, d: t.d, tx: t.tx, ty: t.ty)
        
    }
    init(scaleX sx: CGFloat, scaleY sy: CGFloat) {
        let t = CGAffineTransform(scaleX: sx, y: sy)
        self.init(a: t.a, b: t.b, c: t.c, d: t.d, tx: t.tx, ty: t.ty)
        
    }
    
    func scale(sx: CGFloat, sy: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(scaleX: sx, y: sy)
    }
    func rotate(angle: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: angle)
    }
}

extension CIImage {
    convenience init(buffer: CMSampleBuffer) {
        self.init(cvPixelBuffer: CMSampleBufferGetImageBuffer(buffer)!)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension AVCaptureDevice.Position {
    var transform: CGAffineTransform {
        switch self {
        case .front:
            return CGAffineTransform(rotatingWithAngle: -CGFloat(Double.pi/2)).scale(sx: 1, sy: -1)
        case .back:
            return CGAffineTransform(rotatingWithAngle: -CGFloat(Double.pi/2))
        default:
            return .identity
            
        }
    }
    
    var device: AVCaptureDevice? {
        return AVCaptureDevice.devices(for: AVMediaType.video).filter {
            $0.position == self
            }.first as? AVCaptureDevice
    }
}
