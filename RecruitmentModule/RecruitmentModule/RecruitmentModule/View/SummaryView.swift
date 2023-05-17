//
//  SummaryView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct SummaryView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var user: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {

            Text("Internal Notes")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor", bundle: bundle))
            Spacer()
                .frame(height: height/50)
            Text("Initially, the “Queen” could only move one square at time diagonally. The piece was originally called the “advisor” and was one of the weakest pieces on the board. It wasn’t until chess was brought to Europe and the rise of Queen Isabella during the 15th century that the “advisor” was replaced with the “queen” and became the most powerful piece on the board.The second book ever printed in the English language was  a book about chess. The book, The Game and Playe of the Chesse by William Caxton, was printed in 1474. The first book, also printed by Claxton was The Recuyell of the Historyes of Troye. Mathematically, the number of possible unique games of chess is greater than the number of electrons in the observable universe. The number of electrons is estimated to be about 10^80 , while the number of unique chess games is 10^120 (that’s 1 followed by 120 zeros). There exists a hybrid sport of chess and boxing called chess boxing. Alternating between rounds of four minutes of speed chess and three minutes of boxing, the goal is to achieve a knockout or a checkmate. The origin of the game of pawn vs brawn can be traced back to a 1992 science fiction graphic novel by Yugoslavian-French cartoonist Enki Bilal.") // hardcode
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: width * 0.78)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(user: testTask)
    }
}
