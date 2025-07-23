//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Foundation
import URLRouting

extension Path<PathBuilder.Component<String>> {
    
    @inlinable public static var well_known: Path<PathBuilder.Component<String>> {
        Path { ".well-known" }
    }
    
    @inlinable public static var appleAppSiteAssociation: Path<PathBuilder.Component<String>> {
        Path { ".well-known/apple-app-site-association" }
    }
    
    @inlinable public static var readmeMd: Path<PathBuilder.Component<String>> {
        Path { "README.md" }
    }
    
    @inlinable public static var licenseTxt: Path<PathBuilder.Component<String>> {
        Path { "LICENSE.txt" }
    }
    
    @inlinable public static var changelogMd: Path<PathBuilder.Component<String>> {
        Path { "CHANGELOG.md" }
    }
    
    // SEO and Social Media Integration Files
    @inlinable public static var openSearchXml: Path<PathBuilder.Component<String>> {
        Path { "opensearch.xml" }
    }
    
    @inlinable public static var rssXml: Path<PathBuilder.Component<String>> {
        Path { "rss.xml" }
    }
    
    @inlinable public static var atomXml: Path<PathBuilder.Component<String>> {
        Path { "atom.xml" }
    }
    
    @inlinable public static var faviconIco: Path<PathBuilder.Component<String>> {
        Path { "favicon.ico" }
    }
    
    @inlinable public static var ogImage: Path<PathBuilder.Component<String>> {
        Path { "og-image.jpg" }
    }
    
    @inlinable public static var robotsTxt: Path<PathBuilder.Component<String>> {
        Path { "robots.txt" }
    }
    
    @inlinable public static var sitemapXml: Path<PathBuilder.Component<String>> {
        Path { "sitemap.xml" }
    }
    
    @inlinable public static var documentation: Path<PathBuilder.Component<String>> {
        Path { "documentation" }
    }
    
    @inlinable public static var assets: Path<PathBuilder.Component<String>> {
        Path { "assets" }
    }
    @inlinable public static var css: Path<PathBuilder.Component<String>> {
        Path { "css" }
    }
    @inlinable public static var scss: Path<PathBuilder.Component<String>> {
        Path { "scss" }
    }
    @inlinable public static var bootstrap: Path<PathBuilder.Component<String>> {
        Path { "bootstrap" }
    }
    @inlinable public static var js: Path<PathBuilder.Component<String>> {
        Path { "js" }
    }
    
    @inlinable public static var file: Path<PathBuilder.Component<String>> {
        Path { "file" }
    }
    
    @inlinable public static var favicon: Path<PathBuilder.Component<String>> {
        Path { "favicon" }
    }
    
    @inlinable public static var logo: Path<PathBuilder.Component<String>> {
        Path { "logo" }
    }
    
    @inlinable public static var image: Path<PathBuilder.Component<String>> {
        Path { "img" }
    }
    
    @inlinable public static var img: Path<PathBuilder.Component<String>> { .image }
    
    @inlinable public static var apple_developer_merchantid_domain_association: Path<PathBuilder.Component<String>> {
        Path { "apple-developer-merchantid-domain-association" }
    }
    
    @inlinable public static var manifestJson: Path<PathBuilder.Component<String>> {
        Path { "manifest.json" }
    }
    
    @inlinable public static var humansTxt: Path<PathBuilder.Component<String>> {
        Path { "humans.txt" }
    }
    
    @inlinable public static var crossdomainXml: Path<PathBuilder.Component<String>> {
        Path { "crossdomain.xml" }
    }
    
    @inlinable public static var api: Path<PathBuilder.Component<String>> {
        Path { "api" }
    }
    
    @inlinable public static var graphql: Path<PathBuilder.Component<String>> {
        Path { "graphql" }
    }
    
    @inlinable public static var opensearchXml: Path<PathBuilder.Component<String>> {
        Path { "opensearch.xml" }
    }
    
    @inlinable public static var browserconfigXml: Path<PathBuilder.Component<String>> {
        Path { "browserconfig.xml" }
    }
    
    @inlinable public static var siteVerification: Path<PathBuilder.Component<String>> {
        Path { "site-verification" }
    }
    
    @inlinable public static var error404: Path<PathBuilder.Component<String>> {
        Path { "404" }
    }
    
    @inlinable public static var error500: Path<PathBuilder.Component<String>> {
        Path { "500" }
    }
}
