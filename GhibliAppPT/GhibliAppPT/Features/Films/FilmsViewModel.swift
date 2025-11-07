//
//  FilmsViewModel.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-01.
//

import Foundation
import Observation

@Observable
class FilmsViewModel {
    var state: LoadingState<[Film]> = .idle
    
    private let service: DefaultNetworkingService
    
    init(service: DefaultNetworkingService = DefaultNetworkingService()) {
        self.service = service
    }
    
    func fetch() async {
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
