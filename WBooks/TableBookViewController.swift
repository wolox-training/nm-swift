//
//  TableBookViewController.swift
//  WBooks
//
//  Created by Nicolas Manograsso on 25/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Networking
import ReactiveSwift
import UIKit
import WolmoCore

final class TableBookViewController: UITableViewController {
    
    private let _bookRepo = NetworkingBootstrapper.shared.createWBooksRepository()
    private var _bookArray = [Book]()
    private var _AllBooksRead = false
    public var didSelectedEnable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "BookCell")
        setTableBackground()
        loadBooks()
    }
    
    func loadBooks(){
        if !_AllBooksRead {
            _bookRepo.fetchBooks().observe(on: UIScheduler()).startWithResult{
                [unowned self] in
                switch $0 {
                case .success(let books):
                    self._AllBooksRead = (books.count == 0)
                    for book in books{
                        self._bookArray.append(book)
                    }
                    
                    self.tableView.reloadData()
                case .failure(let error):  print("\(error)")
                }
            }
        }
    }
    
    func setTableBackground(){
        tableView.backgroundColor = WBookColor.wBooksBackground
        tableView.separatorStyle = .none
    }
}

extension TableBookViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _bookArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = _bookArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.setText(book: book)
        
        if indexPath.row == _bookArray.count - 1 { // last cell
            loadBooks()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if didSelectedEnable{
            let book = _bookArray[indexPath.row]
            let BookDetailVC = BookInfoDetailViewController()
            BookDetailVC.bookDetail.setupTexts(book: book)
            
            self.navigationController?.pushViewController(BookDetailVC, animated: true)
        }
    }
}