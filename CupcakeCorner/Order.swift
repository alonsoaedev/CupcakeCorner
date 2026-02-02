//
//  Order.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta Enriquez on 01/02/26.
//

import Foundation

@Observable
class Order {
    static let types = [
        "Vanilla",
        "Strawberry",
        "Chocolate",
        "Rainbow"
    ]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnable = false {
        didSet {
            extraFrosting = false
            addSprinkles = false
        }
    }
    var extraFrosting = false
    var addSprinkles = false
}
