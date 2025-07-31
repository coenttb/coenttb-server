//
//  File 2.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 03/06/2022.
//

import Foundation
import Logging
import ServerFoundationEnvVars
import Language

extension EnvVars {
    public var appEnv: AppEnv {
        get { AppEnv(rawValue: self["APP_ENV"]!)! }
        set { self["APP_ENV"] = newValue.rawValue }
    }
}

extension EnvVars {
    public enum AppEnv: String, Sendable, Codable {
        case development
        case production
        case testing
        case staging
    }
}

extension EnvVars {
    public var languages: [Language]? {
        get {
            self["LANGUAGES"]?
                .components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .compactMap(Language.init(rawValue:))
        }
        set { self["LANGUAGES"] = newValue?.map { $0.rawValue }.joined(separator: ",") }
    }
}

extension EnvVars {
    public var taxIdentificationNumber: String? {
        get { self["TAXIDENTIFICATIONNUMBER"] }
        set { self["TAXIDENTIFICATIONNUMBER"] = newValue }
    }
}
