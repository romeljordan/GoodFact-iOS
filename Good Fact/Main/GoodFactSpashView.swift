//
//  GoodFactSpashView.swift
//  Good Fact
//
//  Created by androiddev on 12/19/24.
//

import SwiftUI

struct GoodFactSpashView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            LoadingAnimationView(tintColor: .white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.blue)
    }
}

#Preview {
    GoodFactSpashView()
}
