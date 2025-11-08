//
//  DecimalPadView.swift
//  CirclesAI
//
//  Created by Pubudu Mihiranga on 2025-11-06.
//

import SwiftUI

struct DecimalPadView: View {
    let onKey: (String) -> Void
    let onDone: () -> Void
    
    private let keys: [[String]] = [
        ["1","2","3"],
        ["4","5","6"],
        ["7","8","9"],
        [".","0","Done"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(keys, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { key in
                        Button {
                            if key == "Done" { onDone() } else { onKey(key) }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(.systemGray6))
                                Text(key)
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .frame(height: 56)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
    }
}

#Preview {
    DecimalPadView(onKey: { _ in }, onDone: {})
}
