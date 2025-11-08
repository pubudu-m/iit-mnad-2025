//
//  SimplifiedFilmsViewModel.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-08.
//

import Foundation
import Observation

enum SimplifiedViewState: Equatable {
    case idle
    case loading
    case success
    case error
}

@Observable
class SimplifiedFilmsViewModel {
    var films: [Film] = []
    var errorMsg: String = ""
    var state: SimplifiedViewState = .idle
    
    private let service: DefaultNetworkingService
    
    init() {
        service = DefaultNetworkingService()
    }
    
    func fetchFilms() async {
        state = .loading
        
        do {
            let fetchedFilms = try await service.fetchFilms()
            films = fetchedFilms
            state = .success
        } catch {
            errorMsg = "Something went wrong"
            state = .error
        }
    }
}
