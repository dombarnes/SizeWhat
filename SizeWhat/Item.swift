//
//  Item.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 07/12/2016.
//  Copyright © 2016 Trilby Multimedia Limited. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
  
  // MARK: Properties
  var name: String
  var descriptionInfo: String
  var type: String
  var roomName: String
  var photo: UIImage
  var rating: Int
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
  //.URLByAppendingPathComponent("items")
  
  // MARK: Types
  struct PropertyKey {
    static let nameKey = "name"
    static let descriptionInfoKey = "descriptionInfo"
    static let typeKey = "type"
    static let roomNameKey = "roomName"
    static let photoKey = "photo"
    static let ratingKey = "rating"
  }
  
  // MARK: Initialization
  init?(name: String, descriptionInfo: String, type: String, roomName: String, photo: UIImage?, rating: Int) {
    self.name = name
    self.descriptionInfo = descriptionInfo
    self.type = type
    self.roomName = roomName
    self.photo = photo!
    self.rating = rating
    
    super.init()
    
    if name.isEmpty {
      return nil
    }
  }
  
  // MARK: NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.nameKey)
    aCoder.encode(descriptionInfo, forKey: PropertyKey.descriptionInfoKey)
    aCoder.encode(type, forKey: PropertyKey.typeKey)
    aCoder.encode(roomName, forKey: PropertyKey.roomNameKey)
    aCoder.encode(photo, forKey: PropertyKey.photoKey)
    aCoder.encode(rating, forKey: PropertyKey.ratingKey)
  }
  required convenience init?(coder aDecoder: NSCoder){
    let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
    let descriptionInfo = aDecoder.decodeObject(forKey: PropertyKey.descriptionInfoKey) as! String
    let type = aDecoder.decodeObject(forKey: PropertyKey.typeKey) as! String
    let roomName = aDecoder.decodeObject(forKey: PropertyKey.roomNameKey) as! String
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)

    // Must call designated initializer.
    self.init(name: name, descriptionInfo: descriptionInfo, type: type, roomName: roomName, photo: photo, rating: rating)
  }
}
