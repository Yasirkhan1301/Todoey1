//
//  Item.swift
//  Todoey
//
//  Created by mac on 27/10/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation



class Item : Encodable , Decodable
{
    var title : String = ""
    
    var done : Bool = false
    
    
}
