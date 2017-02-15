//
//  ViewControllerExtensions.swift
//  GifMaker_Swift_Template
//
//  Created by Octavio Cedeno on 2/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

let frameCount = 16
let delayTime: Float = 0.2
let loopCount = 0

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBAction func launchCamera() {
        
        self.present(pickerControllerWithSource(source: UIImagePickerControllerSourceType.camera), animated: true, completion: nil)
    }
    
    func pickerControllerWithSource(source: UIImagePickerControllerSourceType) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.allowsEditing = false
        picker.delegate = self
        
        return picker
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if (mediaType == kUTTypeMovie as String) {
            
            let rawVideoURL = info[UIImagePickerControllerMediaURL] as! NSURL
            convertVideoToGif(videoURL: rawVideoURL)
            dismiss(animated: true, completion: nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func convertVideoToGif(videoURL: NSURL) {
        
        let regift = Regift(sourceFileURL: videoURL as URL, frameCount: frameCount, delayTime: delayTime)
        let gifURL = regift.createGif()
        let gif = GIF(url: gifURL!, videoURL: videoURL, caption: "")
        
        displayGif(gif: gif)
    }
    
    func displayGif(gif: GIF) {
        let gifEditorVC  = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        
        gifEditorVC.gif = gif
        navigationController?.pushViewController(gifEditorVC, animated: true)
    }
    
}
