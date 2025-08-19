//
//  NumbersViewController.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

class NumbersViewController: UIViewController {
    
    let rootView = NumbersView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
}
