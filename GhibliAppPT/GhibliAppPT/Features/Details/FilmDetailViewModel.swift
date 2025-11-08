//
//  FilmDetailViewModel.swift
//  GhibliAppPT
//
//  Created by Pubudu Mihiranga on 2025-11-08.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    var state: LoadingState<[Person]> = .idle
    
    private let service: DefaultNetworkingService
    
    init() {
        self.service = DefaultNetworkingService()
    }
    
    func fetchPersons(film: Film) async {
        guard !state.isLoading else { return }

        state = .loading
        
        var loadedPeople: [Person] = []
        
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(urlString: personInfoURL)
                    }
                }
                
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
        } catch {
            state = .error("Something went wrong")
        }
    }
}
