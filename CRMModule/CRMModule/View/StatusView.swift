//
//  StatusView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI
let bundle = Bundle(identifier: "CRM.CRMModule")
public struct StatusView: View {
    public init() {
        
    }
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var curruntAddStatusOffset: CGFloat = 0
    @State var lastAddStatusOffset: CGFloat = 0
    @GestureState var gestureAddStatusOffset: CGFloat = 0
    @State var searchIsActive = false
    @State var searchQuery = ""
    @State var currentIndex: Int = 0
    @State var liked = false
    @State var status: Int = 0
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var currentStatus: Status = statuses[0]
    let taskCards = TaskCard.sampleWebsiteRequest
    @State var showBottomBar = false
    @State var showAdditionalStatuses = false
    public var body: some View {
        
        NavigationView {
            GeometryReader {_ in 
                ZStack {
                    
                    VStack {
                        Image("logo", bundle: bundle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 22)
                            .offset(y: height < 700 ? 24 : 0)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text("Hello, ")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                
                                Text(verbatim: "aashoshina@miem.hse.ru") // Хардкод
                                    .foregroundColor(Color("Headings"))
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
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        
                        HStack {
                            Text(currentStatus.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Headings", bundle: bundle))
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
                        .offset(y: searchIsActive ? height > 600 && height <
                                700 ? -(height / 6) : height > 700 && height <
                                800 ? -(height / 7) : height > 800 && height <
                                850 ? -(height / 7.3) : height > 850 && height <
                                900 ? -(height / 8) : -(height / 9) : 0)
                        
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
                        .padding(.top, 6)
                        
                        
                        CarouselModulesView(spacing: 15, trailingSpace: 20,
                                            index: $currentIndex, items: statuses,
                                            curruntAddStatusOffset: $curruntAddStatusOffset,
                                            showAdditionalStatuses: $showAdditionalStatuses,
                                            currentStatus: $currentStatus) { taskCard in
                            
                            VStack {
                                CustomProgressBarView()
                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(searchQuery == "" || !searchIsActive ?
                                    someDict[taskCard.name] ?? [] :
                                    search(tasks: taskCards, searchQuery:
                                    searchQuery, currentStatus: currentStatus.name))
                                    { task in //someDict == users
                                        NavigationLink(destination: TaskView(task: testTask)) {
                                            TaskCardView(taskCard: task, statusImage: taskCard.image)
                                        }
                                        .foregroundColor(.black)
                                    }
                                    .padding(.top, 5)
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
                                            curruntOffset = -(height / 4.2)
                                        } else {
                                            curruntOffset = -(height / 2.5)
                                        }
                                    } else {
                                        if height > 500 && height < 700 {
                                            curruntOffset = -(height / 3)
                                        } else if height < 800 && height > 700 {
                                            curruntOffset = -(height / 2.9)
                                        } else if height > 800 && height < 900 {
                                            curruntOffset = -(height / 3.2)
                                        } else {
                                            curruntOffset = -(height / 2.5)
                                        }
                                    }
                                    showBottomBar = true
                                    
                                }
                                
                            }, label: {
                                CustomBottomButton()
                            })
                        }
                    }
                    .padding(.bottom, 100)
                    .padding(.trailing, 40)
                    
                    VStack {
                        BottomSheetView(curruntAddStatusOffset: $curruntAddStatusOffset, currentStatus: $currentStatus, showAdditionalStatuses: $showAdditionalStatuses)
                            .offset(y: height)
                            .offset(y: statuses.count + 1 <= 5 ? (-curruntOffset > 0
                                    ? -curruntOffset <= (height / 4.1) ? curruntOffset
                                    : -(height / 4.1) : 0) : (-curruntOffset > 0
                                    ? -curruntOffset <= (height / 3.1) ? curruntOffset : -(height / 3.1) : 0))
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
                                                curruntOffset = -maxHeight / 3
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 1.5
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 4.2
                                            } else {
                                                curruntOffset = -maxHeight / 2
                                            }
                                        } else {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 1.5
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 3.2
                                            } else {
                                                curruntOffset = -maxHeight / 2
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
                    
                    
                    AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus)
                        .offset(y: height)
                        .offset(y: showAdditionalStatuses ? -curruntAddStatusOffset > 0 ? -curruntAddStatusOffset <= (height - 25) ? curruntAddStatusOffset : -(height - 25) : 0 : 0)
                        .gesture(DragGesture().updating($gestureAddStatusOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showAdditionalStatuses = false
                                if -curruntAddStatusOffset > 150 && -curruntAddStatusOffset < maxHeight / 1.5 {
                                    if height > 600 && height < 700 {
                                        curruntAddStatusOffset = -maxHeight / 3
                                    } else if height < 800 && height > 700 {
                                        curruntAddStatusOffset = -maxHeight / 1.5
                                    } else if height > 800 && height < 900{
                                        curruntAddStatusOffset = -(maxHeight - 30)
                                    } else {
                                        curruntAddStatusOffset = -maxHeight / 2
                                    }
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
                if height > 500 && height < 700 {
                    curruntOffset = -(height / 3) + gestureOffset + lastOffset
                } else if height < 800 && height > 700{
                    curruntOffset = -(height / 1.5) + gestureOffset + lastOffset
                } else if height > 800 && height < 900 {
                    curruntOffset = -(height / 4.2) + gestureOffset + lastOffset
                } else {
                    curruntOffset = -(height / 2.5) + gestureOffset + lastOffset
                }
            }
            self.curruntAddStatusOffset = gestureAddStatusOffset + lastAddStatusOffset
            if showAdditionalStatuses {
                if height > 500 && height < 700 {
                    curruntAddStatusOffset = -(height / 3) + gestureAddStatusOffset + lastAddStatusOffset
                } else if height < 800 && height > 700{
                    curruntAddStatusOffset = -(height / 1.5) + gestureAddStatusOffset + lastAddStatusOffset
                } else if height > 800 && height < 900 {
                    curruntAddStatusOffset = -(height - 30) + gestureAddStatusOffset + lastAddStatusOffset
                } else {
                    curruntAddStatusOffset = -(height / 2.5) + gestureAddStatusOffset + lastAddStatusOffset
                }
            }
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
//        StatusView(taskCards: TaskCard.sampleWebsiteRequest)
        StatusView()
    }
}
