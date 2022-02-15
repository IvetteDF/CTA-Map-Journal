//
//  SettingsView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/12/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel

    
    var body: some View {
        Form {
            Section(header: Text("Filter Mood Data")) {
                Text("Select the start date for all mood data analysis:")
                Group {
                    DatePicker(selection: $settings.startDate, in: ...Date(), displayedComponents: .date) {
                        Text("Start Date:")
                    }
                }
            }
            Section(header: Text("Mood Chart Colors")) {
                Text("Select your preferred color scheme:")
                    .navigationTitle("Settings")
                Group{
                    Text("Anger:")
                    Picker("Anger:", selection: $settings.angerColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                Group{
                    Text("Disgust:")
                    Picker("Disgust:", selection: $settings.disgustColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                Group{
                    Text("Fear:")
                    Picker("Fear:", selection: $settings.fearColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                Group{
                    Text("Joy:")
                    Picker("Joy:", selection: $settings.joyColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                Group{
                    Text("Sadness:")
                    Picker("Sadness:", selection: $settings.sadnessColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                Group{
                    Text("Surprise:")
                    Picker("Surprise:", selection: $settings.surpriseColor) {
                        ForEach(TrainLines.themeColorsArray, id: \.self) { color in
                            Text(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
            }
            Section(header: Text("Credits")) {
                Text("Train station data and official CTA train route colors provided by the Chicago Transit Authority (CTA).")
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
