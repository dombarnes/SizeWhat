//
//  ItemViewController.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 07/12/2016.
//  Copyright © 2016 Dominic Barnes. All rights reserved.
//

import UIKit
import os.log

class ItemViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  // MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var roomNameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  
  /*
   This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
   or constructed as part of adding a new meal.
   */
  var item: Item?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Handle the text field’s user input through delegate callbacks.
    nameTextField.delegate = self
    descriptionTextField.delegate = self
    typeTextField.delegate = self
    roomNameTextField.delegate = self
    
    if let item = item {
      navigationItem.title = item.name
      
      nameTextField.text = item.name
      nameTextField.tag = 0
      
      descriptionTextField.text = item.descriptionInfo
      descriptionTextField.tag = 1
      
      typeTextField.text = item.type
      typeTextField.tag = 2
      
      roomNameTextField.text = item.roomName
      roomNameTextField.tag = 3
      
      photoImageView.image = item.photo
      ratingControl.rating = item.rating
    }
    updateSaveButtonState()
    
    // Enable the Save button only if the text field has a valid Meal name.
    updateSaveButtonState()

    
    // Add edge swipe for back action
    let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
    edgePan.edges = .left
    view.addGestureRecognizer(edgePan)

  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
      // Try to find next responder
      if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
        nextField.becomeFirstResponder()
      } else {
        // Not found, so remove keyboard.
        textField.resignFirstResponder()
      }
      // Do not add a line break
      return false
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    saveButton.isEnabled = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  // MARK: UIImagePickerControllerDelegate
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // The info dictionary contains multiple representations of the image, and this uses the original.
    guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    }
    photoImageView.image = selectedImage
    
    // Dismiss the picker.
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Navigation
  
  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    super.prepare(for: segue, sender: sender)
    
    // Configure the destination view controller only when the save button is pressed.
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    let name = nameTextField.text ?? ""
    let descriptionInfo = descriptionTextField.text ?? ""
    let type = typeTextField.text ?? ""
    let roomName = roomNameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    
    // Set the item to be passed to ItemTableViewController after the unwind segue.
    item = Item(name: name, descriptionInfo: descriptionInfo, type: type, roomName: roomName, photo: photo, rating: rating)
  }
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddItemMode = presentingViewController is UINavigationController
    
    if isPresentingInAddItemMode {
      dismiss(animated: true, completion: nil)
    }
    else if let owningNavigationController = navigationController {
      owningNavigationController.popViewController(animated: true)
    }
    else {
      fatalError("The ItemViewController is not inside a navigation controller.")
    }
  }
  
  func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
    if recognizer.state == .recognized {
      let isPresentingInAddItemMode = presentingViewController is UINavigationController
      
      if isPresentingInAddItemMode {
        dismiss(animated: true, completion: nil)
      }
      else if let owningNavigationController = navigationController {
        owningNavigationController.popViewController(animated: true)
      }
      else {
        fatalError("The ItemViewController is not inside a navigation controller.")
      }
    }
  }
  
  // MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    
    // Hide the keyboard.
    nameTextField.resignFirstResponder()
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    let imagePickerController = UIImagePickerController()
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .savedPhotosAlbum
    
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  

  // MARK: Private functions
  private func updateSaveButtonState() {

    // Disable the Save button if the text field is empty.
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}
