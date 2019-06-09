//
//  AddViewController.swift
//  CoreDataPhoneBook
//
//  Created by Chintalapudi Vinod on 6/29/18.
//  Copyright © 2018 brn. All rights reserved.
//

import UIKit
import CoreData
class AddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var item : Entity? = nil
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

       if item == nil
       {
        self.navigationItem.title = "Add new data"
        }
        else
       {
        self.navigationItem.title = item?.texts
        titleField.text = item?.texts
        descField.text = item?.descriptions
        imageViews.image = UIImage(data: (item?.images)! as Data)
        }
    }
    @IBAction func dismissKeyBoard(_ sender: Any) {
        self.resignFirstResponder()
    }
    @IBAction func cameraAction(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.camera
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
        
    }
    @IBAction func mediaAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageViews.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        
        if item == nil
        {
        let enityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: pc)
        let item = Entity(entity:enityDescription! , insertInto: pc)
        
        item.texts = titleField.text
        item.descriptions = descField.text
        item.images = UIImagePNGRepresentation(imageViews.image!) as NSData?
        }else
        {
            item?.texts = titleField.text
            item?.descriptions = descField.text
            item?.images = UIImagePNGRepresentation(imageViews.image!) as NSData?
        }
        
        do
        {
            try pc.save()
        }catch
        {
            print(error)
            return
        }
        navigationController!.popViewController(animated: true)
    }
}
