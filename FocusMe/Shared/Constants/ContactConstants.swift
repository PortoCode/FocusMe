//
//  ContactConstants.swift
//  FocusMe
//
//  Created by Rodrigo Porto on 20/07/25.
//

import Foundation

enum ContactConstants {
    static let linkedInURL = URL(string: "https://www.linkedin.com/in/rodporto/")!
    static let githubURL = URL(string: "https://github.com/portocode")!
    static let supportEmail = "rporto.dev@gmail.com"
    static let supportEmailSubject = "FocusMe Support"
    
    static var mailtoURL: URL {
        let subject = supportEmailSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "mailto:\(supportEmail)?subject=\(subject)")!
    }
}
