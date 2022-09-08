//
//  String+DateFormat.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import Foundation

// TODO: To Change for the bershka formats.
enum CommonDateFormat: String, CaseIterable {
    case onlyDateWithoutTime = "dd/MM/yyyy"
    case dateTime = "yyyy-MM-dd HH:mm"
    case dayMonthYear = "dd MMMM yyyy"
    case onlyTime = "HH:mm"
    case dayMonth = "d MMMM"
    case dateExtended = "yyyy-MM-dd HH:mm:ss Z"
    case monthShort = "MM"
    case monthExtended = "MMMM"
    case dateExtendedTwo = "yyyy-MMMM-dd'T'HH:mm:ssZ"
    case dayShort = "dd"
    case backend = "yyyy-MM-dd"
    case intergrowDate = "MM-dd-yyyy"
    case period = "MM-yyyy"
    case systemTime
    case systemDate
    case filterPeriod = "YYYY-MM-dd"
    case dayName = "EEEE"
    case new = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

private struct BackendDateFormat {
    static let one = "yyyy-MM-dd HH:mm:ss"
    static let two = "yyyy-MM-dd"
}

extension String {

    func getDate() -> Date? {
        let dateFormat = DateFormatter()

        dateFormat.dateFormat = BackendDateFormat.one
        if let date = dateFormat.date(from: self) {
            return date
        }

        dateFormat.dateFormat = BackendDateFormat.two
        if let date = dateFormat.date(from: self) {
            return date
        }

        for format in CommonDateFormat.allCases {
            dateFormat.dateFormat = format.rawValue
            if let date = dateFormat.date(from: self) {
                return date
            }
        }

        return nil
    }

    func dateToShow(_ outputType: CommonDateFormat) -> String {
        let dateFormat = DateFormatter()
        if let date = self.getDate() {

            switch outputType {
            case .systemTime:
                dateFormat.timeStyle = .short
            case .systemDate:
                dateFormat.dateStyle = .long
            default:
                dateFormat.dateFormat = outputType.rawValue
            }

            return dateFormat.string(from: date)
        }

        return ""
    }

    func dateToBackend() ->String {
        let dateFormat = DateFormatter()

        if let date = self.getDate() {
            dateFormat.dateFormat = BackendDateFormat.two
            return dateFormat.string(from: date)
        }

        return ""
    }

    func showAge() -> String {
        let now = Date()
        let calendar = Calendar.current

        if let birthday = self.getDate() {
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            if let age = ageComponents.year {
                return "\(age) Years"
            }
        }

        return ""
    }

    func getAge() -> Int? {
        let now = Date()
        let calendar = Calendar.current

        if let birthday = self.getDate() {
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            if let age = ageComponents.year {
                return age
            }
        }
        return nil
    }
}

extension Date {
    func toString(format: CommonDateFormat) -> String {
        let dateFormat = DateFormatter()

        switch format {
        case .systemTime:
            dateFormat.timeStyle = .short
        case .systemDate:
            dateFormat.dateStyle = .long
        default:
            dateFormat.dateFormat = format.rawValue
        }

        return dateFormat.string(from: self)
    }
}

extension Date {
    var age: Int {
        get {
            let now = Date()
            let calendar = Calendar.current

            let ageComponents = calendar.dateComponents([.year], from: self, to: now)
            let age = ageComponents.year!
            return age
        }
    }

    init(year: Int, mont: Int, day: Int) {
        var dc = DateComponents()
        dc.year = year
        dc.month = mont
        dc.day = day

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        if let date = calendar.date(from: dc) {
            self.init(timeInterval:0 , since: date)
        } else {
            fatalError("Date component values were invalid.")
        }
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
