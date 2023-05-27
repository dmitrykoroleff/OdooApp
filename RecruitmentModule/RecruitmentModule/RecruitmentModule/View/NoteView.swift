//
//  NoteView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct NoteView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    var note: Note
    var shared: LogicR
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                
                Circle()
                    .foregroundColor(Color("MainColor", bundle: bundle))
                    .frame(width: 40, height: 40)
                
                Text("\(shared.getFirstLetter(str: note.task))") // Хардкод
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    Text(note.task)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: 0x017E84))
                    Spacer()
                    Text(note.editTime)
                        .font(.system(size: 10))
                        .foregroundColor(Color(hex: 0x6B6D70))
                    
                }
//                Spacer()
                Text(note.text)
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: 0x282F33))
            }
        }
        .frame(height: 68)
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView(note: notes[0])
//    }
//}
