//
//  LoginOpretView.swift
//  Earner Col
//
//  Created by Alexander Rubino on 02/02/2023.
//

import SwiftUI

struct LoginOpretView: View {
    //Presenting Views
    @State private var showOptretView = false
    
    //Slider
    @State private var currentSliderValue = "Login"
    
    //Email & Password
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            if currentSliderValue == "Login" {
                VStack {
                    sliderView
                    Group {
                        headlineText
                        emailAndPasswordTextfields
                        forgotPassword
                        LoginOrOpretButton
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            }
            
            if currentSliderValue == "Opret" {
                VStack {
                    sliderView
                    Group {
                        headlineText
                        emailAndPasswordTextfields
                        googleOrFacebookLogin
                        LoginOrOpretButton
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            }
            
            bottomEarnerText
        }
        .background(
            colorBackground
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, UIScreen.screenHeight / 2)
        )
        .fullScreenCover(isPresented: $showOptretView) {
            //Viser OpretView når showOpretView ændres
            OpretView()
        }
    }
    
    //Bagrunden
    //Size for baggrunden
    var backgroundWidth = UIScreen.screenWidth
    var backgroundHeight = UIScreen.screenHeight
    
    var colorBackground: some View {
        VStack {
            if currentSliderValue == "Login" {
                // Den grønne baggrund
                LinearGradient(
                    colors: [Color(r: 2, g: 75, b: 24),
                             Color(r: 7, g: 223, b: 16)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                    .opacity(0.35)
                    .frame(width: backgroundWidth, height: backgroundHeight)
                    .cornerRadius(85, corners: [.bottomLeft, .bottomRight])
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            }
            
            if currentSliderValue == "Opret" {
                // Den blå baggrund
                LinearGradient(colors: [Color(r: 0, g: 63, b: 77),
                                        Color(r: 1, g: 195, b: 238)],
                               startPoint: .top,
                               endPoint: .bottom
                )
                    .opacity(0.35)
                    .frame(width: backgroundWidth, height: backgroundHeight)
                    .cornerRadius(85, corners: [.bottomLeft, .bottomRight])
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
            }
            
            Spacer()
        }
    }
    
    //Login med Google og Facebook
    var googleOrFacebookLogin: some View {
        VStack {
            Text("Eller opret konto med")
                .font(.system(size: 16))
            
            HStack {
                Group {
                    Image("Google Icon")
                        .resizable()
                    
                    Image("Facebook Icon")
                        .resizable()
                }
                .scaledToFit()
                .frame(width: 40)
                .background(
                    Circle()
                        .fill(Color.white)
                )
            }
        }
    }
    
    //Glemt password tekst og knap
    var forgotPassword: some View {
        HStack(spacing: 4) {
            Text("Glemt password?")
                .font(.system(size: 16))
            
            Button {
                //Kør action med glemt password
            } label: {
                Text("Klik her")
                    .font(.system(size: 16))
            }

        }
    }
    
    //Login og Opret knap
    var LoginOrOpretButton: some View {
        Button {
            if currentSliderValue == "Opret" {
                showOptretView = true
            }
        } label: {
            HStack {
                Text(currentSliderValue == "Login" ? "Login" : "Opret")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 10,  x: 0, y: 5)
            }
            .background(.black.opacity(0.4))
            .cornerRadius(20)
            .padding(.top)
        }
    }
    
    //Email og Password textfields
    var emailAndPasswordTextfields: some View {
        VStack {
            //Email Textfield
            TextField("Email", text: $email)
                .padding()
                .overlay(
                    ZStack {
                        //Border rundt om hele slide
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(.black, lineWidth: 1)
                    }
                )
            
            //Password Textfield
            TextField("Password", text: $password)
                .padding()
                .overlay(
                    ZStack {
                        //Border rundt om hele slide
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(.black, lineWidth: 1)
                    }
                )
                .padding(.top)
        }
    }
    
    //Velkommen til Earner Text
    var headlineText: some View {
        HStack {
            Text("Velkommen til Earner")
                .font(.system(size: 40, weight: .semibold))
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    //Farver for teksten i knapperne i slider
    var greenTextColor = Color(r: 81, g: 158, b: 21)
    var blueTextColor = Color(r: 1, g: 145, b: 176)
    
    var sliderView: some View {
        HStack {
            //Login Button
            Text("Login")
                .font(.system(size: 20, weight: .semibold))
                .padding(20)
                .padding(.horizontal)
                .cornerRadius(35)
                .opacity(currentSliderValue == "Login" ? 1 : 0.5)
                .background(
                    ZStack {
                        if currentSliderValue == "Login" {
                            //Hvide baggrund
                            Color.white
                                .cornerRadius(35)
                                .shadow(radius: 50)
                        }
                    }
                )
                .foregroundColor(currentSliderValue == "Login" ? greenTextColor : .black)
                .onTapGesture {
                    // Animere den hvide baggrund
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                        currentSliderValue = "Login"
                    }
                }
            
            
            //Opret Button
            Text("Opret")
                .font(.system(size: 20, weight: .semibold))
                .padding(20)
                .padding(.horizontal)
                .cornerRadius(35)
                .opacity(currentSliderValue == "Opret" ? 1 : 0.5)
                .background(
                    ZStack {
                        if currentSliderValue == "Opret" {
                            //Hvide baggrund
                            Color.white
                                .cornerRadius(35)
                                .shadow(radius: 50)
                        }
                    }
                )
                .foregroundColor(currentSliderValue == "Opret" ? blueTextColor : .black)
                .onTapGesture {
                    // Animere den hvide baggrund
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                        currentSliderValue = "Opret"
                    }
                }
            
        }
        .overlay(
            ZStack {
                //Border rundt om hele slide
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color(r: 217, g: 217, b: 217), lineWidth: 2)
            }
        )
    }
    
    //Earner og Motto tekst i bunden af skærmen
    var bottomEarnerText: some View {
        VStack {
            Text("Earner")
                .font(.system(size: 50, weight: .bold))
            
            Text("Tjek dine egne lommepenge")
                .font(.system(size: 16))
                .opacity(0.6)
        }
        .padding(.bottom, 50)
    }
}

struct LoginOpretView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOpretView()
    }
}
