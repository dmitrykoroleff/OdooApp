//
//  NoteView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct NoteView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    var note: Note
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                
                Circle()
                    .foregroundColor(Color("MainColor", bundle: bundle))
                    .frame(width: 40, height: 40)
                
                Text("A") // Хардкод
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(note.task.name)
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
