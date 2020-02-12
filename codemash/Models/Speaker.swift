//
//  Speaker.swift
//  codemash
//
//  Created by Brandon Campbell on 12/5/16.
//  Copyright © 2016 Brandon Campbell. All rights reserved.
//

import SwiftUI

class Speaker : Identifiable {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var gravatarUrl: String = ""
    var image: UIImage!
    
    convenience init(id: String, firstName: String, lastName: String, gravatarUrl: String, image: UIImage) {
        self.init()
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gravatarUrl = gravatarUrl
        self.image = image
    }
}

extension Speaker {
    static func parse(fromDictionary: Dictionary<String, Any>) -> Speaker {
        return Speaker.init(id: fromDictionary["Id"] as! String,
        firstName: fromDictionary["FirstName"] as! String,
        lastName: fromDictionary["LastName"] as! String,
        gravatarUrl: fromDictionary["GravatarUrl"] as! String,
        image: UIImage.init(systemName: "photo")!)
    }
}

#if DEBUG
let testData = [
    Speaker(id: "1e19c0e0-b38c-429b-a3a8-d5dfeecf173d", firstName: "Brandon", lastName: "Campbell", gravatarUrl: "www.gravatar.com/avatar/3f3eb04edcb52a69a21be7ba5de415c8",
            image: UIImage.init(systemName: "photo")!),
    Speaker(id: "02d07b86-5341-462a-89e2-f63144e8025f", firstName: "Michael", lastName: "Collier", gravatarUrl: "www.gravatar.com/avatar/88bb040bfe336c9ccec0f24f706ca109",
            image: UIImage.init(systemName: "photo")!)
]
#endif
