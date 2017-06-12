//
//  RatingControl.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 08/12/2016.
//  Copyright © 2016 Trilby Multimedia Limited. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

  // MARK: Properties
  private var ratingButtons = [UIButton]()
  
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }
  
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  
  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }

  
  // MARK: Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  
  // MARK: Button Action
  @objc func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.index(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    
    // Calculate the rating of the selected button
    let selectedRating = index + 1
    
    if selectedRating == rating {
      // If the selected star represents the current rating, reset the rating to 0.
      rating = 0
    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    }
  }
  
  
  // MARK: Private Methods
  private func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      // If the index of a button is less than the rating, that button should be selected.
      button.isSelected = index < rating
      
      // Set accessibility hint and value
      let hintString: String?
      if rating == index + 1 {
        hintString = "Tap to reset the rating to zero."
      } else {
        hintString = nil
      }
      
      let valueString: String
      switch (rating) {
      case 0:
        valueString = "No rating set."
      case 1:
        valueString = "1 star set."
      default:
        valueString = "\(rating) stars set."
      }
      
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString

    }
  }
  
  private func setupButtons() {
    
    // Clear any existing buttons
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    // Load Button Images
    let bundle = Bundle(for: type(of: self))
    let filledStarImage = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let emptyStarImage = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
    
    for index in 0..<starCount {
      let button = UIButton()
      
      button.setImage(emptyStarImage, for: .normal)
      button.setImage(filledStarImage, for: .selected)
      button.setImage(filledStarImage, for: [.highlighted, .selected])
      button.adjustsImageWhenHighlighted = false
      
      // Add constraints
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
      
      
      // Set the accessibility label
      button.accessibilityLabel = "Set \(index + 1) star rating"

      
      button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      
      // Add the button to the stack
      addArrangedSubview(button)
      
      // Add the new button to the rating button array
      ratingButtons.append(button)
    }
    
    updateButtonSelectionStates()

  }
}
