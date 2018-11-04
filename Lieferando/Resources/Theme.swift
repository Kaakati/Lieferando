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
        let Title = UIFont.systemFont(ofSize: 18)
        let Description = UIFont.systemFont(ofSize: 15)
        let Tags = UIFont.systemFont(ofSize: 12)
    }
}
