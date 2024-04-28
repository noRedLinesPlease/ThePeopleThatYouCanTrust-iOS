//
//  PopupKeyboard.swift
//  ThePeopleThatYouCanTrustI
//
//  Created by Brittany Marbaker on 3/10/24.
//

import SwiftUI
import Combine

final class KeyboardGuardian: ObservableObject {
    public var rects: Array<CGRect> = []
    public var keyboardRect: CGRect = CGRect()
    
    // keyboardWillShow notification may be posted repeatedly,
    // this flag makes sure we only act once per keyboard appearance
    public var keyboardIsHidden = true
    
    @Published var slide: CGFloat = 0
    
    var showField: Int = 0 {
        didSet {
            // updateSlide()
        }
    }
    
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                //updateSlide()
            }
        }
    }
    
    @objc func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        //updateSlide()
    }
}


