//
//  LogNoteView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct LogNoteView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var showAddLogNoteSheet = false
    var notes: [Note]
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Log note")
                    .font(.system(size: 14))
                    .foregroundColor(Color("MainColor", bundle: bundle))
                List {
                    ForEach(notes) { note in
                        NoteView(note: note, shared: LogicR())
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                } label: {
                                    Label {
                                        Text("Cancel")
                                            .font(.system(size: 6))
                                    } icon: {
                                        Image(systemName: "trash")
                                    }
                                    .labelStyle(VerticalLabelStyle())
                                    
                                }
                                .tint(Color("MainColor", bundle: bundle))
                                Button(role: .cancel) {
                                    
                                } label: {
                                    
                                    Label("Edit", systemImage: "square.and.pencil")
                                }
                                
                            }
                    }
                }
                .listStyle(.plain)
                .frame(height: height*0.55)
                Button(action: {
                    print("Log")
                    withAnimation(Animation.easeIn(duration: 0.2)){
                        showAddLogNoteSheet = true
                    }
                }, label: {
                    Text("Add new log note")
                        .underline()
                        .foregroundColor(Color("MainColor", bundle: bundle))
                })
                Spacer()
                
            }
            
            AddLogNoteView(showAddLogNoteSheet: $showAddLogNoteSheet, currentOffset: $offSet)
            
        }
    }
    
}

//struct LogNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogNoteView(task: testTask, notes: notes)
//    }
//}


struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center) {
            configuration.icon
            configuration.title
        }
    }
}

