//
//  ViewController.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "CELL"
    fileprivate let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Movies List"
        viewModel.getMoviesData() {
            self.viewModel.getFromLocalDB {
                self.tableView.reloadData()
            }
        }
    }
    
    // number of sections in table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movies?.count ?? 0
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! MovieTableViewCell
        let array = viewModel.movies
        if !(array?.isEmpty ?? false) {
            let key = Array((array?.keys)!)[indexPath.section]
            let arrayCount = array?[key]
            cell.updateTableViewCell(movies: arrayCount ?? [Movie]())
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let array = viewModel.movies  else {
            return " "
        }
        let keys = Array(array)[section].key
        return keys
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

