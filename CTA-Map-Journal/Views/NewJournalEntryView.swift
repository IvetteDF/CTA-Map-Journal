//
//  NewJournalEntryView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct NewJournalEntryView: View {
//    private var journalEntry: JournalEntry
    @State var selectedTrainStation: String
    
    @State var title = ""
    @State var entry = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("Start:")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
            }
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text(selectedTrainStation)
                    .font(.headline)
                    .foregroundColor(Color.white)
            }
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("End:")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
//                List {
//                    // list of all train stations
//                }
            }
        }
        TextField("Title", text: $title)
            .padding(.horizontal)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        TextEditor(text: $entry)
            .frame(width: 380.0)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        Button("Submit Entry") {
            // call post method from JournalEntryViewModel
        }
    }
}

//struct NewJournalEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewJournalEntryView()
//    }
//}
