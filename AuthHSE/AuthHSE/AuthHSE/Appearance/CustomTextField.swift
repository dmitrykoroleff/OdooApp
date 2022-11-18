import SwiftUI

// MARK: remove available
// @available(iOS 15.0, *)
struct CustomTextField: View {
    let bundle = Bundle(identifier: "odoo.miem.ios.authhse")
    var hint: String
    @Binding var text: String
    @State var tapped: Bool = false
    @State var colored: Bool = false
    var height = UIApplication.shared.keyWindow?.frame.height

    var body: some View {
        
        VStack {
            
            ZStack {
        
                TextField(hint, text: $text, onEditingChanged: { tap in
                    if !text.isEmpty {
                        tapped = true
                        colored = tap
                    } else {
                        tapped = tap
                        colored = tap
                    }
                })
                        .padding(.leading, 20)
                        .background {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(!tapped ? .gray : Color("MainColor", bundle: bundle))
                                    .frame(height: CGFloat(height!) / 18.64)
                                    .shadow(color: Color("MainColor", bundle: bundle), radius: !colored ? 0 : 2)
                
                            }
                            .foregroundColor(.white)
                            
                        }
                
            }
            .padding(.horizontal, 28)
        
        }
    }
}

// MARK: remove available

struct CustomSecureTextField: View {
    let bundle = Bundle(identifier: "odoo.miem.ios.authhse")
    var hint: String
    @Binding var text: String
    @State var tapped: Bool = false
    @State var colored: Bool = false
    var height = UIApplication.shared.keyWindow?.frame.height

    var body: some View {
        
        VStack {
            
            ZStack {
                
                SecureField(hint, text: $text, onCommit: {
                    colored = false
                    if text.isEmpty {
                        tapped = false
                    }
                })
                    .padding(.leading, 20)
                    .background {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(!tapped ? .gray : Color("MainColor", bundle: bundle))
                                .frame(height: CGFloat(height!) / 18.64)
                                .shadow(color: Color("MainColor", bundle: bundle), radius: !colored ? 0 : 2)
                            
                        }
                        .foregroundColor(.white)
                        
                    }
                
            }
            .onTapGesture {
                tapped.toggle()
                colored.toggle()
                if !text.isEmpty {
                    colored = true
                    tapped = true
                }
            }
            .padding(.horizontal, 28)
            
        }
        
    }
}
