//
//  FilmImageView.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import SwiftUI

struct FilmImageView: View {
    
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure(_):
                    Text("Could not get image")
                @unknown default:
                    fatalError()
            }
        }
    }
}
