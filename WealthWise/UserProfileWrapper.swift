//
//  UserProfileWrapper.swift
//  WealthWise
//
//  Created by marhuenda joris on 09/09/2023.
//

import SwiftUI
import Combine

class UserProfileWrapper: ObservableObject {
    @Published var userProfile = UserProfile()
}
