//
//  UserView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 03.02.2023.
//

import SwiftUI

struct UserView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var currentIndex = 0
    var user: User
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var showBottomSheet = false
    @State var showAddSchedule = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(spacing: 10) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 22)
                    Spacer()
                        .frame(height: height/80)
                    Text(user.name)
                        .font(.system(size: 20, weight: .bold))
                    Text(user.email)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .underline()
                    Text(user.phone)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(height: height/6)
                Spacer()
                TabView {
                    JobView(user: user)
                    SummaryView(user: testUser)
//                    LogNoteView(user: testUser, notes: notes)
                    //LogNoteView
                    VStack(alignment: .center) {
                        Text("Log note")
                            .font(.system(size: 14))
                            .foregroundColor(Color("MainColor"))
                        List {
                            ForEach(notes) { note in
                                NoteView(note: note)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            
                                        } label: {
                                            //                                    VStack {
                                            //                                        Image(systemName: "trash")
                                            //                                        Text("Cancel")
                                            //
                                            //                                    }
                                            //                                    .foregroundColor(.white)
                                            Label {
                                                Text("Cancel")
                                                    .font(.system(size: 6))
                                            } icon: {
                                                Image(systemName: "trash")
                                            }
                                            .labelStyle(VerticalLabelStyle())
                                            //Does't work :(
                                            
                                        }
                                        .tint(Color("MainColor"))
                                        Button(role: .cancel) {
                                            
                                        } label: {
                                            //                                ZStack {
                                            //                                    Color("MainColor")
                                            //                                    VStack {
                                            //                                        Image(systemName: "square.and.pencil")
                                            //                                        Text("Edit")
                                            //                                            .font(.system(size: 6))
                                            //                                    }
                                            //                                    .foregroundColor(.white)
                                            //                                }
                                            Label("Edit", systemImage: "square.and.pencil")
                                        }
                                        
                                    }
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: height*0.55)
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)){
                                showBottomSheet.toggle()
                            }
                        }, label: {
                            Text("Add new log note")
                                .underline()
                                .foregroundColor(Color("MainColor"))
                        })
                        Spacer()
                        
                    }
                    //LogNoteView ends
                    ScheduleView(user: user, tasks: tasks, showAddSchedule: $showAddSchedule)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear {
                    setupAppearance()
                }
            }
//            .offset(y: showBottomSheet ? height*0.06: 0)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .bold))
            })
            .navigationBarHidden((showBottomSheet || showAddSchedule) ? true: false) //стрелочка улетает и это очень смешно, надо убрать
            
            //bottom sheet надо оформить, как отдельное view
            if showBottomSheet {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color("MainColor").opacity(0.5))
                            .frame(height: UIScreen.main.bounds.height)
                            .background(Color.white)
                            .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
                            .cornerRadius(35)
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation(Animation.easeOut(duration: 0.2)){
                                        showBottomSheet.toggle()
                                    }
                                }, label: {
                                    Text("Cancel")
                                        .foregroundColor(Color("MainColor"))
                                        .font(.system(size: 14))
                                })
                                Spacer()
                                Button(action: {
                                    withAnimation(Animation.easeOut(duration: 0.2)){
                                        notes.append(Note(id: UUID(), user: testUser, text: text, editTime: "Now"))
                                        showBottomSheet.toggle()
                                    }
                                }, label: {
                                    Text("Done")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                })
                            }
                            Spacer()
                                .frame(height: height/20)
                            HStack {
                                Text("Log note")
                                    .font(.system(size: 28))
                                Spacer()
                            }
                            TextField("Enter log note", text: $text) //Очень не очень по сути только для макета, надо переделать
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke()
                                        .offset(y: 20)
                                        .frame(height: 100)
                                    
                                )
                            //                        .offset(y: 20)
                                .frame(height: 100)
                            
                            
                            Spacer()
                        }
                        .frame(width: width * 0.8, height: height * 0.95)
                        
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: offSet)
                .offset(y: height*0.05)
//                .offset(y: showBottomSheet ? 0: height)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
            } else if showAddSchedule {
                AddScheduleView(showAddSchedule: $showAddSchedule)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: offSet)
                    .offset(y: height*0.05)
    //                .offset(y: showBottomSheet ? 0: height)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 {
            offSet = value.translation.height
        }
    }

    func onEnded(value: DragGesture.Value) {
        if value.translation.height > 0 {
            withAnimation(Animation.easeOut(duration: 0.2)) {
                offSet = 0
                showBottomSheet.toggle()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: testUser)
    }
}
