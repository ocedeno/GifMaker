//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Octavio Cedeno on 2/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gifImageView : UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var gif: GIF?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        gifImageView.image = gif?.gifImage
        subscribeToKeyboardNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: TextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.placeholder = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Observe and respond to keyboard notifications
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        if (self.view.frame.origin.y >= 0){
            var rect: CGRect = self.view.frame
            rect.origin.y -= getKeyboardHeight(notification: notification)
            self.view.frame = rect
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if (self.view.frame.origin.y < 0){
            var rect: CGRect = self.view.frame
            rect.origin.y += getKeyboardHeight(notification: notification)
            self.view.frame = rect
        }
    }
    
    func getKeyboardHeight(notification: NSNotification)-> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardFrameEnd: NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrameEndRect = keyboardFrameEnd.cgRectValue
        
        return keyboardFrameEndRect.size.height
    }
    
    @IBAction func presentPreview(sender: Any?) {
        let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        gif?.caption = captionTextField.text
        
        let regift = Regift(sourceFileURL: gif?.videoURL as! URL, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        let captionFont = self.captionTextField.font
        let gifURL = regift.createGif(caption: self.captionTextField.text, font: captionFont)
        
        let newGIF = GIF(url: gifURL!, videoURL: (gif?.videoURL)!, caption: self.captionTextField.text)
        previewVC.gif = newGIF
    }
}


