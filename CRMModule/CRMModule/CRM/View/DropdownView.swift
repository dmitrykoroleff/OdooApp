//
//  DropdownView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct DropdownView: View {
    @State var isSelecting = false
    @State var selectionTitle = ""
    @State var selectedRowId = 0
    let items: [DropdownItem]


    var body: some View {
        
        GeometryReader { _ in
            VStack {
                    HStack {
                        Text(selectionTitle)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .animation(.none)
                        Spacer()
                        Image(systemName: "chevron.down")
                        .font(.system(size: 16, weight: .semibold))
                        .rotationEffect(.degrees( isSelecting ? -180 : 0))

                    }
                    .padding(.horizontal)
                    .foregroundColor(.black)
                    
                    if isSelecting {
                        Divider()
                            .background(.black)
                            

                        VStack(spacing: 5) {
                            dropDownItemsList()
                        }
                    }

                }
                .padding(.vertical)
                .background {
                    ZStack {
                        Rectangle()
                            .fill(.white)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    }
                }
                .onTapGesture {
                    isSelecting.toggle()
                }
                .onAppear {
                    selectedRowId = items[0].id
                    selectionTitle = items[0].title
                }
            .animation(.easeInOut(duration: 0.3))
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
    }
    
    private func dropDownItemsList() -> some View {
        ForEach(items) { item in
            DropdownMenuItemView(isSelecting: $isSelecting, selectionId: $selectedRowId, selectiontitle: $selectionTitle, item: item)
        }
    }
}

struct DropdownItem: Identifiable {
    let id: Int
    let title: String
    let onSelect: () -> Void
}

struct DropdownMenuItemView: View {
    @Binding var isSelecting: Bool
    @Binding var selectionId: Int
    @Binding var selectiontitle: String
    
    let item: DropdownItem

    var body: some View {
        Button(action: {
            isSelecting = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                selectionId = item.id
            }
            selectiontitle = item.title
            item.onSelect()
        }) {
            HStack {
                Image(systemName: "checkmark")
                    .font(.system(size: 14, weight: .bold))
                    .opacity(selectionId == item.id ? 1 : 0)
                Text(item.title)
                    .font(.system(size: 16, weight: .regular, design: .rounded))

                Spacer()

            }
            .padding(.horizontal)
            .foregroundColor(.black)

        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(items: [
            DropdownItem(id: 1, title: "Messages", onSelect: {}),
            DropdownItem(id: 2, title: "Archived", onSelect: {}),
            DropdownItem(id: 3, title: "Trash", onSelect: {})
        ])
            .padding(.horizontal)
    }
}

extension View {
    func customDropdownMenu(items: [DropdownItem]) -> some View {
       ZStack {
            VStack {
                DropdownView(items: items)
                    .padding(.horizontal)
            }
            .zIndex(10)
            self
                .offset(y: 60)
                .zIndex(1)
        }
       .padding()
    }
}



