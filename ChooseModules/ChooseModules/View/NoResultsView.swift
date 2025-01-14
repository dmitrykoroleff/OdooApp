//
//  NoResultsView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 12/1/2023.
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
                        .foregroundColor(Color("MainColor", bundle: bundle))
                        .frame(width: 60, height: 60)
                    
                    Image("noResultsIcon", bundle: bundle)
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
                    .foregroundColor(Color("Dark Gray", bundle: bundle))
                
                Text("Try a new search.")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color("Dark Gray", bundle: bundle))
                
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
