//
//  ItemViewController.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 07/12/2016.
//  Copyright © 2016 Dominic Barnes. All rights reserved.
//

import UIKit

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
    checkValidItemName()

  }
  
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard.
    textField.resignFirstResponder()
    return true
  }
  func textFieldDidBeginEditing(_ textField: UITextField) {
    saveButton.isEnabled = false
  }
  func checkValidItemName() {
    // Disable the Save button if the text field is empty.
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    checkValidItemName()
    navigationItem.title = textField.text
  }
  
  // MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismiss(animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    // The info dictionary contains multiple representations of the image, and this uses the original.
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    photoImageView.image = selectedImage
    // Dismiss the picker.
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Navigation
  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if saveButton === sender as? UIBarButtonItem {
      let name = nameTextField.text ?? ""
      let description = descriptionTextField.text ?? ""
      let type = typeTextField.text ?? ""
      let roomName = roomNameTextField.text ?? ""
      let photo = photoImageView.image
      let rating = ratingControl.rating
      
      item = Item(name: name, description: description, type: type, roomName: roomName, photo: photo, rating: rating)
    }
  }
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    // Hide the keyboard.
    nameTextField.resignFirstResponder()
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    let imagePickerController = UIImagePickerController()
    // imagePickerController.modalPresentationStyle = .popover
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .photoLibrary
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
    //  imagePickerController.popoverPresentationController?.barButtonItem
  }

}
