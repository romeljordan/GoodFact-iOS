//
//  ShareInfoView.swift
//  Good Fact
//
//  Created by androiddev on 12/18/24.
//

import SwiftUI

struct ShareInfoView: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareInfoView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareInfoView>) {}
}
