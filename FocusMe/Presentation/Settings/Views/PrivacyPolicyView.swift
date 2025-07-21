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
                    Text("We value your privacy and are committed to protecting your personal information. This policy outlines how we collect, use, and safeguard your data.")
                    
                    Text("2. Data Collection")
                        .font(.headline)
                    Text("We may collect limited data such as device information, app usage statistics, and settings preferences to improve your experience.")
                    
                    Text("3. Data Usage")
                        .font(.headline)
                    Text("Your data is used solely for enhancing functionality and providing personalized features. We do not share or sell your information.")
                    
                    Text("4. Third-Party Services")
                        .font(.headline)
                    Text("We may use third-party tools for analytics or notifications. These services comply with industry-standard privacy practices.")
                    
                    Text("5. Your Choices")
                        .font(.headline)
                    Text("You can opt out of notifications and control data permissions through your device settings.")
                    
                    Text("6. Contact")
                        .font(.headline)
                    Text("If you have any questions or concerns, please contact us at [\(ContactConstants.supportEmail)](\(ContactConstants.mailtoURL))")
                        .font(.body)
                }
                .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    PrivacyPolicyView()
}
