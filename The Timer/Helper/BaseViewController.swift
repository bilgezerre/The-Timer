//
//  BaseViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 25.12.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func setNavbarInvisible() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setNavbarSeperatorInvisible() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    func setHeaderOnlyTitle(title: String, hideBorder: Bool? = false, showClose: Bool? = false, showBack: Bool = false) {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if !showBack {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
            //self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        }
        if hideBorder ?? false {
            setNavbarSeperatorInvisible()
        }
        let titleLabel = UILabel()
        titleLabel.text = title
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.tintColor = .black

        if showClose ?? false {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            button.setImage(UIImage(named: "closeX"), for: .normal)
            button.tap {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
            let item = UIBarButtonItem(customView: button)
            
            self.navigationItem.rightBarButtonItem = item
        }

    }
    
    func setHeaderNativeBackTitle(title: String) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let titleLabel = UILabel()
        titleLabel.text = title
        self.navigationItem.titleView = titleLabel
    }
    
}
