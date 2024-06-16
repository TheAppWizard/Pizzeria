//
//  ContentView.swift
//  PizzaSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 16/06/24.
//

//  MARK: Instagram
//  TheAppWizard
//  MARK: theappwizard2408


import SwiftUI

struct ContentView: View {
    var body: some View {
        FinalView()
    }
}


#Preview {
    ContentView()
}













struct FinalView: View {
    @State private var angle: Double = 0.0
    @State private var startAngle: Double = 0.0
    @State private var nameofPizza : String = "Cheese Pizza"
    @State private var priceofPizza : String = "150 $"
    let radius: CGFloat = 150
    let step: Double = 45.0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            GeometryReader { geometry in
                let size = geometry.size

                ZStack {
                    ForEach(pizzas.indices, id: \.self) { index in
                        let anglePerPizza = 360.0 / Double(pizzas.count)
                        let pizzaAngle = anglePerPizza * Double(index) + angle

                        PizzaCard(pizza: pizzas[index])
                            .offset(x: 250)
                            .position(
                                x: size.width / 2 + radius * cos(CGFloat(pizzaAngle * .pi / 180)),
                                y: size.height / 2 + radius * sin(CGFloat(pizzaAngle * .pi / 180))
                            )
                            .rotationEffect(.degrees(-pizzaAngle))
                            .onChange(of: pizzaAngle, perform: { value in
                                if isCardNearTriangle(pizzaAngle) {
                                    nameofPizza = pizzas[index].pizza
                                    priceofPizza = pizzas[index].pizzaPrice
                                }
                            })
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let translation = value.translation.width
                            let deltaAngle = Double(translation / radius) * (180 / .pi)
                            angle = startAngle + deltaAngle
                        }
                        .onEnded { _ in
                            angle = (angle / step).rounded() * step
                            startAngle = angle
                            updatePizzaDetails()
                        }
                )

                HStack {
                    Spacer().frame(width: 10)
                    VStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                angle -= step
                                startAngle = angle
                                updatePizzaDetails()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.clear)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2)
                                )
                        }
                    }
                    Spacer().frame(width: 10)
                    VStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                angle += step
                                startAngle = angle
                                updatePizzaDetails()
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.clear)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2)
                                )
                        }
                    }
                }
            }

            VStack {
                HStack {
                    Image("title")
                        .resizable()
                        .frame(width: 180, height: 80)
                    Spacer()
                }
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    Spacer().frame(width: 180)
                    Triangle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .shadow(radius: 10)
                        .rotationEffect(.degrees(270))
                        .padding()
                    VStack {
                        HStack {
                            Text(nameofPizza).foregroundColor(.white.opacity(0.5))
                                .font(.system(size: 20))
                            Spacer()
                        }
                        HStack {
                            Text(priceofPizza).foregroundColor(.white)
                                .font(.system(size: 50))
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    func PizzaCard(pizza: Pizza) -> some View {
        Image(pizza.pizzaImage)
            .resizable()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }

    func updatePizzaDetails() {
        let anglePerPizza = 360.0 / Double(pizzas.count)
        let index = Int((angle / anglePerPizza).truncatingRemainder(dividingBy: Double(pizzas.count)))
        let validIndex = index >= 0 ? index : (index + pizzas.count) % pizzas.count
        nameofPizza = pizzas[validIndex].pizza
        priceofPizza = pizzas[validIndex].pizzaPrice
    }

    func isCardNearTriangle(_ pizzaAngle: Double) -> Bool {
        let triangleAngle = 270.0
        let threshold: Double = 30.0
        let normalizedPizzaAngle = (pizzaAngle + 360.0).truncatingRemainder(dividingBy: 360.0)
        let normalizedTriangleAngle = (triangleAngle + 360.0).truncatingRemainder(dividingBy: 360.0)
        let angleDifference = abs(normalizedPizzaAngle - normalizedTriangleAngle)
        return angleDifference <= threshold || angleDifference >= (360.0 - threshold)
    }
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        let point1 = CGPoint(x: rect.midX, y: rect.minY)
        let point2 = CGPoint(x: rect.minX, y: rect.maxY)
        let point3 = CGPoint(x: rect.maxX, y: rect.maxY)
        

        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.closeSubpath()
        
        return path
    }
}


