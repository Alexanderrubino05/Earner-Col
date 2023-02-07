//
//  HomeMainView.swift
//  Earner Col
//
//  Created by Alexander Rubino on 07/02/2023.
//

import SwiftUI

struct HomeMainView: View{
    var post: Post
    @State private var showUsername = false
    
    var body: some View {
        HStack {
            textView
            .padding(.top)
            .overlay(alignment: .topLeading) {
                profileImage
            }
            
            Spacer()
            
            buttonsRight
                .overlay(alignment: .top) {
                    tag
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Color(r: 226, g: 239, b: 213)
                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
        )
    }
    
    //ProfileImage
    var profileImage: some View {
        HStack {
            Button {
                withAnimation {
                    showUsername.toggle()
                }
            } label: {
                    Image(post.profileImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color(r: 48, g: 97, b: 10))
                                .font(.system(size: 12))
                                .offset(CGSize(width: 2, height: -15))
                        }
                //Username
                if showUsername {
                    Text(post.username)
                        .padding(6)
                        .foregroundColor(.white)
                        .background(Color(r: 48, g: 97, b: 10))
                        .cornerRadius(10)
                        .zIndex(0)
                        .transition(.asymmetric(insertion: .push(from: .trailing), removal: .push(from: .leading)))
                }
            }
        }
        .offset(CGSize(width: 0, height: -40))
    }
    
    //Tag Imaget
    var tag: some View {
        ZStack {
            Image("Lawnmover Icon")
                .resizable()
                .frame(width: 30, height: 30)
                .offset(CGSize(width: 0, height: -30))
        }
    }
    
    //Caption, det endelige text, og Date
    var textView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.caption)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, -8)
            
            Text(post.text)
                .font(.system(size: 16))
            
            Text("2 dage siden")
                .font(.system(size: 12, weight: .ultraLight))
        }
    }
    
    //Knapperne til højre
    var buttonsRight: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .padding(.bottom, 4)
            
            Image(systemName: "heart")
                .foregroundColor(.red)
            
            Image(systemName: "text.bubble")
        }
        .font(.system(size: 16))
    }
}

struct HomeMainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
