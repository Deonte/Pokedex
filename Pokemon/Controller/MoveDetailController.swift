//
//  MoveDetailController.swift
//  Pokemon
//
//  Created by Deonte on 10/19/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class MoveDetailController: UIViewController {
    
    var selectedMove: Move?
    var mdView = MoveDetailView()
    
    override func loadView() {
        super.loadView()
        view = mdView
        mdView.selectedMove = selectedMove
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

