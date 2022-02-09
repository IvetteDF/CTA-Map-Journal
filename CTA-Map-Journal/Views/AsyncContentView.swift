//
//  AsyncContentView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/8/22.
//

import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
        case .failed (let error):
            ErrorView()
        case .loaded(let output):
            content(output)
        }
    }
}

//struct AsyncContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncContentView()
//    }
//}
