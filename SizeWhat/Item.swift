//
//  Item.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 07/12/2016.
//  Copyright © 2016 Trilby Multimedia Limited. All rights reserved.
//

import UIKit

class Item {
  // MARK: Properties
  var name: String
  var description: String
  var type: String
  var roomName: String
  var photo: UIImage
  
  // MARK: Initialization
  
  init?(name: String, description: String, type: String, roomName: String, photo: UIImage?) {
    self.name = name
    self.description = description
    self.type = type
    self.roomName = roomName
    self.photo = photo!
    
    if name.isEmpty {
      return nil
    }
  }
}
