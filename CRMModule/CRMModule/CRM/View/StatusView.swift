//
//  StatusView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI
import SwiftUITrackableScrollView

public struct StatusView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
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
    @State private var scrollViewContentOffset = CGFloat(0)
    public init() {}
    public var body: some View {
        
        NavigationView {
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
                                
                                Button {
                                    
                                } label: {
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
                                Text(currentStatus.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Headings"))
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
                                            Image("delete")
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
                            
                            HStack(spacing: 10) {
                                ForEach(statuses.indices , id: \.self) { index in
                                    Circle()
                                        .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                                        .frame(width: 8, height: 8)
                                        .animation(.spring(), value: currentIndex == index)
                                }
                                Circle()
                                    .fill(Color.black.opacity(currentIndex == statuses.count ? 1 : 0.1))
                                    .frame(width: 8, height: 8)
                                    .animation(.spring(), value: currentIndex == statuses.count)
                            }
                            .opacity(searchIsActive ? 0 : 1)
                            .padding(.vertical, 6)
                            .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                        
                        CarouselStatusesView(spacing: 15, trailingSpace: 10, index: $currentIndex, items: statuses, curruntAddStatusOffset: $curruntAddStatusOffset, showAdditionalStatuses: $showAdditionalStatuses, currentStatus: $currentStatus) { status in
                            
                            VStack {
                                if scrollViewContentOffset < 30 {
                                    CustomProgressBarView()
                                        .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                                }
                        
                                TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
                                    VStack {
                                        ForEach(someDict[status.name] ?? []) { task in
                                            NavigationLink(destination: TaskView(task: testTask)) {
                                                TaskCardView(taskCard: task, statusImage: status.image)
                                            }
                                            .foregroundColor(.black)
                                            .buttonStyle(.plain)
                                            
                                            
                                        }
                                        .padding(.top, 5)
                                    }
                                    .padding(.bottom, height / 2)
                                    
                                }
                                .edgesIgnoringSafeArea(.bottom)
                                
                            }
                            
                        }

                    }
                    .blur(radius: curruntOffset != 0 ? 4 : 0)
                    .disabled(curruntOffset != 0 ? true : false)
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.2)) {
                            curruntOffset = 0
                        }
                    }
                    .padding()
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 0.2)){
                                    if statuses.count + 1 <= 5 {
                                        if height > 500 && height < 700 {
                                            curruntOffset = -(height / 3)
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -(height / 2.9)
                                        } else if height > 800 && height < 900 {
                                            curruntOffset = -(height / 3.6)
                                        } else {
                                            curruntOffset = -(height / 3.5)
                                        }
                                    } else {
                                        if height > 500 && height < 700 {
                                            curruntOffset = -(height / 3)
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -(height / 2.9)
                                        } else if height > 800 && height < 900 {
                                            curruntOffset = -(height / 2.6)
                                        } else {
                                            curruntOffset = -(height / 2.6)
                                        }
                                    }
                                    showBottomBar = true
                                    
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
        
        }
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
