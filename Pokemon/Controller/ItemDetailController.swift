//
//  ItemDetailController.swift
//  Pokemon
//
//  Created by Deonte on 10/22/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class ItemDetailController: UIViewController {
    
    var selectedItem: Item?
    var itemDetailView = ItemDetailView()
    
    override func loadView() {
        view = itemDetailView
        itemDetailView.selectedItem = selectedItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
