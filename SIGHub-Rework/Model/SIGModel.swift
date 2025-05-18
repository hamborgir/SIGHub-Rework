//
//  SIG.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 14/05/25.
//

import Foundation
import SwiftData

@Model
final class SIGModel: Identifiable {
    @Attribute(.unique) var id: String
    
    // data
    var name: String
    var realName: String
    var desc: String
    var session: SIGModel.Session
    var category: SIGModel.Category
    var image: String
    var whatsappLink: String
    var pp: String
    
    // relationship
    @Relationship(deleteRule: .cascade, inverse: \EventModel.sig) var events: [EventModel]
    
    // init
    init(id: String = UUID().uuidString, name: String, realName: String, desc: String, session: Session, category: Category, image: String, whatsappLink: String, pp: String, events: [EventModel] = []) {
        self.id = id
        self.name = name
        self.realName = realName
        self.desc = desc
        self.session = session
        self.category = category
        self.image = image
        self.whatsappLink = whatsappLink
        self.pp = pp
        self.events = events
    }
    
    static func getData() -> [SIGModel] {
        let sigs: [SIGModel] = [
            .init(
                name: "Hungers Games",
                realName: "Archery Club",
                desc: "A club focused on improving archery skills and competing in local tournaments.",
                session: .both,
                category: .sport,
                image: "archery_club",
                whatsappLink: "https://chat.whatsapp.com/archery",
                pp: "archery_pp"
            ),
            .init(
                name: "Creative Minds",
                realName: "Art & Craft Club",
                desc: "Explore your creativity through various art forms including painting, sculpture, and crafts.",
                session: .afternoon,
                category: .art,
                image: "art_craft_club",
                whatsappLink: "https://chat.whatsapp.com/artcraft",
                pp: "art_pp"
            ),
            .init(
                name: "Growth Hub",
                realName: "Personal Development SIG",
                desc: "Workshops and sessions aimed at personal growth, leadership skills, and career building.",
                session: .morning,
                category: .growth,
                image: "growth_hub",
                whatsappLink: "https://chat.whatsapp.com/growthhub",
                pp: "growth_pp"
            ),
            .init(
                name: "Stage Stars",
                realName: "Drama and Theater Club",
                desc: "Join us for acting workshops, theater productions, and improv nights.",
                session: .both,
                category: .entertainment,
                image: "stage_stars",
                whatsappLink: "https://chat.whatsapp.com/stagestars",
                pp: "theater_pp"
            ),
            .init(
                name: "Fit & Fun",
                realName: "Fitness and Wellness SIG",
                desc: "Group workouts, yoga sessions, and wellness talks to keep you healthy and motivated.",
                session: .morning,
                category: .sport,
                image: "fit_fun",
                whatsappLink: "https://chat.whatsapp.com/fitfun",
                pp: "fitness_pp"
            ),
            .init(
                name: "Ink & Paper",
                realName: "Writing and Poetry Club",
                desc: "For writers and poets looking to share their work and improve their craft.",
                session: .afternoon,
                category: .art,
                image: "ink_paper",
                whatsappLink: "https://chat.whatsapp.com/inkpaper",
                pp: "writing_pp"
            )
        ]
        
        return sigs
    }
    
    enum Session: Codable {
        case morning, afternoon, both
        
        func formattedAsString() -> String {
            switch self {
                case .morning: return "Morning"
                case .afternoon: return "Afternoon"
                case .both: return "Morning & Afternoon"
            }
        }
    }
    
    enum Category: String, CaseIterable, Codable {
        case sport, art, growth, entertainment
    }
}
