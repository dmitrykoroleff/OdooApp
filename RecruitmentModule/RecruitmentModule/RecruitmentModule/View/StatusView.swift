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
//    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    let bundle = Bundle(identifier: "odoo.miem.ios.Recruitment")
    
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
    var stageID: Array<Int>
    var stageName: Array<String>
    var jobID: Int
    var nameUser: String
    var emailUser: String
    var height = UIScreen.main.bounds.height
    @State var statusRecr: String = "👔Manager"
    @ObservedObject var shared: LogicR
    var width = UIScreen.main.bounds.width
    @State var currentStatus: Status = statusesRecr.count > 0 ? statusesRecr[0] : Status(id: UUID(), image: "globe", name: "👔Manager")
    let taskCards: [TaskCard] = TaskCard.sampleWebsiteRequest
    @State var showBottomBar = false
    @State var showAdditionalStatuses = false
    var gradient1: Gradient
    var gradient2: Gradient
    @State private var progression: CGFloat = 0
    @State private var scrollViewContentOffset = CGFloat(0)
    public init(jobId: Int, shared: LogicR, stageId: Array<Int>, stageName: Array<String>, userName: String, userEmail: String) {
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
        self.jobID = jobId
        self.shared = shared
        self.stageID = stageId
        self.stageName = stageName
        self.nameUser = userName
        self.emailUser = userEmail
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
                                    
                                    Text(verbatim: "\(emailUser)") // Хардкод
                                        .foregroundColor(Color("Headings", bundle: bundle))
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    
                                }
                                
                                Spacer()
                                
                                // Link to profile 
                                NavigationLink(destination: Profile.ProfileView(name: nameUser, email: emailUser)) {
                                    ZStack {
                                        
                                        Circle()
                                            .foregroundColor(Color("MainColor", bundle: bundle))
                                            .frame(width: 40, height: 40)
                                        
                                        Text("\(shared.getFirstLetter(str: nameUser))") // Хардкод
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
                                Text(currentIndex == statusesRecr.count ? "Add new status" : statusesRecr[currentIndex].name)
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
                            ForEach(Array(statusesRecr.enumerated()), id: \.offset) { offset, element in
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(currentIndex == offset ? Color.black : Color.gray)

                            }
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(statusesRecr.count == currentIndex ? Color.black : Color.gray)
                        }
                        .padding(.bottom)
                            .opacity(searchIsActive ? 0 : 1)
                            .padding(.vertical, 6)
                            .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                        
                        TabView(selection: $currentIndex) {
                            
                            ForEach(Array(statusesRecr.enumerated()), id: \.offset) { offset, element in
                                VStack {
                                    if scrollViewContentOffset < 30 {
                                        CustomProgressBarView()
                                            .offset(y: scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0)
                                    }
                                    TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollViewContentOffset) {
                                        VStack {
                                            if currentIndex < statusesRecr.count {
                                                if shared.getCountStatus(status: statusesRecr[currentIndex].name) > 0 {
                                                    ForEach(0..<shared.getCountStatus(status: statusesRecr[currentIndex].name), id: \.self) { user in
                                                        let id = shared.jobInt[shared.stageId[statusesRecr[currentIndex].name]?[user] ?? 0]
                                                        if shared.currentJobID(jobID: jobID, id: id ?? -1) {
                                                            NavigationLink(destination: UserView(user: testUser, name: shared.names, job: shared.job, phone: shared.phone, email: shared.email, group: shared.group, department: shared.department, recruiter: shared.recruiter, hireDate: shared.hireDate, eSalary: shared.eSalary, pSalary: shared.pSalary, description: shared.descrip, appreciation: shared.appreciation, deadline: shared.deadline, summary: shared.activeSummary, index: shared.stageId[statusesRecr[currentIndex].name]?[user] ?? 0)) {
                                                                UserTestCard(index: shared.stageId[statusesRecr[currentIndex].name]?[user] ?? 0, array: shared.names, appreciation: shared.appreciation, shared: LogicR(), curruntOffset: $curruntOffset, showBottomBar: $showBottomBar, statusImage: element.image).environmentObject(LogicR())
                                                            }
                                                            .foregroundColor(.black)
                                                        }
                                                        
                                                    }
                                                    .padding(.top, 5)
                                                }
                                                else {
                                                    Text("There is no application yet!")
                                                        .foregroundColor(.black)
                                                }
                                            }

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
                            .tag(statusesRecr.count)
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
                                SearchView(taskCards: taskCards, searchQuery: $searchQuery, currentIndex: currentIndex, element: Status(id: UUID(), image: "globe", name: "👔Manager"))
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
                            .offset(y: statusesRecr.count + 1 <= 5 ? (-curruntOffset > 0 ? -curruntOffset <= (height / 3.5) ? curruntOffset : -(height / 3.5) : 0) : (-curruntOffset > 0 ? -curruntOffset <= (height / 2.5) ? curruntOffset : -(height / 2.5) : 0))
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({ value in
                                let maxHeight = height
                                withAnimation {
                                    showBottomBar = false
                                    if -curruntOffset > 150 && -curruntOffset < maxHeight / 1.5 {
                                        if statusesRecr.count + 1 <= 5 {
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
                    
                    
                    AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus, currentOffset: $curruntAddStatusOffset, curruntBottomSheetOffset: $curruntOffset, id: jobID, shared: shared)
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
                if statusesRecr.count + 1 <= 5 {
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

//struct StatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusView()
//    }
//}
