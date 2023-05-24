//
//  ChooseJob.swift
//  RecruitmentModule
//
//  Created by Данила on 16.05.2023.
//

import SwiftUI
import Profile


public struct ViewOfJobs: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var shared: LogicR
    @State private var scrollViewContentOffset = CGFloat(0)
    @State var searchIsActive = false
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var searchQuery = ""
    var userName: String
    var userEmail: String
    public init(shared: LogicR, userName: String, userEmail: String) {
        self.shared = shared
        self.userName = userName
        self.userEmail = userEmail
    }
    public var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack {
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
                                    
                                    Text(verbatim: "\(userEmail)") // Хардкод
                                        .foregroundColor(Color("Headings", bundle: bundle))
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }.padding(.leading, 17)
                                
                                Spacer()
                                
                                // Link to profile
                                NavigationLink(destination: Profile.ProfileView(name: userName, email: userEmail)) {
                                    ZStack {
                                        
                                        Circle()
                                            .foregroundColor(Color("MainColor", bundle: bundle))
                                            .frame(width: 40, height: 40)
                                        
                                        Text("\(shared.getFirstLetter(str: userName))") // Хардкод
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
                                Text("Job Position")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Headings", bundle: bundle))
                                    .padding(.leading, 17)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .offset(y:  headerOffset(searchIsActive: searchIsActive, scrollViewContentOffset: scrollViewContentOffset, height: height))
                        }
                        
                        HStack(spacing: 15) {
                            
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .padding(.leading, 15)
                            
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
                    }
                    
                    Spacer()
                    
                    ScrollView(.vertical) {
                        ForEach(Array(shared.jobIdSet), id: \.self) { id in
                            NavigationLink(destination: StatusView(jobId: id, shared: self.shared, stageId: shared.stageOfJob[id] ?? [], stageName: shared.stageOfJobName[id] ?? [], userName: userName, userEmail: userEmail).onAppear {
                                statusesRecr.removeAll()
                                for item in shared.stageOfJobName[id] ?? [] {
                                    statusesRecr.append(Status(id: UUID(), image: "globe", name: item))
                                }
                            }) {
                                ChooseJob(job: shared.dictIdJob[id] ?? " ", countApplicant: shared.countJobs[id] ?? 0)
                            }
                        }
                    }.onAppear {
                        self.shared.getData()
                    }
                    .navigationBarBackButtonHidden(true)
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
                .offset(x: customBottomButtonOffset(height: height)[0])
            }
        }
    }
}


public struct ChooseJob: View {
    var job: String
    var countApplicant: Int
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    public var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .frame(width: 320, height: 180)
                .foregroundColor(Color(red: 140/255, green: 110/255, blue: 132/255))
            VStack(alignment: .leading, spacing: 20) {
                Text(job)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("1 New Application")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 60) {
                    Text("\(countApplicant) Applications")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text("1 To Recruit")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct ChooseJob_Previews: PreviewProvider {
    static var previews: some View {
        ChooseJob(job: "Chief Executive Officer", countApplicant: 0)
    }
}

