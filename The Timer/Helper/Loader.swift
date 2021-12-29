//
//  Loader.swift
//  The Timer
//
//  Created by Bilge Zerre on 25.12.2021.
//

import Foundation
import UIKit

fileprivate let viewTag = 14531453

class Loader {
    
    class func show(_ customView: UIView? = nil) {
        let bgView = UIView()
        let loadingIndicator = UIActivityIndicatorView()
        
        loadingIndicator.style = .large
        loadingIndicator.color = .blue
        var view = UIView()
        if let customView = customView {
            view = customView
        } else {
            if let window = UIApplication.shared.keyWindow {
                view = window
            }
        }
        
        bgView.frame = view.frame
        bgView.tag = viewTag
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        loadingIndicator.frame = CGRect(x: (view.frame.width / 2) - 25, y: (view.frame.height / 2) - 25, width: 50, height: 50)
        loadingIndicator.startAnimating()
        bgView.addSubview(loadingIndicator)
        view.addSubview(bgView)
    }
    
    class func hide(_ customView: UIView? = nil) {
        var view = UIView()
        if let customView = customView {
            view = customView
        } else {
            if let window = UIApplication.shared.keyWindow {
                view = window
            }
        }
        view.viewWithTag(viewTag)?.removeFromSuperview()
    }
}
