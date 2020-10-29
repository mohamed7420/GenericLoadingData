//
//  Post.swift
//  GenericLoadingData
//
//  Created by Mohamed on 10/29/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import Foundation

class Post: Decodable{
    
    let albumId: Int?
    let title: String?

    enum CodingKeys: String , CodingKey {
        
        case albumId
        case title
    }
}
