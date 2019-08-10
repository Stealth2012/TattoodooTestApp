//
//  TattoodooConfiguration.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

struct TatoodooConfiguration {
    static let `default` = TatoodooConfiguration(apiBase: "https://backend-api.tattoodo.com/api/v2")
    
    let apiBase: String
}
