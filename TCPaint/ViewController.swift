//
//  ViewController.swift
//  TCPaint
//
//  Created by 井上 龍一 on 2016/05/13.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CanvasViewDelegate {

    @IBOutlet weak var canvas: CanvasView!
    @IBOutlet weak var undoButton: UIBarButtonItem!
    @IBOutlet weak var redoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        undoButton.enabled = false
        redoButton.enabled = false
        
        canvas.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didDrawLine(sender: CanvasView) {
        undoButton.enabled = true
        redoButton.enabled = false
    }

    @IBAction func clickedUndoButton(sender: UIBarButtonItem) {
        undoButton.enabled = canvas.undo()
        redoButton.enabled = true
    }
    
    @IBAction func clickedRedoButton(sender: UIBarButtonItem) {
        redoButton.enabled = canvas.redo() ?? redoButton.enabled
        undoButton.enabled = true
    }
    
    @IBAction func clickedClearButton(sender: UIBarButtonItem) {
        canvas.allClear()
        undoButton.enabled = false
        redoButton.enabled = false
    }
}

