//
//  CanvasModel.swift
//  TCPaint
//
//  Created by 井上 龍一 on 2016/05/13.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class CanvasModel {
    static let sharedInstance = CanvasModel()
    
    private var undoStack = [UIBezierPath]()
    private var redoStack = [UIBezierPath]()
    
    func undo() {
        
    }
    
    func redo() {
    
    }
    
    func StackAllClear() {
    
    }
}
