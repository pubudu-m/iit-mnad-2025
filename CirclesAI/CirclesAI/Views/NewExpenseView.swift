//
//  NewExpenseView.swift
//  CirclesAI
//
//  Created by Pubudu Mihiranga on 2025-11-06.
//

import SwiftUI

struct NewExpenseView: View {
    @State private var expenseType: ExpenseType = .expense
    @State private var expenseCategoryType: ExpenseCategories = .groceries
    @State private var incomeCategoryType: IncomeCategories = .salary
    @State private var amountText: String = ""
    @State private var expenseDate = Date.now
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var isLoading = false
    
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        Picker("Type", selection: $expenseType) {
                            ForEach(ExpenseType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        .controlSize(.large)
                        .frame(width: 200)
                        
                        HStack {
                            Button {
                                onClose()
                            } label: {
                                Image(systemName: "xmark.circle.fill") 
                                    .font(.title2)
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                            
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)

                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        showCamera = true
                    } label: {
                        Label("Add \(expenseType.rawValue.lowercased()) using AI", systemImage: "sparkles")
                            .labelStyle(.titleAndIcon)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .padding(.trailing, 15)
                            .background(
                                Capsule().fill(
                                    LinearGradient(
                                        colors: [Color.purple, Color.indigo, Color.cyan],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            )
                            .overlay(
                                Capsule().stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.trailing, -20)
                
                Spacer()
                
                HStack {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("SGD")
                            .foregroundStyle(.secondary)
                        
                        Text(amountText.isEmpty ? "Amount" : amountText)
                            .font(.title.weight(.semibold))
                            .foregroundStyle(amountText.isEmpty ? .secondary : .primary)
                    }
                    .fixedSize()
                    
                    Button {
                        deleteLastChar()
                    } label: {
                        Image(systemName: "delete.left.fill")
                            .foregroundStyle(.black)
                            .padding(.leading, 4)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                HStack {
                    HStack {
                        DatePicker("", selection: $expenseDate,in: ...Date.now, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        if expenseType == .expense {
                            Picker("Expense Category", selection: $expenseCategoryType) {
                                ForEach(ExpenseCategories.allCases) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                        } else {
                            Picker("Income Category", selection: $incomeCategoryType) {
                                ForEach(IncomeCategories.allCases) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)
                
                
                DecimalPadView(onKey: handleKey, onDone: handleDone)
            }
            .disabled(isLoading)
            .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack(spacing: 16) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .scaleEffect(1.5)
                        Text("Submitting...")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                    .padding(24)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
                }
                .transition(.opacity)
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CameraView { image in
                capturedImage = image
                handleAITransaction()
            }
            .ignoresSafeArea()
        }
    }
    
    private func handleKey(_ key: String) {
        if key == "." {
            guard !amountText.contains(".") else { return }
            amountText = amountText.isEmpty ? "0." : amountText + "."
            return
        }
        if key.count == 1, let _ = Int(key) {
            if amountText == "0", !amountText.contains("."), key == "0" {
                return
            }
            amountText.append(key)
        }
    }
    
    private func handleDone() {
        guard let amount = Double(amountText), amount > 0 else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: expenseDate)
        
        let transactionType = expenseType == .expense ? "DEBIT" : "CREDIT"
        let category = expenseType == .expense ? expenseCategoryType.rawValue : incomeCategoryType.rawValue
        
        let payload = TransactionRequest(
            customer_id: "CUST12345",
            type: transactionType,
            amount: amount,
            currency: "SGD",
            merchant_name: " ",
            category: category,
            description: " ",
            transaction_date: dateString
        )
        
        isLoading = true
        
        Task {
            do {
                let response = try await APIService.shared.request(
                    "/api/v1/transactions",
                    method: .POST,
                    body: payload,
                    responseType: TransactionResponse.self
                )
                print("✅ Transaction Added:", response)
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                isLoading = false
                onClose()
            } catch {
                print("❌ API Error:", error)
                isLoading = false
            }
        }
    }
    
    private func handleAITransaction() {
        guard let image = capturedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        isLoading = true

        Task {
            do {
                let response = try await APIService.shared.uploadMultipart(
                    "/api/v1/import/bill",
                    headers: ["X-Customer-ID": "CUST12345"],
                    parameters: ["customer_id": "CUST12345"],
                    fileData: imageData,
                    fileFieldName: "bill",
                    fileName: "bill.jpg",
                    mimeType: "image/jpeg",
                    responseType: TransactionResponse.self
                )
                
                print("✅ AI Bill Imported:", response)
                try? await Task.sleep(nanoseconds: 500_000_000)
                isLoading = false
                onClose()
            } catch {
                print("❌ Upload Error:", error)
                isLoading = false
            }
        }
    }

    
    private func deleteLastChar() {
        guard !amountText.isEmpty else { return }
        amountText.removeLast()
        if amountText.last == "." { amountText.removeLast() }
        if amountText == "0" { amountText = "" }
    }
}

#Preview {
    NewExpenseView(onClose: {})
}

