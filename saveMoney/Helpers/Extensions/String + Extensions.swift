//
//  String + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 29.03.2023.
//

import Foundation

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        self ?? ""
    }
}

extension String {
    func localized(_ language: Language) -> String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle: Bundle
        if let path = path {
            bundle = Bundle(path: path) ?? .main
        } else {
            bundle = .main
        }
        return localized(bundle: bundle)
    }
    
    private func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .autoupdatingCurrent

        let date = formatter.date(from: self)
        return date
    }
    
    func correctEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+\\-]{1,256}@[A-Za-z0-9.\\-]{1,256}\\.[A-Za-z]{2,64}")
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return !results.isEmpty
        } catch _ {
            return false
        }
    }
}

extension String {
    func toCorrectNumber() -> String {
        if self.hasPrefix("+7") {
            return self.replacingOccurrences(of: "+7", with: "")
        } else if self.hasPrefix("8") && self.count >= 10 {
            var newString = self
            newString.removeFirst()
            return newString
        } else {
            return self
        }
    }
    
    func toMaskedPhone(withFirstNumber: Bool = false) -> String {

        var phone = self
        
        if !withFirstNumber {
            phone = String(self.dropFirst())
        }

        return "+7 (\(phone.prefix(3))) \(phone[3..<6]) \(phone[6..<8]) \(phone[8..<10])"
    }
    
    func toServerPhone() -> String {
        var phone = self
        phone.insert("7", at: phone.startIndex)
        phone = phone.replacingOccurrences(of: "(", with: "")
        phone = phone.replacingOccurrences(of: ")", with: "")
        return phone.removeSpaces()
    }
}

extension String {

    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, range.lowerBound)),
                                            upper: min(count, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension String {
    func removeSpaces() -> String {
        var string = self
        string.removeAll(where: { $0 == " " })
        return string
    }
}
