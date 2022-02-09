//
//  Collapsible.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/6/22.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(action: { self.collapsed.toggle() },
                   label: {
                        HStack {
                            self.label()
                            Spacer()
                            Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                        }
                        .padding(.bottom, 1)
                        .background(Color.gray)
                    }
            )
            .buttonStyle(PlainButtonStyle())
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .infinity)
        }
    }
}

//struct Collapsible_Previews: PreviewProvider {
//    static var previews: some View {
//        Collapsible()
//    }
//}
