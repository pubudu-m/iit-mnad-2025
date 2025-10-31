//
//  LoadingState.swift
//  GhibliApp
//
//  Created by Pubudu Mihiranga on 2025-10-31.
//

import Foundation

enum LoadingState<T: Equatable>: Equatable {
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        } else {
            return false
        }
    }
    
    var data: T? {
        if case .loaded(let value) = self {
            return value
        } else {
            return nil
        }
    }
    
    var error: String? {
        if case .error(let message) = self {
            return message
        } else {
            return nil
        }
    }
}
