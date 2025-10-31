//
//  FilmsScreen.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI

struct FilmsScreen: View {
    @State var filmsViewModel: FilmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    ForEach(films) { film in
                        Text(film.title)
                    }
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
            .task {
                await filmsViewModel.fetch()
            }
        }
    }
}

#Preview {
    FilmsScreen()
}
