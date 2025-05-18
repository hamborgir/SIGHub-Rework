//
//  EventModel.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 14/05/25.
//

import Foundation
import SwiftData

@Model
final class EventModel {
    // conformance var.
    var id: String
    
    // data
    var name: String
    var desc: String
    var date: Date
    var image: String
    var location: String
    
    // relationship
    @Relationship(deleteRule: .nullify) var sig: SIGModel
    
    init(id: String, name: String, desc: String, date: Date, image: String, location: String, sig: SIGModel) {
        self.id = id
        self.name = name
        self.desc = desc
        self.date = date
        self.image = image
        self.location = location
        self.sig = sig
    }
}
