//
//  UITableViewCell+ReusableIdentifier.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Reuse identifier for view.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
