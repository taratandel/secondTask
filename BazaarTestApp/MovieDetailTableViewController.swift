//
//  MovieDetailTableViewController.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/20/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import PINRemoteImage
import LinearProgressBarMaterial



class MovieDetailTableViewController: UITableViewController, MovieDelegate {
/// it holds the number of requsted page
    var page = 0
    var currentPage = 2
    var movie = [Movie]()
    var query = ""
    

    let movieHelper = MovieHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intiView()
        movieHelper.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movie.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell", for: indexPath) as! MovieDetailTableViewCell
        let currentMovie = movie[indexPath.row]
        cell.releaseDate.text = "Release Date: \n" + currentMovie.releaseDate
        cell.titleOfTheMovie.text = currentMovie.title
        cell.poster.imageFromURL(urlString: (ValueKeeper.LOAD_PIC + currentMovie.posterPatch))
//        cell.heightOfLabel.constant = AppUtils.heightForView(text: currentMovie.overview, width: cell.movieOverView.frame.size.width)
        cell.movieOverView.text = currentMovie.overview
        if indexPath.row == self.movie.count - 1 {
            if currentPage < page - 1 {
                movieHelper.getMovies(page: self.currentPage, query: self.query)
            
            }
        }
        if indexPath.row == 0 {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        // Configure the cell...

        return cell
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return UITableViewAutomaticDimension
//    }
    func getMovieSuccessfuly(lstMoviev: [Movie], pageNumber: Int) {
        self.currentPage += 1

        for movie in lstMoviev{
            self.movie.append(movie)
        }
        self.tableView.reloadData()
    }
    
    func failedToGetMovie(error: String) {
        ViewHelper.showToastMessage(message: "Trying Again")
        movieHelper.getMovies(page: self.currentPage, query: self.query)

    }
    
    /// initialize the table view subViews
    func intiView(){


        tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.reloadData()

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
