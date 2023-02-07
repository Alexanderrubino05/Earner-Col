//
//  HomeView.swift
//  Earner Col
//
//  Created by Alexander Rubino on 07/02/2023.
//

import SwiftUI

struct HomeView: View {
    //Posts
    //Vi efterlader det bare som det her for nu...
    @State private var posts = [
        Post(username: "Alexander Rubino", profileImage: "Profile Icon", caption: "Gøre rent i min lejlighed", text: "Jeg har brug for en person til at gøre rent i min lejlighed i morgen", price: "150 kr", age: "10-20 år", tag: Tag.moving, images: nil)
        ,
        Post(username: "Andreas Køhler", profileImage: "Profile Icon", caption: "Hjælp til at klippe hæk", text: "Jeg har brug for hjælp til at klippe en hæk i morgen", price: "300 kr", age: "15-25 år", tag: Tag.gardening, images: ["Lawnmoving Image", "Lawnmoving Image"])
        ,
        Post(username: "Sebastian Oliver Smith", profileImage: "Profile Icon", caption: "Jeg skal flytte en box op til 3 etage", text: "Jeg er lige flyttet ud af min lejlighed, så jeg har brug for hjælp til at flytte mine ting, som er i en flyttebox, op på 3. etage. Så har brug for en stærk ung man/kvinde. Skriv for mere info", price: "250 kr", age: "15-20", tag: Tag.moving, images: ["Lawnmoving Image"])
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                Divider() //Giver spacing til toppen
                    .opacity(0)
                    .padding(.bottom)
                
                ForEach(posts, id: \.id) { post in
                    HomeMainView(post: post)
                        .padding(.vertical)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Earner")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(r: 97, g: 193, b: 120))
                }
                    
                ToolbarItem(placement: .automatic) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle")
                        
                        Image(systemName: "magnifyingglass.circle")
                        
                        Image(systemName: "slider.horizontal.3")
                    }
                    .foregroundColor(Color(r: 97, g: 193, b: 120))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
