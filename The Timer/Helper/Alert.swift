//
//  Alert.swift
//  The Timer
//
//  Created by Bilge Zerre on 27.12.2021.
//

import Foundation
import SwiftMessages
import UIKit

class Notification {
    
    class func success(title: String?, text: String?) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureTheme(backgroundColor: .systemGreen, foregroundColor: .white)
        view.button?.isHidden = true
        view.configureDropShadow()
        view.configureContent(title: title ?? "", body: text ?? "Successful", iconImage: .checkmark)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.backgroundView.cornerRadius = 10
        SwiftMessages.show(view: view)
    }
    
    class func error(title: String?, text: String?) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureTheme(backgroundColor: .systemRed, foregroundColor: .white)
        view.button?.isHidden = true
        view.configureDropShadow()
        view.configureContent(title: title ?? "", body: text ?? "Error", iconImage: .remove)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.backgroundView.cornerRadius = 10
        SwiftMessages.show(view: view)
    }

    class func warning(title: String?, text: String?) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureTheme(backgroundColor: .systemYellow, foregroundColor: .white)
        view.button?.isHidden = true
        view.configureDropShadow()
        view.configureContent(title: title ?? "", body: text ?? "Warning", iconImage: .actions)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.backgroundView.cornerRadius = 10
        SwiftMessages.show(view: view)
    }
}
