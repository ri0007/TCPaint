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
    
    private(set) var undoStack = [UIBezierPath]()
    private(set) var redoStack = [UIBezierPath]()
    
    func undo() {
        guard let undoPath = undoStack.popLast() else {
            return
        }
        redoStack.append(undoPath)
    }
    
    func redo() {
        guard let redoPath = redoStack.popLast() else {
            return
        }
        undoStack.append(redoPath)
    }
    
    func addUndoStack(bezierPath:UIBezierPath) {
        undoStack.append(bezierPath)
    }
    
    func addRedoStack(bezierPath:UIBezierPath) {
        redoStack.append(bezierPath)
    }
    
    func allClearUndoStack() {
        undoStack.removeAll()
    }
    
    func allClearRedoStack() {
        redoStack.removeAll()
    }
    
    func allClearBothStack() {
        allClearRedoStack()
        allClearUndoStack()
    }
}
