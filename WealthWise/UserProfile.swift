//
//  UserProfile.swift
//  WealthWise
//
//  Created by marhuenda joris on 06/09/2023.
//

import SwiftUI

struct UserProfile: Identifiable, Decodable, Encodable {
    var id = UUID().uuidString
    var username: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var selectedCountry: String = "Sélectionner un pays"
    var isNotificationsEnabled: Bool = true
}
