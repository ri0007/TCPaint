//
//  CanvasView.swift
//  TCPaint
//
//  Created by 井上 龍一 on 2016/05/13.
//  Copyright © 2016年 Ryuichi Inoue. All rights reserved.
//

import UIKit

class CanvasView: UIImageView {
    static let canvasModel = CanvasModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .ScaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
