//
//  ProfileView.swift
//  Profile
//
//  Created by Dmitry Korolev on 7/4/2023.
//

import SwiftUI

public struct ProfileView: View {
    let bundle = Bundle(identifier: "Profile.Profile")
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    public init() {}
    public var body: some View {
        NavigationView {
            VStack {
                Button {
                    shouldShowImagePicker.toggle()
                } label: {
                    VStack {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .cornerRadius(80)
                        } else {
                            ZStack {
                                Color("MainColor", bundle: bundle)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(80)
                                Text("AU") // хардкод
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(Color("MainColor", bundle: bundle), lineWidth: 3)
                            .overlay(
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 22, height: 22)
                                    Circle()
                                        .foregroundColor(Color("Primary Dark", bundle: bundle))
                                        .frame(width: 18, height: 18)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 12, height: 12)
                                }
                                    .offset(x: 30, y: 30)
                            )
                    )
                }
                VStack(spacing: 10) {
                    Text("Awesome User") // хардкод
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("MainColor", bundle: bundle))
                        .padding(.top, 35)
                    
                    Text(verbatim: "awesomeuser@edu.hse.ru") // хардкод
                        .foregroundColor(.gray)
                        .underline()
                    
                    Text("+7 (987) 658 77 77") // хардкод
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
//                VStack(spacing: 15) {
//
//                    Button {
//
//                    } label: {
//                        Text("Notification settings")
//                            .fontWeight(.medium)
//                            .opacity(0.8)
//                            .padding()
//                            .background{
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke()
//                                    .frame(width: width - 50, height: 50)
//
//                            }
//                    }
//
//                    Button {
//
//                    } label: {
//                        Text("Password Settings")
//                            .fontWeight(.medium)
//                            .opacity(0.8)
//                            .padding()
//                            .background{
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke()
//                                    .frame(width: width - 50, height: 50)
//                            }
//
//                    }
//                }
//                .foregroundColor(.black)
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Button {
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Primary Dark", bundle: bundle))
                                .frame(width: width - 50, height: 55)
                            
                            Text("Log out")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.medium)
                            
                        }
                    }
                    NavigationLink(destination: AboutAppView()) {
                        Text("About the app")
                            .underline()
                    }
                    .foregroundColor(.gray)
                }
                .padding(.bottom, 70)
                
            }

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                .font(.system(size: 16, weight: .bold))
        })
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Image("logo", bundle: bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 22)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
                .ignoresSafeArea()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

