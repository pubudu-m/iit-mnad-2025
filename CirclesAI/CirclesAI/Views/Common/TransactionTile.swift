private struct TransactionTile: View {
    let transaction: MonthlyExpenseResponse.TransactionItem
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category)
                    .font(.headline)
                Text(formattedDate(transaction.transaction_date))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("\(transaction.type == "DEBIT" ? "-" : "+")SGD \(String(format: "%.2f", transaction.amount))")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(transaction.type == "DEBIT" ? .black : .green)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private func formattedDate(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        if let date = isoFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}