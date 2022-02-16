//
//  SelectedJournalEntryView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/1/22.
//

import SwiftUI
import Firebase

struct SelectedJournalEntryView: View {
    
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @Binding var selectedJournalEntry: JournalEntry
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
            }
                .padding(.top, 15.0)
            Spacer()
            VStack {
                Text(selectedJournalEntry.station_name)
                    .italic()
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    HStack {
                        Text(selectedJournalEntry.date)
                        Text(selectedJournalEntry.title)
                    }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        .padding(.horizontal, 10.0)
                }
            }
                .font(.headline)
            Spacer()
                .frame(height: 15)
            Text(selectedJournalEntry.entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.all, 10.0)
            Spacer()
            ZStack{
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("Link(s):")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                    .padding(.horizontal, 10.0)
            }
            VStack(spacing: 0) {
                ForEach(selectedJournalEntry.links, id: \.self) { link in
                    Link("\(link)", destination: URL(string: link) ?? URL(fileURLWithPath: ""))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.horizontal, 10.0)
                }
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            Spacer()
            Button("Delete Entry") {
                dismiss()
                journalEntryViewModel.deleteJournalEntry(entryToDelete: selectedJournalEntry)
            }
                .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(20)
        }
    }
}

//struct SelectedJournalEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedJournalEntryView(selectedJournalEntry: JournalEntry(id: "rJvT9DL0CqL0Yqip8LqW", title: "Showing Off", timestamp: Timestamp(seconds: 1643996703, nanoseconds: 829902000), date: "2/2/22", entry: "Wow my classmates must be so impressed with me this is cool I love life", station_name: "18th (Pink Line)", end_station_name: ""))
//    }
//}
