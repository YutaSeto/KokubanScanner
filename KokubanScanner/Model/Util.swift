//
//  Util.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import Foundation

class Util{
    public var dateFormatter:DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy年MM月dd日"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/tokyo")
        dateFormatter.locale = Locale(identifier: "ja-JP")
        return dateFormatter
    }
}
