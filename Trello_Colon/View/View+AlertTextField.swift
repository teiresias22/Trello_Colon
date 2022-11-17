//
//  View+AlertTextField.swift
//  Trello_Colon
//
//  Created by Joonhwan Jeon on 2022/11/17.
//

import UIKit
import SwiftUI

extension View {
    
    func presentAlertTextField(title: String, message: String? = nil, defaultTextFieldText: String? = nil, confirmAction: @escaping (String?) -> ()) {
        guard let rootvc = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.text = defaultTextFieldText
        }
        alertController.addAction(.init(title: "Cancel", style: .cancel) { _ in })
        alertController.addAction(.init(title: "Save", style: .default, handler: { _ in
            guard let textField = alertController.textFields?.first else { return }
            confirmAction(textField.text)
        }))
        rootvc.present(alertController, animated: true, completion:  nil)
        
    }
}
