//
//  FRSpine.swift
//  FolioReaderKit
//
//  Created by Heberti Almeida on 06/05/15.
//  Copyright (c) 2015 Folio Reader. All rights reserved.
//

import UIKit

struct Spine {     //本の背
    var linear: Bool!
    var resource: FRResource!
    
    init(resource: FRResource, linear: Bool = true) {   //線形?
        self.resource = resource
        self.linear = linear
    }
}

class FRSpine: NSObject {
    var spineReferences = [Spine]()


    func nextChapter(href:String) -> FRResource? {
        var found = false;

        for item in spineReferences {

            if( found ){
                return item.resource
            }

            if( item.resource.href == href ){
                found = true
            }
        }
        return nil
    }
}
