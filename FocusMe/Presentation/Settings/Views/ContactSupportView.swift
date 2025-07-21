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
                Link(destination: URL(string: "https://www.linkedin.com/in/rodporto/")!) {
                    Label("LinkedIn", systemImage: "link.circle")
                        .accessibilityLabel("Open LinkedIn profile of Rodrigo Porto")
                }
                Link(destination: URL(string: "https://github.com/portocode")!) {
                    Label("GitHub", systemImage: "chevron.left.slash.chevron.right")
                        .accessibilityLabel("Open GitHub profile of Rodrigo Porto")
                }
                Link(destination: URL(string: "mailto:rporto.dev@gmail.com?subject=FocusMe%20Support")!) {
                    Label("Email", systemImage: "envelope")
                        .accessibilityLabel("Send an email to Rodrigo Porto")
                }
            }
        }
        .navigationTitle("Contact Support")
    }
}

#Preview {
    ContactSupportView()
}
