//
//  StatusView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI
import SwiftUITrackableScrollView
import Profile

public struct StatusView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var curruntAddStatusOffset: CGFloat = 0
    @State var lastAddStatusOffset: CGFloat = 0
    @GestureState var gestureAddStatusOffset: CGFloat = 0
    @State var searchIsActive = false
    @State var searchQuery = ""
    @State var currentIndex: Int = 0
    @State var status: Int = 0
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var currentStatus: Status = statuses[0]
    let taskCards: [TaskCard] = TaskCard.sampleWebsiteRequest
    @State var showBottomBar = false
    @State var showAdditionalStatuses = false
    var gradient1: Gradient
    var gradient2: Gradient
    @State private var progression: CGFloat = 0
    @State private var scrollViewContentOffset = CGFloat(0)
    public init() {
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
        
            GeometryReader {_ in 
                ZStack {
                    
                    VStack {
                        Image("logo", bundle: bundle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 22)
                            .offset(y: height < 700 ? -15 : 0)
                        
                        if scrollViewContentOffset < 30 {
                            
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
                                
                                NavigationLink(destination: Profile.ProfileView()) {
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
                            .padding()
                            .offset(y:  headerOffset(searchIsActive: searchIsActive, scrollViewContentOffset: scrollViewContentOffset, height: height))
                        }
                        if scrollViewContentOffset < 30 {
                            HStack {
                                Text(currentIndex == statuses.count ? "Add new status" : statuses[currentIndex].name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Headings", bundle: bundle))
                                Spacer()
                            }
                            .padding(.horizontal)
                            .offset(y:  headerOffset(searchIsActive: searchIsActive, scrollViewContentOffset: scrollViewContentOffset, height: height))
                        }
                        
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
                        .offset(y: searchBarOffset(searchIsActive: searchIsActive, scrollViewContentOffset: scrollViewContentOffset, height: height))
                        
                        Spacer()
                            
                        HStack {
                            ForEach(Array(statuses.enumerated()), id: \.offset) { offset, element in
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(currentIndex == offset ? Color.black : Color.gray)

                            }
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(statuses.count == currentIndex ? Color.black : Color.gray)
                        }
                        .padding(.bottom)
                            .opacity(searchIsActive ? 0 : 1)
                            .padding(.vertical, 6)
                            .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                        
                        TabView(selection: $currentIndex) {
                            
                            ForEach(Array(statuses.enumerated()), id: \.offset) { offset, element in
                                VStack {
                                    if scrollViewContentOffset < 30 {
                                        CustomProgressBarView()
                                            .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                                    }
                            
                                    TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
                                        VStack {
                                            ForEach(someDict[element.name] ?? []) { task in
                                                NavigationLink(destination: TaskView(task: testTask)) {
                                                    TaskCardView(taskCard: task, curruntOffset: $curruntOffset, showBottomBar: $showBottomBar, statusImage: element.image)
                                                }
                                                .foregroundColor(.black)
                                                
                                                
                                            }
                                            .padding(.top, 5)
                                        }
                                        .padding(.bottom, height / 2)
                                        
                                        
                                    }
                                    .edgesIgnoringSafeArea(.bottom)
                                    
                                }
                                .tag(offset)
                            }
                            
                            HStack {
                                VStack {
                                    ZStack {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .font(Font.title.weight(.ultraLight))
                                            .frame(width: 60, height: 60)
                                        
                                        animatebleGradient(fromGradient: gradient1, toGradient: gradient2, progress: progression)
                                            .onAppear{
                                                
                                                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses:true)) {
                                                    self.progression = 1
                                                }
                                                
                                            }
                                        
                                    }
                                    .frame(width: width / 1.05, height: height / 2)
                                    .foregroundColor(Color("MainColor", bundle: bundle))
                                    Spacer()
                                }
                            }
                            .tag(statuses.count)
                            .onTapGesture {
                                withAnimation {
                                    curruntAddStatusOffset = -(height)
                                    showAdditionalStatuses = true
                                }
                            }
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .tabViewStyle(.page)

                    }
                    .blur(radius: curruntOffset != 0 ? 4 : 0)
                    .disabled(curruntOffset != 0 ? true : false)
                    .padding()
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.2)) {
                            curruntOffset = 0
                        }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 0.2)){
                                    
                                    self.mode.wrappedValue.dismiss()
                        
                                }
                                
                            }, label: {
                                CustomBottomButton()
                            })
                        }
                    }
                    .offset(x: customBottomButtonOffset(height: height)[0], y: customBottomButtonOffset(height: height)[1])
                        
                        if search(tasks: taskCards, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty{
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                SearchView(taskCards: taskCards, searchQuery: $searchQuery)
                                    .offset(y: searchViewOffset(searchIsActive: searchIsActive, height: height))
                            }
                        } else if !searchQuery.isEmpty {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                NoResultsView(searchQuery: $searchQuery)
                                    .offset(y: searchViewOffset(searchIsActive: searchIsActive, height: height))
                            }
                        }
                    
                    VStack {
                        BottomSheetView(curruntAddStatusOffset: $curruntAddStatusOffset, currentStatus: $currentStatus, index: $currentIndex, showAdditionalStatuses: $showAdditionalStatuses)
                            .offset(y: height)
                            .offset(y: statuses.count + 1 <= 5 ? (-curruntOffset > 0 ? -curruntOffset <= (height / 3.5) ? curruntOffset : -(height / 3.5) : 0) : (-curruntOffset > 0 ? -curruntOffset <= (height / 2.5) ? curruntOffset : -(height / 2.5) : 0))
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({ value in
                                let maxHeight = height
                                withAnimation {
                                    showBottomBar = false
                                    if -curruntOffset > 150 && -curruntOffset < maxHeight / 1.5 {
                                        if statuses.count + 1 <= 5 {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3.6
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 3.6
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 3.6
                                            } else {
                                                curruntOffset = -maxHeight / 3.6
                                            }
                                        } else {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 1.5
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 2.6
                                            } else {
                                                curruntOffset = -maxHeight / 2.6
                                            }
                                        }
                                    }
                                    else {
                                        curruntOffset = 0
                                    }
                                }
                                lastOffset = curruntOffset
                            }))
                    }
                    
                    
                    AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus, currentOffset: $curruntAddStatusOffset, curruntBottomSheetOffset: $curruntOffset)
                        .offset(y: height)
                        .offset(y: -curruntAddStatusOffset > 0 ? -curruntAddStatusOffset <= (height + 10) ? curruntAddStatusOffset : -(height + 10) : 0)
                        .gesture(DragGesture().updating($gestureAddStatusOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showAdditionalStatuses = false
                                if -curruntAddStatusOffset > height / 1.4 && -curruntAddStatusOffset < maxHeight + height / 1.3 {
                                    curruntAddStatusOffset = -maxHeight
                                }
                                else {
                                    curruntAddStatusOffset = 0
                                }
                            }
                            lastAddStatusOffset = curruntAddStatusOffset
                        }))
                    
                    
                }
                
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarHidden(true)
        
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if showBottomBar {
                if statuses.count + 1 <= 5 {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else if height < 800 && height > 700{
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else if height > 800 && height < 900 {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    }
                } else {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 3) + gestureOffset + lastOffset
                    } else if height < 800 && height > 700{
                        curruntOffset = -(height / 1.5) + gestureOffset + lastOffset
                    } else if height > 800 && height < 900 {
                        curruntOffset = -(height / 2.6) + gestureOffset + lastOffset
                    } else {
                        curruntOffset = -(height / 2.6) + gestureOffset + lastOffset
                    }
                }
            }
            self.curruntAddStatusOffset = gestureAddStatusOffset + lastAddStatusOffset
            if showAdditionalStatuses {
                curruntAddStatusOffset = -height + gestureAddStatusOffset + lastAddStatusOffset
            }
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
