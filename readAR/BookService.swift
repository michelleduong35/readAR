//
//  BookService.swift
//  readAR
//
//  Created by Michelle Duong on 4/16/24.
//

import Foundation

class BookService {
    static func fetchBook(completion: @escaping ([Book]) -> Void) {
        let genres = ["love", "mystery", "science", "history", "fantasy"] // Example genres ("subject" in API)
        let randomGenre = genres.randomElement() ?? "love"
        let url = URL(string: "https://openlibrary.org//subjects/\(randomGenre).json?details=false&limit=10")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BookAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.works)
                }
            } catch let error as DecodingError {
                print("Decoding error: \(error)")
                // Handle the decoding error, e.g., log it or show an alert to the user
            } catch {
                print("General error: \(error)")
                // Handle other types of errors
            }
            // at this point, `data` contains the data received from the response
        }
            task.resume()
        }
    
    private static func parse(data: Data) -> Book? {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let currentBook = jsonDictionary?["current_book"] as? [String: Any],
                  let key = currentBook["key"] as? String,
                  let title = currentBook["title"] as? String,
                  let editionCount = currentBook["editionCount"] as? Int,
                  let coverID = currentBook["coverID"] as? Int,
                  let coverEditionKey = currentBook["coverEditionKey"] as? String,
                  let subjects = currentBook["subjects"] as? [String],
                  let iaCollection = currentBook["iaCollection"] as? [String],
                  let lendingLibrary = currentBook["lendingLibrary"] as? Bool,
                  let printDisabled = currentBook["printDisabled"] as? Bool,
                  let lendingEdition = currentBook["lendingEdition"] as? String,
                  let lendingIdentifier = currentBook["lendingIdentifier"] as? String,
                  let authors = currentBook["authors"] as? [Author],
                  let firstPublishYear = currentBook["firstPublishYear"] as? Int,
                  let ia = currentBook["ia"] as? String,
                  let publicScan = currentBook["publicScan"] as? Bool,
                  let hasFulltext = currentBook["hasFulltext"] as? Bool,
                  let availability = currentBook["availability"] as? Availability else {
                return nil
            }
            return Book(key: key,
                        title: title,
                        editionCount: editionCount,
                        coverID: coverID,
                        coverEditionKey: coverEditionKey,
                        subjects: subjects,
                        iaCollection: iaCollection,
                        lendingLibrary: lendingLibrary,
                        printDisabled: printDisabled,
                        lendingEdition: lendingEdition,
                        lendingIdentifier: lendingIdentifier,
                        authors: authors,
                        firstPublishYear: firstPublishYear,
                        ia: ia,
                        publicScan: publicScan,
                        hasFulltext: hasFulltext,
                        availability: availability)
        } catch {
            print("Error parsing data: \(error)")
            return nil
        }
    }
}
