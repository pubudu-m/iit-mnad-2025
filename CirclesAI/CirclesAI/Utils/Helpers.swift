//
//  Helpers.swift
//  CirclesAI
//
//  Created by Pubudu Mihiranga on 2025-11-06.
//

import Foundation

enum ExpenseType: String, CaseIterable, Identifiable {
    case expense = "Expense"
    case income = "Income"
    var id: String { self.rawValue }
}

enum ExpenseCategories: String, CaseIterable, Identifiable {
    case groceries = "Groceries"
    case diningOut = "Dining Out"
    case entertainment = "Entertainment"
    case other = "Other"
    
    var id: String { self.rawValue }
}

enum IncomeCategories: String, CaseIterable, Identifiable {
    case salary = "Salary"
    case freelance = "Freelance"
    case cashback = "Cashback"
    case other = "Other"
    
    var id: String { self.rawValue }
}
