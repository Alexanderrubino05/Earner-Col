//
//  OpretView.swift
//  Earner Col
//
//  Created by Alexander Rubino on 04/02/2023.
//

import SwiftUI

struct OpretView: View {
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
                profileImageView
                    .padding(.bottom)
                selectionView
                textFields
                Spacer()
            }
            .padding()
            .cropedImagePicker(options: [.circle], show: $showSheet, croppedImage: $image)
            
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
    }
    
    
    //Worker-Houser Selection
    var selectionView: some View {
        VStack(spacing: 12) {
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
            
            DatePicker("Fødselsdag", selection: $birthday,
                        in: ...Date(),
                        displayedComponents: [.date])
                .padding()
                .tint(Color(r: 48, g: 97, b: 20))
        }
    }
    
    //ProfilBillede
    var profileImageView: some View {
        ZStack(alignment: .topLeading) {
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
                .padding(20)
                .foregroundColor(.white)
                .background {
                    Circle()
                        .fill(Color(r: 48, g: 97, b: 20))
                        .frame(width: 30, height: 30)
                }
                .offset(CGSize(width: image == nil ? 15 : 7, height: image == nil ? 15 : 7))
        }
        .shadow(radius: 40)
    }
}

struct OpretView_Previews: PreviewProvider {
    static var previews: some View {
        OpretView()
    }
}
