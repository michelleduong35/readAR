//
//  ViewController.swift
//  readAR
//
//  Created by Michelle Duong on 4/12/24.
//

import UIKit

class ViewController: UIViewController {

    //connect to ui
    @IBOutlet weak var descLabel2: UILabel!
    @IBOutlet weak var descLabel1: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    private var books = [Book]()
    var displayedBookIDs: Set<String> = [] //to avoid displaying a repeated book
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descLabel1.layer.cornerRadius = 8.0
        descLabel2.layer.cornerRadius = 8.0
        fetchBooks()
        setupGestureRecognizers()
    }
    
    private func fetchBooks() {
            BookService.fetchBook { [weak self] books in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    if !books.isEmpty {
                        self.books = books
                        self.showRandomBook()
                    } else {
                        print("No books fetched")
                        // Handle empty books case (e.g., show an error message or state)
                    }
                }
            }
        }
    
    private func showRandomBook() {
        let newBooks = books.filter { !displayedBookIDs.contains($0.lendingIdentifier) }
        guard let randomBook = newBooks.randomElement() else {
            print("No new books to display")
            // Handle case where no new books are available, e.g., show a message
            return
        }

        displayedBookIDs.insert(randomBook.lendingIdentifier)
        updateBookUI(with: randomBook)
    }
    
    private func updateBookUI(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = "By: " + book.authors.map { $0.name }.joined(separator: ", ")
        if let coverID = book.coverID,
           let imageUrl = URL(string: "https://covers.openlibrary.org/b/ID/\(coverID)-M.jpg") {
            bookImageView.loadImage(from: imageUrl)
                }
        descLabel1.text = book.subjects.first
        descLabel2.text = book.subjects[1]
    }
    
    private func setupGestureRecognizers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print("Not Interested")
        } else if gesture.direction == .right {
            print("Add to Favorites")
            // Later, add logic to save this book to favorites
        }
        showRandomBook()  // Show next random book
    }


}

