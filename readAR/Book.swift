//
//  Book.swift
//  readAR
//
//  Created by Michelle Duong on 4/21/24.
//

import Foundation
import UIKit

// Define the main structure for the API response
struct BookAPIResponse: Decodable {
    let key: String
    let name: String
    let subjectType: String
    let workCount: Int
    let works: [Book]

    private enum CodingKeys: String, CodingKey {
        case key, name, subjectType = "subject_type", workCount = "work_count", works
    }
}

// Define the structure for each Book
struct Book: Decodable {
    let key: String
    let title: String
    let editionCount: Int?
    let coverID: Int?
    let coverEditionKey: String?
    let subjects: [String]
    let iaCollection: [String]
    let lendingLibrary: Bool
    let printDisabled: Bool
    let lendingEdition: String?
    let lendingIdentifier: String
    let authors: [Author]
    let firstPublishYear: Int?
    let ia: String
    let publicScan: Bool
    let hasFulltext: Bool
    let availability: Availability?

    private enum CodingKeys: String, CodingKey {
        case key, title, editionCount = "edition_count", coverID = "cover_id", coverEditionKey = "cover_edition_key", subjects = "subject", iaCollection = "ia_collection", lendingLibrary = "lendinglibrary", printDisabled = "printdisabled", lendingEdition = "lending_edition", lendingIdentifier = "lending_identifier", authors, firstPublishYear = "first_publish_year", ia, publicScan = "public_scan", hasFulltext = "has_fulltext", availability
    }
}

// Define the structure for each Author
struct Author: Decodable {
    let key: String
    let name: String
}

// Define the structure for Availability details of a book
struct Availability: Decodable {
    let status: String
    let isReadable: Bool?
    let isLendable: Bool?
    let isPreviewable: Bool?

    private enum CodingKeys: String, CodingKey {
        case status, isReadable = "is_readable", isLendable = "is_lendable", isPreviewable = "is_previewable"
    }
}

