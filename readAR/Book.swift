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
struct Book: Codable, Equatable {
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
struct Author: Codable, Equatable {
    let key: String
    let name: String
}

// Define the structure for Availability details of a book
struct Availability: Codable, Equatable {
    let status: String
    let isReadable: Bool?
    let isLendable: Bool?
    let isPreviewable: Bool?

    private enum CodingKeys: String, CodingKey {
        case status, isReadable = "is_readable", isLendable = "is_lendable", isPreviewable = "is_previewable"
    }
}

// Methods for saving, retrieving and removing book from favorites
extension Book {
    // The "Favorites" key: a computed property that returns a String.
    //    - Use when saving/retrieving or removing from UserDefaults
    //    - `static` means this property is "Type Property" (i.e. associated with the Movie "type", not any particular boook instance)
    //    - We can access this property anywhere like this... `Book.favoritesKey` (i.e. Type.property)
    static var favoritesKey: String {
        return "Favorites"
    }

    // Save an array of favorite books to UserDefaults.
    static func save(_ books: [Book], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try! JSONEncoder().encode(books)
        defaults.set(encodedData, forKey: key)
    }

    // Get the array of favorite books from UserDefaults
    static func getBooks(forKey key: String) -> [Book] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedBooks = try! JSONDecoder().decode([Book].self, from: data)
            return decodedBooks
        } else {
            return []
        }
    }
    
    // Adds the movie to the favorites array in UserDefaults.
    func addToFavorites() {
        var favoriteBooks = Book.getBooks(forKey: Book.favoritesKey)
        favoriteBooks.append(self)
        Book.save(favoriteBooks, forKey: Book.favoritesKey)
    }

    // Removes the movie from the favorites array in UserDefaults
    func removeFromFavorites() {
        var favoriteBooks = Book.getBooks(forKey: Book.favoritesKey)
        favoriteBooks.removeAll { book in
            return self == book
        }
        Book.save(favoriteBooks, forKey: Book.favoritesKey)
    }
}
