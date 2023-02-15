import SwiftUI
import Combine
import ChooseModule

struct UnauthenticatedView: View {
    let bundle = Bundle(identifier: "odoo.miem.ios.authhse")
    @ObservedObject private var model: UnauthenticatedViewModel
    @ObservedObject private var modelCookie = CookieFile()
    @StateObject private var loginModel: LoginViewModel = .init()
    private var height = UIScreen.main.bounds.height
    var str1: String = "https://profile.miem.hse.ru/auth/realms/MIEM/protocol/openid-connect/auth?"
    var str2: String = "response_type=token&client_id=odoo.miem.tv&redirect_uri=https://odoo.miem.tv/auth_oauth/"
    var str3: String = "signin&scope=profile&state=%7B%22d%22%3A+%22crm%22%2C+%22p%22%3A+4%2C+%22r%22%3A+%22https%253A%252F%252Fodoo.miem.tv%252Fweb%22%7D"

    init(model: UnauthenticatedViewModel) {
        self.model = model
    }

    var body: some View {

        ScrollView {

            VStack {
                Image("logo", bundle: bundle)
                    .resizable()
                    .frame(width: 64, height: 22)
                    .padding(.top)
                    .padding(.bottom, 40)

                VStack(spacing: CGFloat(height) / 46.6) {

                    HStack {
                        Text("welcome-string")
                            .foregroundColor(Color("Headings", bundle: bundle))
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(height: CGFloat(height) / 46.6)
                            .padding(.leading, 28)

                        Spacer()

                    }

                    HStack {
                        Text("introduction-string")
                            .foregroundColor(Color("Body", bundle: bundle))
                            .font(.subheadline)
                            .fontWeight(.light)
                            .padding(.leading, 28)
                            .padding(.trailing, 48)

                        Spacer()

                    }

                }

                VStack(spacing: CGFloat(height) / 18) {

                    CustomTextField(hint: NSLocalizedString("server-string", comment: ""), text: $loginModel.server)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                    CustomTextField(hint: NSLocalizedString("email-string", comment: ""), text: $loginModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    CustomSecureTextField(hint: NSLocalizedString("password-string", comment: ""), text: $loginModel.password)
                        .autocapitalization(.none)

                }
                .padding(.top)
                .padding(.bottom, 25)

                VStack(spacing: CGFloat(height) / 40.5) {

                    Button {
                        
                        if (self.model.logInOdooNew(serverURL: loginModel.server,
                                                    username: loginModel.email,
                                                    password: loginModel.password) != false)  {
                            //MARK: show here choose module
                            //check bool return
                            ChooseModule.ChooseModuleView()
                        }
                    } label: {

                        ZStack {

                            RoundedRectangle(cornerRadius: 20)
                                .fill(!loginModel.server.isEmpty && !loginModel.email.isEmpty && !loginModel.password.isEmpty ? Color("MainColor", bundle: bundle) : Color("Muted", bundle: bundle))
                                .frame(height: CGFloat(height) / 15.5)

                            Text("log-in-string")
                                .foregroundColor(!loginModel.server.isEmpty && !loginModel.email.isEmpty && !loginModel.password.isEmpty ? .white : Color("Dark Gray", bundle: bundle))
                                .font(.title2)
                                .fontWeight(.medium)

                        }

                    }
                    .disabled(loginModel.server.isEmpty || loginModel.email.isEmpty || loginModel.password.isEmpty)

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
//                        model.startLogin()
                        modelCookie.show()
                    } label: {

                        ZStack {

                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Dark Blue", bundle: bundle))
                                .frame(height: CGFloat(height) / 15.5)

                            HStack(spacing: 10) {

                                Image("HSELogo", bundle: bundle)
                                    .resizable()
                                    .frame(width: 30, height: 30)

                                Text("log-in-with-hse-string")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                .fontWeight(.medium)

                            }

                        }
                    }.sheet(isPresented: $modelCookie.isPresent) {
                        Webview(url: URL(string: "\(str1)\(str2)\(str3)")!, modelCookie: modelCookie)
                    }
                }
                .padding(.horizontal, 28)

                Spacer()
            }
        }
        .ignoresSafeArea(.keyboard)
        .transition(.offset(x: 0, y: 850))
        .background(Color("Background", bundle: bundle))

    }

}
