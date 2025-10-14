//
//  ContactSupportView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 20/07/25.
//

import SwiftUI

struct ContactSupportView: View {
    var body: some View {
        List {
            Section(header: Text("Contact")) {
                contactLink(title: "LinkedIn",
                            url: ContactConstants.linkedInURL,
                            icon: "link.circle",
                            accessibilityText: "Open LinkedIn profile of Rodrigo Porto")
                
                contactLink(title: "GitHub",
                            url: ContactConstants.githubURL,
                            icon: "chevron.left.slash.chevron.right",
                            accessibilityText: "Open GitHub profile of Rodrigo Porto")
                
                contactLink(title: "Email",
                            url: ContactConstants.mailtoURL,
                            icon: "envelope",
                            accessibilityText: "Send an email to Rodrigo Porto")
            }
        }
        .navigationTitle("Contact Support")
    }
    
    private func contactLink(title: String, url: URL, icon: String, accessibilityText: String) -> some View {
        Link(destination: url) {
            Label(title, systemImage: icon)
                .accessibilityLabel(accessibilityText)
        }
    }
}


#Preview {
    ContactSupportView()
}
