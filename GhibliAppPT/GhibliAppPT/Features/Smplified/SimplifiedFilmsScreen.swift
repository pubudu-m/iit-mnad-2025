//
//  SimplifiedFilmsScreen.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-08.
//

import SwiftUI

struct SimplifiedFilmsScreen: View {
    @State var viewModel = SimplifiedFilmsViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle: 
                Text("Idle")
            case .loading:
                ProgressView()
            case .success:
                List(viewModel.films) { film in
                    Text(film.title)
                }
            case .error:
                Text(viewModel.errorMsg)
            }
        }
        .task {
            await viewModel.fetchFilms()
        }
    }
}

#Preview {
    SimplifiedFilmsScreen()
}
