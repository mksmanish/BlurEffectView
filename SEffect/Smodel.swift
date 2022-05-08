//
//  Smodel.swift
//  SEffect
//
//  Created by Tradesocio on 08/05/22.
//

import Foundation

// MARK: - Welcome
struct Memedata : Decodable {
    let success: Bool?
    let data: DataClass?
}


// MARK: - DataClass
struct DataClass : Decodable {
    let memes: [Meme]?
}

// MARK: - Meme
struct Meme : Decodable{
    let id, name: String?
    let url: String?
    let width, height, boxCount: Int?
}
