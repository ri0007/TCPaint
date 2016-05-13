//
//  CanvasView.swift
//  TCPaint
//
//  Created by 井上 龍一 on 2016/05/13.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

protocol  CanvasViewDelegate: class {
    func didDrawLine(sender: CanvasView)
}

class CanvasView: UIImageView {
    let canvasModel = CanvasModel.sharedInstance
    var bezierPath: UIBezierPath!
    var penWidth: CGFloat = 5.0
    var penColor = UIColor.blackColor()
    var lastTouchPoint: CGPoint!
    var lastDrawImage: UIImage!
    
    weak var delegate: CanvasViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .ScaleAspectFill
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let currentPoint = touches.first?.locationInView(self) else{
            return
        }
        
        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = .Round
        bezierPath.lineWidth = penWidth
        bezierPath.moveToPoint(currentPoint)
        
        lastTouchPoint = currentPoint;
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard bezierPath != nil else{
            return;
        }
        
        guard let currentPoint = touches.first?.locationInView(self) else{
            return
        }
        
        let middlePoint = CGPointMake((lastTouchPoint.x + currentPoint.x) / 2,
                                      (lastTouchPoint.y + currentPoint.y) / 2)
        
        bezierPath.addQuadCurveToPoint(middlePoint, controlPoint: lastTouchPoint)
        
        drawLine(bezierPath)
        
        lastTouchPoint = currentPoint
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard bezierPath != nil else{
            return;
        }
        
        guard let currentPoint = touches.first?.locationInView(self) else{
            return
        }
        
        bezierPath.addQuadCurveToPoint(currentPoint, controlPoint: lastTouchPoint)
        
        drawLine(bezierPath)

        lastDrawImage = self.image
        
        canvasModel.addUndoStack(bezierPath)
        canvasModel.allClearRedoStack()
        
        bezierPath = nil
        
        delegate?.didDrawLine(self)
    }
    
    func drawLine(path:UIBezierPath) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        lastDrawImage?.drawAtPoint(CGPointZero)
        penColor.setStroke()
        path.stroke()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func undo() -> Bool {
        canvasModel.undo()
        
        lastDrawImage = nil
        image = nil
        
        for path:UIBezierPath in canvasModel.undoStack {
            drawLine(path)
            lastDrawImage = image
        }
        
        return canvasModel.undoStack.count > 0
    }
    
    func redo() -> Bool? {
        guard let redoPath = canvasModel.redo() else {
            return nil
        }
        
        drawLine(redoPath)
        lastDrawImage = self.image
        
        return canvasModel.redoStack.count > 0
    }
    
    func allClear() {
        canvasModel.allClearBothStack()
        image = nil
        lastDrawImage = nil
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
