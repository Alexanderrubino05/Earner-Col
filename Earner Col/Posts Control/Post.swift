//
//  Post.swift
//  Earner Col
//
//  Created by Alexander Rubino on 07/02/2023.
//

import SwiftUI

struct Post {
    //Vi skal bruge dette senere med Firebase
    var id = UUID()
    
    //User
    let username: String
    let profileImage: String
    
    //Post
    let caption: String
    let text: String
    let price: String
    let age: String
    let tag: Tag
    let images: [String]?
}
