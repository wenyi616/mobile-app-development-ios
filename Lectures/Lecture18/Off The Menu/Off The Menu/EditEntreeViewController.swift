//
//  NewEntreeViewController.swift
//  Off The Menu
//
//  Created by Robert Stjacques Jr on 12/4/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class EditEntreeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var detailsArea: UITextView!
    
    @IBOutlet var foodImage: UIImageView!
    
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    var entrees: EntreeDataSource!
    
    let uid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add New Menu Item"
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            cameraButton.isEnabled = false
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // save entree
        if let entree = entrees.getEntree(uid: uid) {
            entree.name = nameField.text!
            entree.price = priceField.text!
            entree.details = detailsArea.text!
            // save image
            ImageHelper.saveImage(foodImage.image!, forUID: entree.entreeID!)
            entrees.save()
        }
        else {
            print("Persistence failed!")
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.sourceType = .camera
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }

    @IBAction func choosePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        foodImage.image = photo
        
        dismiss(animated: true, completion: nil)
    }
}
