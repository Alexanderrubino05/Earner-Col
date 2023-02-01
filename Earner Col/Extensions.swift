//
//  Extensions.swift
//  Earner Col
//
//  Created by Alexander Rubino on 30/01/2023.
//

import SwiftUI
import Foundation

//Skriv Color(r: , g: , b, ) og så kan du skrive din custom farver
extension Color {
    init(r: CGFloat, g: CGFloat, b: CGFloat)  {
        self.init(red: r/255, green: g/255, blue: b/255)
    }
}




//Skriv UIScreen.screenWidth for at få Iphone width, og så videre...
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}




//Skriv .cornerRadius(20, corners: [.topLeft, .bottomRight]), og så laver du kun hjørnerne runde i .topLeft & .bottomRight
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
