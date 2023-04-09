//
//  WebsiteRequestView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 02.02.2023.
//

import SwiftUI

struct WebsiteRequestView: View { //надо переименовать
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    
    
    
    @State var showBottomBar = false
    @State var searchIsActive = false
    @State var showAdditionalStatuses = false
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var offSet: CGFloat = 0
    @State var searchQuery = ""
    @State var currentStatus: Status = statuses[0]
    
    var body: some View {
    
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .center) {
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
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack {
                            Text(currentStatus.name) //hardcode
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Headings", bundle: bundle))
                            Spacer()
                        }
                        .padding(.horizontal)
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack(spacing: 15) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                            
                            TextField("Enter student name...", text: $searchQuery, onEditingChanged: { search in
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
                        .offset(y: searchIsActive ? height > 600 && height < 700 ? -(height / 6) : height > 700 && height < 800 ? -(height / 7) : height > 800 && height < 850 ? -(height / 7.3) : height > 850 && height < 900 ? -(height / 8) : -(height / 9) : 0)
                        
                        //
                        VStack {
                            HStack {
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(Color.gray)
                                Circle()
                                    .frame(width: 6, height: 6)
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(Color.gray)
                            }
                            if !searchIsActive {
                                CustomProgressBarView() //Сюда нужно передавать что-то
                                //Прогрессбар немного залезает на карточку :(
                                    .padding(10)
                            }
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(someDict[currentStatus.name] ?? []) { user in //someDict == users
                                    NavigationLink(destination: UserView(user: testUser)) {
                                        UserCardView(userCard: user, statusImage: currentStatus.image)
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                            .edgesIgnoringSafeArea(.bottom)
                            
                        }
                        .offset(y: searchIsActive ? -(height / 8) : 0)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .frame(width: width)
                    .blur(radius: showBottomBar ? 4: 0)
                    .offset(y: showBottomBar ? height*0.045: 0)
                    //                .background(
                    //                    showBottomBar ? Color.black.opacity(0.2): Color.white
                    //                )
                    
                    
                    //Bottom надо сделать так, чтобы если кликаешь на зону вне боттомщита он убирался
                    if !showBottomBar && !searchIsActive && !showAdditionalStatuses {
                        Button(action: {
                            withAnimation(Animation.easeIn(duration: 0.2)){
                                showBottomBar.toggle()
                                
                            }
                            
                        }, label: {
                            CustomBottomButton()
                        })
                        .offset(x: -(width / 8), y: (height / 5000))
                    } else if  showBottomBar {
                        //Bottom bar
                        VStack {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 35)
                                    .stroke(Color("MainColor", bundle: bundle).opacity(0.5))
                                    .frame(height: UIScreen.main.bounds.height)
                                    .background(Color.white)
                                    .shadow(color: Color("MainColor", bundle: bundle).opacity(0.5), radius: 5)
                                    .cornerRadius(35)
                                
                                Button(action: {
                                    withAnimation(Animation.easeOut(duration: 0.2)){
                                        showBottomBar.toggle()
                                    }
                                }, label: {})
                                    .buttonStyle(.plain)
                                    .frame(width: width, height: height)
                                VStack(spacing: 20) {
                                    
                                    Image(systemName: "minus")
                                        .resizable()
                                        .imageScale(.large)
                                        .frame(width: 34, height: 3)
                                        .foregroundColor(Color("MainColor", bundle: bundle))
                                    
                                    
                                    HStack {
                                        Text("Change status")
                                            .fontWeight(.bold)
                                        Spacer()
                                    }
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            
                                            ForEach(statuses) { status in
                                                Button(action: {
                                                    withAnimation(Animation.easeIn(duration: 0.2)) {
                                                        currentStatus = status
                                                    }
                                                }, label: {
                                                    VStack {
                                                        if status.image == "globe" {
                                                            ZStack {
                                                                Circle()
                                                                    .stroke(.black, lineWidth: 1)
                                                                    .frame(width: 30, height: 30)
                                                                Image(systemName: status.image)
                                                            }
                                                        } else {
                                                            Image(systemName: status.image)
//                                                                .fontWeight(.light)
                                                                .frame(width: 30, height: 30)
                                                        }
                                                        Text(status.name)
                                                            .font(.system(size: 9))
                                                    }
                                                    .foregroundColor(.black)
                                                })
                                                //                                            VStack {
                                                //                                                NavigationLink(destination:
                                                //                                                                chooseDestination(name: status.name)
                                                //                                                ) {
                                                //                                                    if status.image == "globe" {
                                                //                                                        ZStack {
                                                //                                                            Circle()
                                                //                                                                .stroke(.black, lineWidth: 1)
                                                //                                                                .frame(width: 30, height: 30)
                                                //                                                            Image(systemName: status.image)
                                                //                                                        }
                                                //                                                    } else {
                                                //                                                        Image(systemName: status.image)
                                                //                                                            .fontWeight(.light)
                                                //                                                            .frame(width: 30, height: 30)
                                                //                                                    }
                                                //                                                }
                                                //                                                .foregroundColor(Color.black)
                                                //                                                Text(status.name)
                                                //                                                    .font(.system(size: 9))
                                                //                                            }
                                            }
                                            Button(action: {
                                                withAnimation(Animation.easeIn(duration: 0.2)) {
                                                    showAdditionalStatuses.toggle()
                                                    showBottomBar.toggle()
                                                }
                                            }, label: {
                                                VStack {
                                                    Image(systemName: "plus")
//                                                        .fontWeight(.light)
                                                        .frame(width: 30, height: 30)
                                                    Text("Add status")
                                                        .font(.system(size: 9))
                                                }
                                                .foregroundColor(.black)
                                            })
                                            
                                        }
                                    }
                                    Spacer()
                                }
                                .padding()
                                
                            }
                        }
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: offSet)
                        .offset(y: height*0.78)
                        //                    .offset(y: showBottomBar ? 0: height)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                    } else if showAdditionalStatuses {
                        //Status Sheet
                        AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus)
                            .edgesIgnoringSafeArea(.bottom)
                            .offset(y: offSet)
                            .offset(y: height*0.05)
                        //                    .offset(y: showBottomBar ? 0: height)
                            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                    }
                    
                }
            }
        
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 {
            offSet = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        if value.translation.height > 0 {
            withAnimation(Animation.easeIn(duration: 0.2)) {
                showBottomBar.toggle()
                offSet = 0
            }
            
        }
    }
    
    //    @ViewBuilder
    //    func chooseDestination(name: String) -> some View {
    //        switch name {
    //            case "Website request":
    //                WebsiteRequestView(users: userCards)
    //                    .navigationBarBackButtonHidden(true)
    //            case "In communication":
    //                InCommunicationView(users: userCards_inCommunication)
    //                    .navigationBarBackButtonHidden(true)
    //            case "Testing period":
    //                TestingPeriodView(users: userCards_testingPeriod)
    //                    .navigationBarBackButtonHidden(true)
    //            case "Student":
    //                StudentView(users: userCards_student)
    //                    .navigationBarBackButtonHidden(true)
    //            default:
    //                EmptyView()
    //
    //        }
    //    }
    
}

struct WebsiteRequestView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteRequestView()
    }
}
