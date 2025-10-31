//
//  FilmsViewModel.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation
import Observation

@Observable
class FilmsViewModel {
    var state: LoadingState<[Film]> = .idle
    
    private let service: NetworkService
    
    init(service: NetworkService = DefaultNetworkingService()) {
        self.service = service
    }
    
    func fetch() async {
        guard !state.isLoading || state.error != nil else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
