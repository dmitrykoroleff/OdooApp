//
//  AddLogNoteView.swift
//  CRM
//
//  Created by Dmitry Korolev on 14/3/2023.
//

import SwiftUI

struct AddLogNoteView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var currentIndex = 0
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @Binding var showAddLogNoteSheet: Bool
    @Binding var currentOffset: CGFloat
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .stroke(Color("MainColor", bundle: bundle).opacity(0.5))
                .frame(height: UIScreen.main.bounds.height)
                .background(Color.white)
                .shadow(color: Color("MainColor", bundle: bundle).opacity(0.5), radius: 5)
                .cornerRadius(35)
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(Animation.easeOut(duration: 0.2)){
                            currentOffset = 0
                            showAddLogNoteSheet = false
                        }
                    }, label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("MainColor", bundle: bundle))
                    })
                    Spacer()
                    Button(action: {
                        withAnimation(Animation.easeOut(duration: 0.2)){
                            notes.append(Note(id: UUID(), task: testTask, text: text, editTime: "Now"))
                            currentOffset = 0
                            showAddLogNoteSheet = false
                        }
                    }, label: {
                        Text("Done")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    })
                }
                Spacer()
                    .frame(height: height/20)
                HStack {
                    Text("Log note")
                        .font(.system(size: 28))
                    Spacer()
                }
                
                
                ZStack(alignment: .topLeading) {
                    
                    if text.isEmpty {
                        Text("Enter log note...")
                            .padding(5)
                            .foregroundColor(.primary.opacity(0.25))
                        
                    }
                    
                    TextEditor(text: $text)
                        .padding(.horizontal, 5)
                    
                        .frame(height: 100)
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .onAppear{
                            UITextView.appearance().backgroundColor = .clear
                        }
                        .onDisappear{
                            UITextView.appearance().backgroundColor = nil
                        }
                    
                })
                
                
                Spacer()
            }
            .frame(width: width * 0.8, height: height * 0.95)
            
        
    }
    }
}

struct AddLogNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogNoteView(showAddLogNoteSheet: .constant(false), currentOffset: .constant(0))
    }
}
