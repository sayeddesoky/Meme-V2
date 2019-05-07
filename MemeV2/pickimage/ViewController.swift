//
//  ViewController.swift
//  pickimage
//
//  Created by Sayed  on 4/19/19.
//  Copyright © 2019 Sayed . All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {

    var editmeme : Meme!
    
    @IBOutlet weak var down: UIToolbar!
    @IBOutlet weak var up: UIToolbar!
    @IBOutlet weak var bottem: UITextField!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagepicker: UIImageView!
    @IBOutlet weak var share: UIBarButtonItem!
    
    
    let TextDelegate = TextFieldDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bottem.delegate = TextDelegate
        top.delegate = TextDelegate
        share.isEnabled = (imagepicker.image != nil)
        if let meme = editmeme {
            EditImage(topText: editmeme.topText, bottemText: editmeme.bottomText, originalimage: editmeme.originalImage)
        } /*else {
            EditImage(topText: "TOP", bottemText: "BOTTEM", originalimage: nil)
        }*/
         }
    
    
    
    func EditImage(topText : String , bottemText : String , originalimage : UIImage){
        textfieldAndString(edittextfield: top , text: topText)
        textfieldAndString(edittextfield: bottem, text: bottemText)
        imagepicker.image = originalimage
    }
    
    func textfieldAndString(edittextfield : UITextField , text : String){
        edittextfield.text = text
        perpareTextField(textfield: edittextfield)
    }
    
    
    
    
    @IBAction func pickimage(_ sender: Any) {
        pick(SourceType: .photoLibrary)
    }
    @IBAction func camera(_ sender: Any) {
        pick(SourceType: .camera)
    }
    func pick(SourceType : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = SourceType
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedimage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagepicker.contentMode = .scaleAspectFit
            imagepicker.image = pickedimage
        }
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        share.isEnabled = (imagepicker.image != nil)
        perpareTextField(textfield: top)
        perpareTextField(textfield: bottem)
        self.tabBarController?.tabBar.isHidden = true
    }

    
    func perpareTextField(textfield : UITextField){
        textfield.defaultTextAttributes = TextDelegate.memeTextAttributes
        textfield.textAlignment = .center
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.tabBarController?.tabBar.isHidden = false

    }
    @IBAction func Share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityView.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                let _ = self.save()
                print("done")
            }
            else {print("eror")}
        }
        self.present(activityView, animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        imagepicker.image = nil
        share.isEnabled = false
        top.text = "TOP"
        bottem.text = "BOTTEM"
    }
    
    func save() {
        // Create the meme
        print("sayed")
        let meme = Meme(topText: top.text!, bottomText: bottem.text!, originalImage: imagepicker.image!, memedImage: generateMemedImage())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        hideToolbar(yes: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideToolbar(yes: false)
        return memedImage
    }
    
    func hideToolbar(yes : Bool){
        up.isHidden = yes
        down.isHidden = yes
        
    }
    
    //MARK: - Keyboard Notifications
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottem.isEditing{
            view.frame.origin.y -= getKeyboardHeight(notification) }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

