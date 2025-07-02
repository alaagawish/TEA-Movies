//
//  Alerts.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation
import UIKit

class Alerts {
    func showAlert(atVC: UIViewController, msg: String, title: String, dismiss: Bool = false, navigate: Bool = false, draft: Bool = false) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.view.tintColor = .white
        if dismiss {
            let dismissAction = UIAlertAction(title: Constants.OK, style: .default) { _ in
                atVC.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(dismissAction)
        } else if draft {
            let saveDratfAction = UIAlertAction(title: Constants.Yes, style: .default) {[weak self] _ in
                guard self != nil else { return }
                
            }
            let cancel = UIAlertAction(title: Constants.No, style: .cancel) { _ in
                atVC.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(cancel)
            alertController.addAction(saveDratfAction)
        } else {
            let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        atVC.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(atVC: UIViewController, msg: String, title: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.OK, style: .default, handler: nil)
        alertController.view.tintColor = .white
        alertController.addAction(okAction)
        
        atVC.present(alertController, animated: true, completion: nil)
        
    }
}
