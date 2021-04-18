import Foundation

enum Localization {
    enum App {
        /// SpeedRoomating
        static let title = localized("app.title")
    }

    enum Common {
        enum Action {
            /// Retry
            static let retry = localized("common.action.retry")
        }
    }

    enum Tabbar {
        enum Button {
            static let archived = localized("tabbar.button.archived")
            static let options = localized("tabbar.button.options")
            static let upcoming = localized("tabbar.button.upcoming")
        }
    }

    enum Warning {
        enum Empty {
            static let subtitle = localized("warning.empty.subtitle")
            static let title = localized("warning.empty.title")
        }

        enum Error {
            static let subtitle = localized("warning.error.subtitle")
            static let title = localized("warning.error.title")
        }

        enum Offline {
            static let subtitle = localized("warning.offline.subtitle")
            static let title = localized("warning.offline.title")
        }
    }
}

private extension Localization {
    static func localized(_ key: String) -> String {
        NSLocalizedString(key, tableName: "Localization", bundle: .main, value: "", comment: "")
    }
}
