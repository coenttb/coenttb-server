//
//  File 2.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 03/06/2022.
//

import EnvironmentVariables
import Foundation
import Logging

extension EnvVars {
    public var baseUrl: URL {
        get { URL(string: self["BASE_URL"]!)! }
        set { self["BASE_URL"] = newValue.absoluteString }
    }

    public var port: Int {
        get { Int(self["PORT"]!)! }
        set { self["PORT"] = String(newValue) }
    }
}

extension EnvVars {
    public var allowedInsecureHosts: [String]? {
        get { self["ALLOWED_INSECURE_HOSTS"]?.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        set { self["ALLOWED_INSECURE_HOSTS"] = newValue?.joined(separator: ",") }
    }

    public var canonicalHost: String? {
        get { self["CANONICAL_HOST"] }
        set { self["CANONICAL_HOST"] = newValue }
    }

    public var emergencyMode: Bool {
        get { self["EMERGENCY_MODE"] == "1" }
        set { self["EMERGENCY_MODE"] = newValue ? "1" : "0" }
    }

    public var httpsRedirect: Bool? {
        get { self["HTTPS_REDIRECT"].map { $0 == "true" } }
        set { self["HTTPS_REDIRECT"] = newValue.map { $0 ? "true" : "false" } }
    }

    public var logLevel: Logger.Level? {
        get { self["LOG_LEVEL"].flatMap { Logger.Level(rawValue: $0) } }
        set { self["LOG_LEVEL"] = newValue?.rawValue }
    }

    public var localSslServerCrt: String? {
        get { self["LOCAL-SSL-SERVER-CRT"] }
        set { self["LOCAL-SSL-SERVER-CRT"] = newValue }
    }

    public var localSslServerKey: String? {
        get { self["LOCAL-SSL-SERVER-KEY"] }
        set { self["LOCAL-SSL-SERVER-KEY"] = newValue }
    }
}

extension EnvVars {
    public var appleDeveloperMerchantIdDomainAssociation: String? {
        get { self["APPLE-DEVELOPER-MERCHANTID-DOMAIN-ASSOCIATION"] }
        set { self["APPLE-DEVELOPER-MERCHANTID-DOMAIN-ASSOCIATION"] = newValue }
    }
}

extension EnvVars {
    public var taxIdentificationNumber: String? {
        get { self["TAXIDENTIFICATIONNUMBER"] }
        set { self["TAXIDENTIFICATIONNUMBER"] = newValue }
    }
}

extension EnvVars {
    package static var localWebDevelopment: EnvVars {
        try! EnvVars(dictionary: [
            "APP_ENV": "testing",
            "APP_SECRET": "test_secret",
            "BASE_URL": "http://localhost:8080",
            "PORT": "8080",
            "GITHUB_CLIENT_ID": "test_github_id",
            "GITHUB_CLIENT_SECRET": "test_github_secret",
            "MAILGUN_BASE_URL": "https://api.mailgun.net",
            "MAILGUN_PRIVATE_API_KEY": "test_mailgun_key",
            "MAILGUN_DOMAIN": "test.mailgun.domain",
            "DATABASE_URL": "postgres://test:test@localhost:5432/test_db",
            "STRIPE_ENDPOINT_SECRET": "test_stripe_endpoint_secret",
            "STRIPE_PUBLISHABLE_KEY": "test_stripe_publishable_key",
            "STRIPE_SECRET_KEY": "test_stripe_secret_key"
        ], requiredKeys: .requiredKeys
        )
    }
}

extension Set<String> {
    package static let requiredKeys: Set<String> = [
        "APP_SECRET",
        "APP_ENV",
        "BASE_URL",
        "PORT"
    ]
}
