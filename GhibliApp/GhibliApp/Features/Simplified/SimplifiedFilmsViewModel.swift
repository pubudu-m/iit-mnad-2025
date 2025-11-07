//
//  SimplifiedFilmsViewModel.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-11-07.
//

import Foundation
import Observation

enum SimplifiedViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
}

@Observable
class SimplifiedFilmsViewModel {
    var films: [Film] = []
    var state: SimplifiedViewState = .idle
    
    private let service: DefaultNetworkingService

    init(service: DefaultNetworkingService = DefaultNetworkingService()) {
        self.service = service
    }

    func loadFilms() async {
        state = .loading
        do {
            let fetchedFilms = try await service.fetchFilms()
            films = fetchedFilms
            state = .loaded
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
