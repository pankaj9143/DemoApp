//
//  CommonUtility.swift
//  DemoApp
//
//  Created by Mangesh Vyas on 26/08/22.
//

import Foundation
import NVActivityIndicatorView

private let kActivityIndicatorWidth: CGFloat = 100.0
private let kActivityIndicatorHeight: CGFloat = 100.0

class CommonUtility: NSObject {
    static private var indicator: NVActivityIndicatorView!
    class func startLoader() {
        let window : UIWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
        if indicator == nil {
            indicator = NVActivityIndicatorView(frame: CGRect(origin: window.center, size: CGSize(width: kActivityIndicatorWidth, height: kActivityIndicatorHeight)), type: NVActivityIndicatorType.ballRotateChase, color: .systemBlue, padding: 0)
            window.addSubview(indicator)
        }
        indicator.startAnimating()
    }
    
    class func stopLoader() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    class func setImage(imageView: UIImageView, url: String) {
        let imageUrl = URL(string: url)
        imageView.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "noImage.png"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
            },
            completionHandler: { result in
            }
        )
    }
    
    class func showAlertMessage(message: String, title: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(
                alert,
                animated: true,
                completion: nil
            )
        })
    }
    
    class func setUserInPreference (key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: key)
        userDefaults.synchronize()
    }
    
    class func getUserFromPreference (key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        if let hasUser = userDefaults.object(forKey: key) as? Bool {
            return hasUser
        }else{
            return false
        }
    }
}
