//
//  ViewController.swift
//  BazaarTestApp
//
//  Created by Tara Tandel on 4/17/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController, MovieDelegate {


    @IBOutlet weak var indic: UIActivityIndicatorView!
    @IBOutlet weak var movieName: UITextField!
    
    @IBOutlet weak var search: UIButton!
    
    @IBOutlet weak var activityIndic: NVActivityIndicatorView!
    
    @IBOutlet weak var suggestionView: UIView!
    
    @IBOutlet weak var seggestionTableView: UITableView!
    var page = 0
    var movies = [Movie]()
    var searchItem = Search()
    
    let movieHelper = MovieHelper()
    var databaseManager = DatabaseRepository()
    let userDefault = SaveWithUserDef()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func searchMovie(){
        if let query = movieName.text {
            searchItem.title = self.movieName.text!
            indic.isHidden = false
            indic.startAnimating()
            self.search.isEnabled = false
            movieHelper.getMovies(page: 1, query: query)
        }
        else {
            ViewHelper.showToastMessage(message: "Please enter a movie name")
        }
    }
    
    
    /// Initialize The view 
    func initView(){
        self.suggestionView.isHidden
         = true
        self.seggestionTableView.delegate = self
        self.seggestionTableView.dataSource = self
        indic.isHidden = true
        self.search.addTarget(self, action: #selector(self.searchMovie), for: .touchUpInside)
        self.movieHelper.delegate = self
    }
    
    func getMovieSuccessfuly(lstMoviev: [Movie], pageNumber: Int) {
        indic.stopAnimating()
        self.search.isEnabled = true
        if lstMoviev.count > 0 {
            
       
        self.page = pageNumber
        self.movies = lstMoviev
        userDefault.addOrUpdateUserDefault(searchItem: self.searchItem)
        
        performSegue(withIdentifier: "toTableViewSegue", sender: self)
        }
        else {
            ViewHelper.showToastMessage(message: "no such name exists")
        }

    }
    
    func failedToGetMovie(error: String) {
        ViewHelper.showToastMessage(message: error + "\n" + "try again")
        indic.stopAnimating()
        self.search.isEnabled = true

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTableViewSegue"{
            let destVC = segue.destination as! MovieDetailTableViewController
            destVC.page = self.page
            destVC.movie = self.movies
            destVC.query = self.searchItem.title
            
        }
    }
    @IBAction func startTyping(_ sender: Any) {
        if movieName.text?.count == 0 && userDefault.retrive().count > 0{
            suggestionView.isHidden = false
            self.seggestionTableView.reloadData()
        }
        else  {
            suggestionView.isHidden = true
        }
    }
}

