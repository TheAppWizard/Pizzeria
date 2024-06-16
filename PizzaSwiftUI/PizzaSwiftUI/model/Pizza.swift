//
//  Pizza.swift
//  PizzaSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 16/06/24.
//

import SwiftUI

struct Pizza : Identifiable {
    var id : UUID = .init()
    var pizza : String
    var pizzaImage : String
    var pizzaPrice : String
    
}

var pizzas : [Pizza] = [
    .init(pizza: "Panner Pizza", pizzaImage: "pizza1",pizzaPrice: "200 $"),
    .init(pizza: "Cheese Pizza", pizzaImage: "pizza2",pizzaPrice: "150 $"),
    .init(pizza: "Italian Pizza", pizzaImage: "pizza3",pizzaPrice: "300 $"),
    .init(pizza: "Pepperoni Pizza", pizzaImage: "pizza4",pizzaPrice: "200 $"),
    .init(pizza: "Cheese Pizza", pizzaImage: "pizza5",pizzaPrice: "150 $"),
    .init(pizza: "Italian Pizza", pizzaImage: "pizza6",pizzaPrice: "350 $"),
    .init(pizza: "Italian Pizza", pizzaImage: "pizza7",pizzaPrice: "100 $"),
    .init(pizza: "Veggies Pizza", pizzaImage: "pizza8",pizzaPrice: "300 $"),
]
