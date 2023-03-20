//
//  NoSearchView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct NoResultsView: View {
    @Binding var searchQuery: String
    var body: some View {
        ZStack {
            Color.white
            VStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("MainColor"))
                        .frame(width: 60, height: 60)
                    
                    Image("noResultsIcon")
                        .resizable()
                        .frame(width: 6 ,height: 35)
                }
                .padding(5)
                
                Text("No results")
                    .font(.title3)
                    .padding()
                
                Text("There were no results for \"\(searchQuery)\".")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color("Dark Gray"))
                
                Text("Try a new search.")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color("Dark Gray"))
                
                Spacer()
            }
            .padding(25)
        }
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView(searchQuery: .constant("Hello"))
    }
}

