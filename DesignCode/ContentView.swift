//
//  ContentView.swift
//  DesignCode
//
//  Created by Scott Gardner on 8/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "sparkles")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("modern architecture, an isometric tiny house, cute illustration, minimalist, vector art, night view")
                .font(.subheadline)
            HStack(spacing: 12) {
                VStack(alignment: .leading) {
                    Text("Size")
                        .foregroundStyle(.secondary)
                    Text("1024x1024")
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Type")
                        .foregroundStyle(.secondary)
                    Text("Upscale")
                }
                
                Divider()

                VStack(alignment: .leading) {
                    Text("Date")
                        .foregroundStyle(.secondary)
                    Text("Today 5:19")
                }
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(height: 44)
        }
        .padding(20)
        .background(.green.gradient)
        .cornerRadius(20)
    }
}

#Preview {
    ContentView()
}
