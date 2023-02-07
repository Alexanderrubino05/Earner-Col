//
//  OpretView.swift
//  Earner Col
//
//  Created by Alexander Rubino on 04/02/2023.
//

import SwiftUI
import MapItemPicker

struct OpretView: View {
    //FailedToOpret Control
    @State private var showFailedToOpretView = false
    
    //MapPicker
    @State private var showMapPicker = false
    @State private var selectedLocation = "Indtast din øskede adresse"
    
    //Kalde dismiss() for at fjerne view
    @Environment(\.dismiss) private var dismiss
    
    //Worker-Houser
    @State private var selectedRole = "Worker"
    @Namespace var animation
    @State private var showInformationBox = false
    
    //Username & Birthday
    @State var usernameText = ""
    @State var birthday = Date()
    
    //Image Picker variables
    @State private var image: UIImage?
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    profileImageView
                        .padding(.bottom)
                    selectionView
                    textFields
                    locationPickerButton
                }
                
                Spacer()
                if showFailedToOpretView { //Når man ikke skriver "== true", så betyder det præcis det samme. Så der står faktisk "== true"
                    failedToOpretView
                }
                opretButton
                safetyMessage
            }
            .padding()
            .cropedImagePicker(options: [.circle], show: $showSheet, croppedImage: $image)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Opret din Konto")
            .toolbar {
                //Navigation Button (X), der fjerne OpretView
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .mapItemPicker(isPresented: $showMapPicker) { item in
            if let name = item?.name {
                selectedLocation = name
            }
        }
    }
    
    //failedToOpretView
    var failedToOpretView: some View {
        HStack {
            //Failed Message
            Text("Du skal indtaste alle oplysninger for at oprette din profil")
                .font(.system(size: 16))
            
            //Cancel button
            Button {
                withAnimation {
                    showFailedToOpretView = false
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .thin))
            }
        }
        .padding()
        .background(Color(r: 211, g: 211, b: 211))
        .cornerRadius(8)
        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
        .padding(.horizontal)
    }
    
    //opretButton
    var opretButton: some View {
        HStack {
            Button {
                if usernameText == "" || selectedLocation == "Indtast din øskede adresse" { //|| Betyder or
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showFailedToOpretView = true
                    }
                }
                else {
                    //Opret account
                }
            } label: {
                Text("Opret")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(Color(r: 48, g: 97, b: 20))
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    //MapPickerButton
    var locationPickerButton: some View {
        VStack {
            Button {
                showMapPicker = true
            } label: {
                HStack {
                    Text(selectedLocation)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(r: 48, g: 97, b: 20))
                        .font(.system(size: 16))
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    //Worker-Houser Selection
    var selectionView: some View {
        VStack(spacing: 12) {
            //Lille grønne info knap
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        showInformationBox.toggle()
                    }
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(Color(r: 48, g: 97, b: 20))
                }
            }
            .padding(.trailing)
            
            HStack {
                Spacer()
                //Worker
                Button {
                    withAnimation {
                        selectedRole = "Worker"
                    }
                } label: {
                    Text("Worker")
                        .font(.system(size: 40, weight: selectedRole == "Worker" ? .bold : .thin))
                        .foregroundColor(selectedRole == "Worker" ? Color(r: 48, g: 97, b: 20) : .black)
                        .overlay(alignment: .bottom) {
                            ZStack {
                                if selectedRole == "Worker" {
                                    Capsule()
                                        .fill(.black)
                                        .frame(width: UIScreen.screenWidth / 2, height: 2)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        }
                }
                
                Spacer()
                
                //Houser
                Button {
                    withAnimation {
                        selectedRole = "Houser"
                    }
                } label: {
                    Text("Houser")
                        .font(.system(size: 40, weight: selectedRole == "Houser" ? .bold : .thin))
                        .foregroundColor(selectedRole == "Houser" ? Color(r: 48, g: 97, b: 20) : .black)
                        .overlay(alignment: .bottom) {
                            ZStack {
                                if selectedRole == "Houser" {
                                    Capsule()
                                        .fill(.black)
                                        .frame(width: UIScreen.screenWidth / 2, height: 2)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        }
                }
                
                Spacer()
            }
            
            if showInformationBox {
                informationBox
                    .padding(.bottom)
            }
        }
    }
    
    //Text box for Worker-Houser
    private var workerInfoText = "Du kan som Worker tage opgaver, hvor du kan optjene dine egne penge"
    private var houserInfoText = "Du kan som Houser gøre dette oprette opgaver, hvor du kan få hælp til hverdagen"
    
    var informationBox: some View {
        HStack {
            if selectedRole == "Worker" {
                Text(workerInfoText)
                    .font(.system(size: 16))
                    .padding()
                    .background {
                        Color(r: 161, g: 228, b: 165)
                            .cornerRadius(20)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                
            }
            else if selectedRole == "Houser" {
                Text(houserInfoText)
                    .font(.system(size: 16))
                    .padding()
                    .background {
                        Color(r: 161, g: 228, b: 165)
                            .cornerRadius(20)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
        }
    }
    
    //Username and Fødselsdag
    var textFields: some View {
        VStack {
            TextField("Username", text: $usernameText)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.secondary, lineWidth: 2)
                }
                .padding(.horizontal)
            
            DatePicker("Fødselsdag", selection: $birthday,
                        in: ...Date(),
                        displayedComponents: [.date])
                .padding()
                .tint(Color(r: 48, g: 97, b: 20))
        }
    }
    
    //ProfilBillede
    var profileImageView: some View {
        ZStack(alignment: .leading) {
            Button {
                showSheet = true
            } label: {
                if image == nil {
                    Image("Profile Icon")
                        .resizable()
                        .frame(width: 225, height: 225)
                }
                else {
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 225, height: 225)
                }
            }
            Image(systemName: "camera.fill")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .background {
                    Circle()
                        .fill(Color(r: 48, g: 97, b: 20))
                        .frame(width: 30, height: 30)
                }
                .offset(CGSize(width: 30, height: -90))
        }
        .shadow(radius: image == nil ? 0 : 6)
    }
    
    //Safety message
    var safetyMessage: some View {
        HStack {
            Text("Dine oplysninger bliver bevaret betrogeligt")
                .font(.system(size: 12))
        }
    }
}

struct OpretView_Previews: PreviewProvider {
    static var previews: some View {
        OpretView()
    }
}
