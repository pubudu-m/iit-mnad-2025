//
//  NetworkService.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation

protocol NetworkService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(url: String) async throws -> Person
//    func searchFilm(for searchTerm: String) async throws -> [Film]
}
