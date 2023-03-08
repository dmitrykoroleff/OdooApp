//
//  SearchView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//
import SwiftUI

@available(iOS 13.0, *)
struct SearchView: View {
    var modules: [Modules]
    @Binding var searchQuery: String
    @available(iOS 13.0, *)
    let colors: [Color] = [Color("CardColor1"), Color("CardColor2"), Color("CardColor3"), Color("CardColor4"), Color("CardColor5"), Color("CardColor6"), Color("CardColor7")]
    @available(iOS 13.0.0, *)
    var body: some View {
        GeometryReader {_ in
                if searchQuery == "" {
                    VStack {
                        
                        HStack {
                            if #available(iOS 14.0, *) {
                                Text("Favourite modules")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 28)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(modules) { likedModule in
                                    ZStack {
                                        
                                        Rectangle()
                                            .cornerRadius(20)
                                        
                                        VStack {
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                VStack {
                                                    
                                                    Image(systemName: "heart.fill")
                                                        .imageScale(.large)
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer()
                                                }
                                                
                                            }
                                            .padding(.top)
                                            .padding(7)
                                            
                                            ZStack {
                                                
                                                Image("icon")
                                                    .resizable()
                                                    .frame(width: 50, height: 27)
                                            }
                                            .offset(y: -30)
                                            
                                            Text(likedModule.name)
                                                .foregroundColor(.white)
                                                .offset(y: -30)
                                            
                                        }
                                        
                                    }
                                    .frame(width: 160, height: 90)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 5)
                                    .padding(.leading)
                                    .foregroundColor(colors[Int(generateColorFor(text: likedModule.name, colors: colors))])
                                }
                            }
                        }
                        
                        HStack {
                            if #available(iOS 14.0, *) {
                                Text("All modules")
                                    .font(.title3)
                                    .fontWeight(.medium)
                            } else {
                                // Fallback on earlier versions
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 28)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(modules) { module in
                                    ZStack {
                                        
                                        Rectangle()
                                            .cornerRadius(20)
                                        
                                        VStack {
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                VStack {
                                                    
                                                    Image(systemName: "heart.fill")
                                                        .imageScale(.large)
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer()
                                                }
                                                
                                            }
                                            .padding(.top)
                                            .padding(7)
                                            
                                            ZStack {

                                                Image("icon")
                                                    .resizable()
                                                    .frame(width: 50, height: 27)
                                            }
                                            .offset(y: -30)
                                            
                                            Text(module.name)
                                                .foregroundColor(.white)
                                                .offset(y: -30)
                                            
                                        }
                                        
                                    }
                                    .frame(width: 160, height: 90)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 5)
                                    .padding(.leading)
                                    .foregroundColor(colors[Int(generateColorFor(text: module.name, colors: colors))])
                                    }
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.vertical)
                    
                } else {
                    
                   ScrollView {
                        ForEach(search(modules: modules, searchQuery: searchQuery)) { module in
                            ZStack {
                                Color.white
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: 320, height: 180)
                                    .foregroundColor(colors[Int(generateColorFor(text: module.name, colors: colors))])
                                HStack(alignment: .center) {
                                    
                                        VStack(alignment: .leading, spacing: 15) {
                                            
                                            HStack {
                                                
                                                Spacer()
                                                
                                                Image(systemName: "heart.fill")
                                                    .imageScale(.large)
                                                    .foregroundColor(.white)
                                                
                                            }
                                            .padding()
                                            
                                            Text(module.name).font(.title) // Хардкод
                                                .fontWeight(.bold)
                                                .padding(.horizontal, 15)
                                                .foregroundColor(.white)
                                                .offset(y: -20)
                                            
                                            Text("\(module.notifications) New Notifications") // Хардкод
                                                .padding(.horizontal, 15)
                                                .foregroundColor(.white)
                                                .background(
                                                    Color.white
                                                        .frame(height: 1)
                                                        .offset(y: 10)
                                                        .padding(.horizontal, 15)
                                                )
                                                .offset(y: -20)
                                            
                                            Spacer()
                                            
                                        }
                                    
                                }
                                .padding(.leading)
                            .frame(width: 320, height: 180)
                            }
                        }
                    }
                   .padding()
                }
        }
        .background(Color("Background"))
    }
}

struct SearchView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        SearchView(modules: Modules.sampleData, searchQuery: .constant(""))
    }
}
