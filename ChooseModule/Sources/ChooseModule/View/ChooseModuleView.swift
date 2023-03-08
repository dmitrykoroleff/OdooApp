//
//  ContentView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
public struct ChooseModuleView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var addFavModule = false
    @State var searchIsActive = false
    @State var searchQuery = ""
    @State var currentIndex: Int = 0
    @State var liked = false
    let colors: [Color] = [Color("CardColor1"), Color("CardColor2"), Color("CardColor3"), Color("CardColor4"), Color("CardColor5"), Color("CardColor6"), Color("CardColor7")]
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    let modules: [Modules]
    public init() {
        modules = Modules.sampleData
    }
    public var body: some View {
        
        GeometryReader { _ in
            ZStack {
                
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 22)
                        .offset(y: height < 700 ? 24 : 0)
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("Hello, ")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Body"))
                            
                            Text(verbatim: "aashoshina@miem.hse.ru") // Хардкод
                                .foregroundColor(Color("Body"))
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .foregroundColor(Color("MainColor"))
                                    .frame(width: 40, height: 40)
                                
                                Text("A") // Хардкод
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                            }
                        }
                        
                    }
                    .padding()
                    .offset(y: searchIsActive ? -(height / 2) : 0)
                    
                    HStack {
                        Text("Choose module")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Headings"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .offset(y: searchIsActive ? -(height / 2) : 0)
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                        
                        TextField("Enter module name...", text: $searchQuery, onEditingChanged: { search in
                            withAnimation {
                                searchIsActive = search
                            }
                        })
                        
                    }
                    .background {
                        ZStack {
                            Color("Background")
                            HStack(spacing: 20) {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke()
                                    .frame(width: !searchIsActive ? width - 60 : width - 100, height: 50)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                
                                if searchIsActive {
                                    
                                    Button {
                                        withAnimation {
                                            searchQuery = ""
                                            searchIsActive = false
                                            UIApplication.shared.endEditing()
                                        }
                                        
                                    } label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                        
                                    }
                                    .frame(width: 20, height: 20)
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .offset(y: searchIsActive ? height > 600 && height < 700
                            ? -(height / 6) : height > 700 && height < 800 ?
                            -(height / 7) : height > 800 && height < 850 ?
                            -(height / 7.3) : height > 850 && height < 900 ?
                            -(height / 8) : -(height / 9) : 0)
                    
                    // каруселька
                        CarouselModulesView(spacing: 15, trailingSpace: 30,
                                            index: $currentIndex, items: modules,
                                            currentOffset: $curruntOffset,
                                            addFavModule: $addFavModule) { module in
                                GeometryReader { proxy in
                                    let size = proxy.size
                                    ZStack {
                                        
                                        Rectangle()
                                            .foregroundColor(colors[Int(generateColorFor(text:
                                            module.name, colors: colors))]) // Хардкод
                                        
                                        HStack {
                                            
                                            VStack(alignment: .leading, spacing: 15) {
                                                
                                                HStack {
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "heart.fill")
                                                        .resizable()
                                                        .imageScale(.large)
                                                        .foregroundColor(.white)
                                                        .frame(width: height > 600 && height < 700
                                                               ? 20 : height > 700 && height < 800
                                                               ? 21 : height > 800 && height < 900
                                                               ? 22 : 25, height: height > 600 &&
                                                               height < 700 ? 20 : height > 700 &&
                                                               height < 800 ? 21 : height > 800 &&
                                                               height < 900 ? 22 : 25)
                                                    
                                                }
                                                .padding()
                                                .padding(.top, height > 600 && height < 700 ? 2 :
                                                        height > 700 && height < 800 ? 2 : height
                                                        > 800 && height < 900 ? 3 : 5)
                                                .padding(.trailing, height > 600 && height < 700
                                                         ? 2 : height > 700 && height < 800 ? 2
                                                         : height > 800 && height < 900 ? 3 : 5)
                                                
                                                Text(module.name).font(.title) /// Хардкод
                                                    .fontWeight(.bold)
                                                    .padding(.horizontal, 30).foregroundColor(.white)
                                                
                                                Text("\(module.notifications) New Notifications") // Хардкод
                                                    .padding(.horizontal, 30)
                                                    .foregroundColor(.white)
                                                    .background(
                                                        Color.white
                                                            .frame(height: 1)
                                                            .offset(y: 10)
                                                            .padding(.horizontal, 30)
                                                    )
                                                
                                                Spacer()
                                                
                                            }
                                            
                                        }
                                    }
                                    .cornerRadius(20)
                                }
                                .padding(.top, 20)
                        }
          
                        // индикаторы пролистывания карусельки
                        HStack(spacing: 10) {
                            ForEach(modules.indices, id: \.self) { index in
                                Circle()
                                    .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: currentIndex == index)
                            }
                            Circle()
                                .fill(Color.black.opacity(currentIndex == modules.count ? 1 : 0.1))
                                .frame(width: 8, height: 8)
                                .animation(.spring(), value: currentIndex == modules.count)
                        }
                        .offset(y: height > 600 && height < 700 ? -(height / 3.4)
                                : height > 700 && height < 800 ? -(height / 3.2)
                                : height > 800 && height < 850 ? -(height / 3.1)
                                : height > 850 && height < 900 ? -(height / 3) : -(height / 2.7))
                    
                    Spacer()
                    
                }
                .padding()
                .padding(.top, height < 800 ? height < 700 ? 0 : 30 : 40)
                .background(Color("Background"))
                
                // поднимающийся лист со всеми модулями
                VStack {
                    BottomSheetView()
                        .offset(y: height / 1.4)
                        .offset(y: -curruntOffset > 0 ? -curruntOffset <= (height / 1.5)
                                ? curruntOffset : -(height / 1.5) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ _ in
                            let maxHeight = height
                            withAnimation {
                                addFavModule = false
                                if -curruntOffset > 100 && -curruntOffset < maxHeight / 2 {
                                    if height > 600 && height < 700 {
                                        curruntOffset = -maxHeight / 3
                                    } else if height < 800 && height > 700 {
                                        curruntOffset = -maxHeight / 2.9
                                    } else if height > 800 && height < 900 {
                                        curruntOffset = -maxHeight / 2.75
                                    } else {
                                        curruntOffset = -maxHeight / 2.5
                                    }
                                } else if -curruntOffset > maxHeight / 2.4 {
                                    
                                    curruntOffset = -maxHeight + 190
                                } else {
                                    curruntOffset = 0
                                }
                            }
                            lastOffset = curruntOffset
                        }))
                }
                // UI для поиска
                if search(modules: modules, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty {
                    SearchView(modules: modules, searchQuery: $searchQuery)
                        .offset(y: searchIsActive ? height > 600 && height
                                < 700 ? (height / 4.8) : height > 700 && height
                                < 800 ? (height / 4.6) : height > 800 && height
                                < 900 ? (height / 4.6) : (height / 5) : height)
                } else if !searchQuery.isEmpty {
                    NoResultsView(searchQuery: $searchQuery)
                        .offset(y: searchIsActive ? height > 600 && height
                                < 700 ? (height / 4) : height > 700 && height
                                < 800 ? (height / 4.3) : height > 800 && height
                                < 900 ? (height / 4.6) : (height / 5) : height)
                }
            }
            .offset(y: -height/22.25)
        }
        .ignoresSafeArea(.keyboard)
     
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if addFavModule {
                if height > 500 && height < 700 {
                    curruntOffset = -(height / 3) + gestureOffset + lastOffset
                } else if height < 800 && height > 700 {
                    curruntOffset = -(height / 2.9) + gestureOffset + lastOffset
                } else if height > 800 && height < 900 {
                    curruntOffset = -(height / 2.75) + gestureOffset + lastOffset
                } else {
                    curruntOffset = -(height / 2.5) + gestureOffset + lastOffset
                }
            }
        }
    }
}

struct ChooseModuleView_Previews: PreviewProvider {
    static var previews: some View {
//        ChooseModuleView(modules: Modules.sampleData)
        ChooseModuleView()
    }
}
