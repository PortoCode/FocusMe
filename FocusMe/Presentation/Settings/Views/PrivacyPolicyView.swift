//
//  PrivacyPolicyView.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 20/07/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("1. Introduction")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("We value your privacy and are committed to protecting your personal information. This policy outlines how we collect, use, and safeguard your data.")
                        .accessibilityLabel("We value your privacy and are committed to protecting your personal information. This policy outlines how we collect, use, and safeguard your data.")
                    
                    Text("2. Data Collection")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("We may collect limited data such as device information, app usage statistics, and settings preferences to improve your experience.")
                        .accessibilityLabel("We may collect limited data such as device information, app usage statistics, and settings preferences to improve your experience.")
                    
                    Text("3. Data Usage")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("Your data is used solely for enhancing functionality and providing personalized features. We do not share or sell your information.")
                        .accessibilityLabel("Your data is used solely for enhancing functionality and providing personalized features. We do not share or sell your information.")
                    
                    Text("4. Third-Party Services")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("We may use third-party tools for analytics or notifications. These services comply with industry-standard privacy practices.")
                        .accessibilityLabel("We may use third-party tools for analytics or notifications. These services comply with industry-standard privacy practices.")
                    
                    Text("5. Your Choices")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("You can opt out of notifications and control data permissions through your device settings.")
                        .accessibilityLabel("You can opt out of notifications and control data permissions through your device settings.")
                    
                    Text("6. Contact")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    Text("If you have any questions or concerns, please contact us at [\(ContactConstants.supportEmail)](\(ContactConstants.mailtoURL))")
                        .accessibilityLabel("Contact us at \(ContactConstants.supportEmail)")
                }
                .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    PrivacyPolicyView()
}
