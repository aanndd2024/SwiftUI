//
//  Config.swift
//  EnvironmentConfig
//
//  Created by Anand Yadav on 08/07/25.
//
import Foundation

enum ConfigManager {

    enum Environment: String {
        case dev = "DEV"
        case qa = "QA"
        case prod = "PROD"
    }

    // MARK: - Compile-Time Environment
    static var environment: Environment {
        #if DEV
        return .dev
        #elseif QA
        return .qa
        #else
        return .prod
        #endif
    }

    // MARK: - Info.plist Driven Config
    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Missing Info.plist key: \(key)")
        }
        return value
    }

    static var baseURL: String {
        value(for: "BASE_API_URL")
    }

    static var apiKey: String {
        value(for: "API_KEY")
    }

    static var isLoggingEnabled: Bool {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "LOGGING_ENABLED") as? String else {
            return false
        }
        return value.uppercased() == "YES"
    }
}
