//
//  ContentView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
import CRMModule
import RecruitmentModule
import Profile
//let bundle = Bundle(identifier: "chooseModules.ChooseModules")
public struct ChooseModuleView: View {
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var addFavModule = false
    @State var searchIsActive = false
    @State var searchQuery = ""
    @State var currentIndex: Int = 0
    @State var liked = false
    @State var openProfile = false
    @State var openModule: String? = nil
    var gradient1: Gradient
    var gradient2: Gradient
    @State private var progression: CGFloat = 0
    
    let colors: [Color] = [Color("CardColor1", bundle: bundle),
                           Color("CardColor2", bundle: bundle),
                           Color("CardColor3", bundle: bundle),
                           Color("CardColor4", bundle: bundle),
                           Color("CardColor5", bundle: bundle),
                           Color("CardColor6", bundle: bundle),
                           Color("CardColor7", bundle: bundle)]
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    //    let modules: [Modules]
    let modules: [Modules]
    
    public init() {
        modules = Modules.sampleData
        self.gradient1 = Gradient(colors:[Color("GradientColor1", bundle: bundle),
                                        Color("GradientColor2", bundle: bundle),
                                        Color("GradientColor3", bundle: bundle),
                                        Color("GradientColor4", bundle: bundle),
                                        Color("GradientColor1", bundle: bundle)])
        self.gradient2 = Gradient(colors:[Color("GradientColor4", bundle: bundle),
                                         Color("GradientColor1", bundle: bundle),
                                         Color("GradientColor2", bundle: bundle),
                                         Color("GradientColor3", bundle: bundle),
                                         Color("GradientColor4", bundle: bundle)])
        
    }
    
    public var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    NavigationLink(destination: CRMModule.StatusView(),
                                   tag: "CRM",
                                   selection: $openModule)
                    { EmptyView() }
                    NavigationLink(destination: RecruitmentModule.RecruitmentView(),
                                   tag: "Recruitment",
                                   selection: $openModule)
                    { EmptyView() }
                    VStack {
                        Image("logo", bundle: bundle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 22)
                            .offset(y: height < 700 ? 30 : 0)
                            .offset(y: 10)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text("Hello, ")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                
                                Text(verbatim: "aashoshina@miem.hse.ru") // Хардкод
                                    .foregroundColor(Color("Headings", bundle: bundle))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                openProfile.toggle()
                            }) {
                                ZStack {
                                    
                                    Circle()
                                        .foregroundColor(Color("MainColor", bundle: bundle))
                                        .frame(width: 40, height: 40)
                                    
                                    Text("A") // Хардкод
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                }

                            }
                            
                        }
                        .padding(.horizontal, 30)
                        .background(
                            NavigationLink(destination: Profile.ProfileView(), isActive: $openProfile) {
                                
                            }
                                .hidden()
                        )
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        .offset(y: height < 700 ? 40 : 0)
                        
                        HStack {
                            Text("Choose module")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Headings", bundle: bundle))
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        .offset(y: height < 700 ? 40 : 0)
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                            
                            TextField("Enter module name...", text: $searchQuery, onEditingChanged: { search in
                                withAnimation {
                                    searchIsActive = search
                                }
                            })
                            
                        }
                        .padding(.horizontal)
                        .background {
                            ZStack {
                                Color.white
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke()
                                        .frame(width: !searchIsActive ? width - 60 : width - 100, height: 50)
                                    
                                    if searchIsActive {
                                        
                                        Button {
                                            withAnimation {
                                                searchQuery = ""
                                                searchIsActive = false
                                                UIApplication.shared.endEditing()
                                            }
                                            
                                        } label: {
                                            Image("delete", bundle: bundle)
                                                .resizable()
                                            
                                        }
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                        
                                    }
                                    
                                }
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                        .offset(y: searchIsActive ? height > 600 && height < 700 ? -(height / 8.8) :
                                    height > 700 && height < 800 ? -(height / 8.3) :
                                    height > 800 && height < 850 ? -(height / 9.1) :
                                    height > 850 && height < 900 ? -(height / 8.8) : -(height / 9.8) : 0)
                        .offset(y: height < 700 && !searchIsActive ? 40 : 0)
                        // каруселька
                        TabView(selection: $currentIndex) {
                            
                            
                            
                            ForEach(Array(modules.enumerated()), id: \.offset) { offset, element in
                                
                                GeometryReader { _ in
                                    ZStack {
                                        
                                        
                                        Rectangle()
                                            .foregroundColor(colors[Int(generateColorFor(text:
                                                                                            element.name, colors: colors))]) // Хардкод
                                        
                                        
                                        Button(action: {
                                            openModule = element.name
                                        }) {
                                            VStack(alignment: .leading, spacing: 15) {
                                                
                                                HStack {
                                                    
                                                    Spacer()
                                                    
                                                    Image(systemName: "heart.fill")
                                                        .resizable()
                                                        .imageScale(.large)
                                                        .foregroundColor(.white)
                                                        .frame(width: height > 600 && height < 700 ? 20
                                                               : height > 700 && height < 800 ? 21 :
                                                                height > 800 && height < 900 ? 22 :
                                                                25, height: height > 600 && height <
                                                               700 ? 20 : height > 700 && height <
                                                               800 ? 21 : height > 800 && height <
                                                               900 ? 22 : 25)
                                                    
                                                }
                                                
                                                .padding()
                                                .padding(.top, height > 600 && height < 700 ? 2 :
                                                            height > 700 && height < 800 ? 2 :
                                                            height > 800 && height < 900 ? 3 : 5)
                                                .padding(.trailing, height > 600 && height < 700
                                                         ? 2 : height > 700 && height < 800 ? 2 :
                                                            height > 800 && height < 900 ? 3 : 5)
                                                
                                                
                                                Text(element.name).font(.title) /// Хардкод
                                                    .fontWeight(.bold)
                                                    .padding(.horizontal, 30)
                                                    .offset(y: -20)
                                                    .foregroundColor(.white)
                                                
                                                
                                                let viewModule = element.view
                                                Text(String(element.notifications) + " New Notifications") // Хардкод
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 30)
                                                    .offset(y: -20)
                                                    .background(
                                                        Color.white
                                                            .frame(height: 1)
                                                            .offset(y: 10)
                                                            .padding(.horizontal, 30)
                                                            .offset(y: -20)
                                                    )
                                                
                                                Spacer()
                                                
                                            }
                                        }
                                        
                                        
                                    }
                                    .cornerRadius(20)
                                    .padding(.vertical)
                                    .padding(.horizontal, 40)
                                    .frame(height: currentIndex == offset ? height / 4 + 20 : height / 4)
                                    .offset(y: currentIndex == offset ? 0 : 10)
                                    .animation(.easeInOut, value: currentIndex == offset)
                                }
                                .tag(offset)
                            }
                            
                            GeometryReader { _ in
                                
                                ZStack {
                                    
                                    VStack(spacing: 10) {
                                        
                                        Text("Add favourite module")
                                            .fixedSize()
                                        
                                        Image(systemName: "plus")
                                            .imageScale(.large)
                                    }
                                    .foregroundColor(Color("MainColor", bundle: bundle))

                                        animatebleGradient(fromGradient: gradient1, toGradient: gradient2, progress: progression)
                                            .onAppear{
                                                
                                                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses:true)) {
                                                    //MARK: animation turn off
                                                    self.progression = 1
                                                }
                                                
                                            }
                                            .padding(.vertical)
                                            .padding(.horizontal, 40)
                                }
                                .frame(height: currentIndex == modules.count ? height / 4 + 20 : height / 4)
                                .offset(y: currentIndex == modules.count ? 0 : 10)
                                .animation(.easeInOut, value: modules.count == currentIndex)
                                .onTapGesture {
                                    withAnimation {
                                        if height > 500 && height < 700 {
                                            curruntOffset = -(height / 2.9)
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -(height / 2.4)
                                        } else if height > 800 && height < 900 {
                                            curruntOffset = -(height / 2.3)
                                        } else {
                                            curruntOffset = -(height / 2.2)
                                        }
                                        addFavModule = true
                                    }
                                }
                            }
                            .tag(modules.count)
                            
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .tabViewStyle(.page)
                        .frame(height: height / 3)
                        .offset(y: height < 700 ? 40 : 0)
                        
                        // индикаторы пролистывания карусельки
                        HStack(spacing: 10) {
                            ForEach(Array(modules.enumerated()), id: \.offset) { offset, element in
                                Circle()
                                    .fill(Color.black.opacity(currentIndex == offset ? 1 : 0.1))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: currentIndex == offset)
                            }
                            Circle()
                                .fill(Color.black.opacity(modules.count == currentIndex ? 1 : 0.1))
                                .frame(width: 8, height: 8)
                                .animation(.spring(), value: modules.count == currentIndex)
                        }
                        .offset(y: -60)
                        .offset(y: height < 700 ? 60 : 0)
                        
                        
                        Spacer()
                        
                    }
                    .padding(.top, height < 800 ? height < 700 ? 0 : 30 : 40)
                    
                    // поднимающийся лист со всеми модулями
                   
                    VStack {
                        BottomSheetView()
                            .offset(y: height / 1.4)
                            .offset(y: -curruntOffset > 0 ? -curruntOffset <=
                                    (height / 1.5) ? curruntOffset : -(height / 1.5) : 0)
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({ value in
                                let maxHeight = height
                                withAnimation {
                                    addFavModule = false
                                    if -curruntOffset > 100 && -curruntOffset < maxHeight / 2 {
                                        if height > 600 && height < 700 {
                                            curruntOffset = -maxHeight / 2.9
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -maxHeight / 2.4
                                        } else if height > 800 && height < 900{
                                            curruntOffset = -maxHeight / 2.3
                                        } else {
                                            curruntOffset = -maxHeight / 2.2
                                        }
                                    } else if -curruntOffset > maxHeight / 2 {
                                        
                                        if height > 600 && height < 700 {
                                            curruntOffset = -maxHeight  + 210
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -maxHeight  + 240
                                        } else if height > 800 && height < 900{
                                            curruntOffset = -maxHeight + 270
                                        } else {
                                            curruntOffset = -maxHeight + 300
                                        }
                                    }
                                    else {
                                        curruntOffset = 0
                                    }
                                }
                                lastOffset = curruntOffset
                            }))
                    }
                    // UI для поиска
                    if search(modules: modules, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty{
                        SearchView(modules: modules, searchQuery: $searchQuery)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ?
                                    (height / 4.8) : height > 700 && height < 800 ?
                                    (height / 4.6) : height > 800 && height < 900 ?
                                    (height / 4.6) : (height / 5) : height)
                    } else if !searchQuery.isEmpty {
                        NoResultsView(searchQuery: $searchQuery)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ?
                                    (height / 4) : height > 700 && height < 800 ?
                                    (height / 4.3) : height > 800 && height < 900 ?
                                    (height / 4.6) : (height / 5) : height)
                    }
                }
                .offset(y: -height/22.25)
            }
            .ignoresSafeArea(.keyboard)
        }
        
        
    } //end of body
    
    func onChange() {
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if addFavModule {
                if height > 500 && height < 700 {
                    curruntOffset = -(height / 2.9) + gestureOffset + lastOffset
                } else if height < 800 && height > 700{
                    curruntOffset = -(height / 2.4) + gestureOffset + lastOffset
                } else if height > 800 && height < 900 {
                    curruntOffset = -(height / 2.3) + gestureOffset + lastOffset
                } else {
                    curruntOffset = -(height / 2.2) + gestureOffset + lastOffset
                }
            }
        }
    }
    
    
    struct ChooseModuleView_Previews: PreviewProvider {
        static var previews: some View {
            ChooseModuleView()
        }
    }
    
}

