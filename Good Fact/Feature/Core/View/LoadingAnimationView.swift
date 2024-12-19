//
//  LoadingAnimationView.swift
//  Good Fact
//
//  Created by androiddev on 12/18/24.
//

import SwiftUI

struct LoadingAnimationView: View {
    private var tintColor: Color
    
    init(tintColor: Color = Color.gray) {
        self.tintColor = tintColor
    }
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2.0, anchor: .center)
            .tint(tintColor)
    }
}

#Preview {
    LoadingAnimationView()
}
