//
//  FavoritesViewController.swift
//  readAR
//
//  Created by Michelle Duong on 4/21/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    var favoriteBooks: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Define the attributes for the title
            let titleFont = UIFont(name: "HoeflerText-Regular", size: 25) ?? UIFont.systemFont(ofSize: 25)
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: titleFont,
                .foregroundColor: UIColor.darkGray
            ]

            // Set the title attributes to the navigation bar
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

            // Anything in the defer call is guaranteed to happen last
        do {
            // Show the "Empty Favorites" label if there are no favorite movies
            emptyFavoritesLabel.isHidden = !favoriteBooks.isEmpty
        }
        
        let books = Book.getBooks(forKey: Book.favoritesKey)
        // 2.
        self.favoriteBooks = books
        // 3.
        tableView.reloadData()

        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteBooks.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell

                // Get the movie associated table view row
                let book = favoriteBooks[indexPath.row]

                // Configure the cell (i.e. update UI elements like labels, image views, etc.)

                // image
                if let coverID = book.coverID,
                   let imageUrl = URL(string: "https://covers.openlibrary.org/b/ID/\(coverID)-M.jpg") {
                    cell.bookImageView.loadImage(from: imageUrl)
                    }

                // Set the text on the labels
                cell.titleLabel.text = book.title
                cell.authorLabel.text = "By: " + book.authors.map { $0.name }.joined(separator: ", ")

                // Return the cell for use in the respective table view row
                return cell

        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }

            // Get the selected book from the books array using the selected index path's row
            let selectedBook = favoriteBooks[selectedIndexPath.row]

            // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
            guard let viewController = segue.destination as? ViewController else { return }

            viewController.book = selectedBook
        }
}
