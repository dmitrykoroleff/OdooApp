//
//  Profile.swift
//  project_management
//
//  Created by Dmitry Korolev on 1/4/2023.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("auth") var authenticated = true
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
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
                                Color("MainColor")
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(80)
                                Text("AU")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(Color("MainColor"), lineWidth: 3)
                            .overlay(
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 22, height: 22)
                                    Circle()
                                        .foregroundColor(Color("Primary Dark"))
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
                    Text("Awesome User")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("MainColor"))
                        .padding(.top, 35)
                    
                    Text(verbatim: "awesomeuser@edu.hse.ru")
                        .foregroundColor(.gray)
                        .underline()
                    
                    Text("+7 (987) 658 77 77")
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Button {
                        
                    } label: {
                        Text("Notification settings")
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(width: width - 50, height: 50)
                                
                            }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Password Settings")
                            .fontWeight(.medium)
                            .opacity(0.8)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(width: width - 50, height: 50)
                            }
                        
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    Button {
                        self.authenticated.toggle()
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Primary Dark"))
                                .frame(width: width - 50, height: 55)
                            
                            Text("Log out")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            
                        }
                    }
                    
                    Text("About the app")
                        .underline()
                }
                .padding(.bottom)
                
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
                Image("logo")
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

struct ImagePicker: UIViewControllerRepresentable {
 
    @Binding var image: UIImage?
 
    private let controller = UIImagePickerController()
 
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
 
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
        let parent: ImagePicker
 
        init(parent: ImagePicker) {
            self.parent = parent
        }
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
 
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
 
    }
 
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
 
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
 
    }
 
}
