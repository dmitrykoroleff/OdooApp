import SwiftUI
import Combine

struct UnauthenticatedView: View {
    let bundle = Bundle(identifier: "odoo.miem.ios.authhse")
    @ObservedObject private var model: UnauthenticatedViewModel
    @StateObject private var loginModel: LoginViewModel = .init()
    private var height = UIApplication.shared.keyWindow?.frame.height

    init(model: UnauthenticatedViewModel) {
        self.model = model
    }
    
    var body: some View {
       
       ScrollView {
           
           VStack {
               
//               Image("logo")
               Image("logo", bundle: bundle)
                   .resizable()
                   .frame(width: 64, height: 22)
                   .padding(.top)
                   .padding(.bottom, 40)
               
               VStack(spacing: CGFloat(height!) / 46.6) {
                   
                   HStack {
                       Text("Welcome back,")
                           .foregroundColor(Color("Headings", bundle: bundle))
                           .font(.title)
                           .fontWeight(.semibold)
                           .frame(height: CGFloat(height!) / 46.6)
                           .padding(.leading, 28)
                       
                       Spacer()
                       
                   }
                   
                   HStack {
                       Text("We're happy to see you here again. Enter your server url, email and password.")
                           .foregroundColor(Color("Body", bundle: bundle))
                           .font(.subheadline)
                           .fontWeight(.light)
                           .padding(.leading, 28)
                           .padding(.trailing, 48)
                       
                       Spacer()
                       
                   }
                   
               }
               
               VStack(spacing: CGFloat(height!) / 18) {
                   
                   CustomTextField(hint: "Server", text: $loginModel.server)
                       .keyboardType(.URL)
                   CustomTextField(hint: "Email", text: $loginModel.email)
                       .keyboardType(.emailAddress)
                   CustomSecureTextField(hint: "Password", text: $loginModel.password)

               }
               .padding(.top)
               .padding(.bottom, 25)
               
               VStack(spacing: CGFloat(height!) / 40.5) {
                   
                   Button {
                       // Log In
//                       self.authenticate(serverURL: "https://odoo.miem.tv/ru",
//                                                      database: "crm",
//                                                      username: "admin",
//                                                      password: "admin")
                       self.model.logInOdoo(serverURL: loginModel.server,
                                            database: "crm",
                                            username: loginModel.email,
                                            password: loginModel.password)
                   } label: {
                       
                       ZStack {
                           
                           RoundedRectangle(cornerRadius: 20)
                               .fill(!loginModel.server.isEmpty && !loginModel.email.isEmpty && !loginModel.password.isEmpty ? Color("Primary Dark", bundle: bundle) : Color("Muted", bundle: bundle))
                               .frame(height: CGFloat(height!) / 15.5)
                           
                           Text("Log in")
                               .foregroundColor(!loginModel.server.isEmpty && !loginModel.email.isEmpty && !loginModel.password.isEmpty ? .white : Color("Dark Gray", bundle: bundle))
                               .font(.title2)
                               .fontWeight(.medium)
                               
                       }
                  
                   }
                   .disabled(loginModel.server.isEmpty || loginModel.email.isEmpty || loginModel.password.isEmpty)
                   Button {
                       // restore password
                   } label: {
                       Text("Forgot password?")
                           .foregroundColor(Color("Body", bundle: bundle))
                           .font(.body)
                           .fontWeight(.medium)
                           .foregroundColor(.black)
                   }
                   
                   HStack {
                       VStack {
                           Divider()
                               .overlay(.black)
                       }
                       .padding(.leading, 12)
                       
                       Text("or")
                           .font(.footnote)
                           .fontWeight(.light)
                           .foregroundColor(.gray)
                       
                       VStack {
                           Divider()
                               .overlay(.black)
                       }
                       .padding(.trailing, 12)
                   }
                   
                   Button {
                       model.startLogin()
                   } label: {
                       
                       ZStack {
                           
                           RoundedRectangle(cornerRadius: 20)
                               .fill(Color("Dark Blue", bundle: bundle))
                               .frame(height: CGFloat(height!) / 15.5)
                           
                           Text("Login with HSE")
                               .foregroundColor(.white)
                               .font(.title2)
                               .fontWeight(.medium)
                           
                       }
                   }
               }
               .padding(.horizontal, 28)
               
               Spacer()
           }
        }
        .ignoresSafeArea(.keyboard)
        .transition(.offset(x: 0, y: 850))
        
    }
    
}

    

