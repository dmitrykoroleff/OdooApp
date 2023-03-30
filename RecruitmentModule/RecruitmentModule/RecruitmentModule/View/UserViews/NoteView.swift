//
//  NoteView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 04.02.2023.
//

import SwiftUI

struct NoteView: View {
    var note: Note
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                
                Circle()
                    .foregroundColor(Color("MainColor"))
                    .frame(width: 40, height: 40)
                
                Text("A") // Хардкод
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(note.user.name)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: 0x017E84))
                    Text(note.text)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: 0x282F33))
                }
                Text(note.editTime)
                    .font(.system(size: 10))
                    .foregroundColor(Color(hex: 0x6B6D70))
            }
        }
        .frame(height: 68)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: notes[0])
    }
}
