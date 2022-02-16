//
//  SettingsViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/12/22.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var angerColor: String = "Red"
    @Published var disgustColor: String = "Green"
    @Published var fearColor: String = "Blue"
    @Published var joyColor: String = "Yellow"
    @Published var sadnessColor: String = "Purple"
    @Published var surpriseColor: String = "Orange"
    
    @Published var startDate: Date = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
}

