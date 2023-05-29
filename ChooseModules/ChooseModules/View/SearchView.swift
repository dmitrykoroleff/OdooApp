//
//  SearchView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//
import SwiftUI
//let bundle = Bundle(identifier: "chooseModules.ChooseModules")
let bundle = Bundle(identifier: "odoo.miem.ios.ChooseModules")

struct SearchView: View {
    var modules: [Modules]
    @Binding var searchQuery: String
    let colors: [Color] = [Color("CardColor1", bundle: bundle),
                           Color("CardColor2", bundle: bundle),
                           Color("CardColor3", bundle: bundle),
                           Color("CardColor4", bundle: bundle),
                           Color("CardColor5", bundle: bundle),
                           Color("CardColor6", bundle: bundle),
                           Color("CardColor7", bundle: bundle)]
    var body: some View {
        GeometryReader {geometry in
                if searchQuery == "" {
                    VStack {
                        
                        HStack {
                            Text("Favourite modules")
                                .font(.title3)
                                .fontWeight(.medium)
                            
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
                                            
                                            
                                            generateIcon(text: likedModule.name) // Хардкод
                                                .resizable()
                                                .frame(width: likedModule.name == "CRM" ? 50 : 35, height: 35)
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
                            Text("All modules")
                                .font(.title3)
                                .fontWeight(.medium)
                            
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
                                            
                                            
                                                generateIcon(text: module.name) // Хардкод
                                                    .resizable()
                                                    .frame(width: module.name == "CRM" ? 50 : 35, height: 35)
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
        .background(Color.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(modules: Modules.sampleData, searchQuery: .constant(""))
    }
}

