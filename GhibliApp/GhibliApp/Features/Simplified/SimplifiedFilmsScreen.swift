//
//  SimplifiedFilmsScreen.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-11-07.
//

import SwiftUI

struct SimplifiedFilmsScreen: View {
    @State private var viewModel = SimplifiedFilmsViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Simplified Ghibli Films")
        }
        .task {
            await viewModel.loadFilms()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Text("Idle state.")
                .foregroundColor(.gray)
            
        case .loading:
            ProgressView("Loading films...")
                .progressViewStyle(CircularProgressViewStyle())
            
        case .loaded:
            List(viewModel.films) { film in
                VStack(alignment: .leading, spacing: 6) {
                    Text(film.title)
                        .font(.headline)
                    Text(film.description)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.secondary)
                }
            }
            
        case .error(let message):
            VStack {
                Text("❌ Error: \(message)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    Task { await viewModel.loadFilms() }
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    SimplifiedFilmsScreen()
}
