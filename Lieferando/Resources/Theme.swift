//
//  Theme.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

struct Themes {
    struct Fonts {
        static let Title = UIFont.boldSystemFont(ofSize: 18)
        static let Description = UIFont.systemFont(ofSize: 14)
        static let Tags = UIFont.systemFont(ofSize: 13)
    }
}
