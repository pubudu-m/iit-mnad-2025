//
//  InfoRow.swift
//  AnimePrepApp
//
//  Created by Pubudu Mihiranga on 2025-10-30.
//

import SwiftUI

struct InfoRow: View {
    
    let label: String
    let value: String
    
    var body: some View {
        GridRow {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.subheadline)
        }
    }
}
