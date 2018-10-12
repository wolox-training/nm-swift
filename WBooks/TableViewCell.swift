//
//  TableViewCell.swift
//  WBooks
//
//  Created by Nicolas Manograsso on 08/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var imgBook: UIImageView!
    
    
    func setText(book: Book){
        lblTitle.text = book.title
        lblAuthor.text = book.author
        let imageURL : String?
        imageURL = book.image
        if imageURL != nil{
            do{
                try imgBook.image = UIImage(data: Data(contentsOf: URL(string: imageURL!)!))
            }
            catch{print("error")}
        }
        

    }

}