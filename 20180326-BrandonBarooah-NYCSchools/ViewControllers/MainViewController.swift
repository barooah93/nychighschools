//
//  ViewController.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var highSchoolTableView: UITableView!
    
    var highSchools = [HighSchool]()
    var searchedHighSchools = [HighSchool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYC High Schools"
        
        highSchoolTableView.dataSource = self
        highSchoolTableView.delegate = self
        
        searchBar.delegate = self
        
        // Call api
        getHighSchools()
    }
    
    // Method that displays loading overlay on main thread and calls api in the background
    func getHighSchools(){
        // Present loading overlay
        self.PresentLoadingOverlay("Loading High Schools")
        
        DispatchQueue.global().async {
            HighSchoolService.getHighSchools({ (response) in
                self.HideLoadingOverlay()
                
                if(response.httpStatus != 200){
                    // Error
                    let alertController = UIAlertController(title: "Error", message: "Could not retrieve highschools at this time.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: {_ in self.getHighSchools()}))
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if let highschools = response.data as? [HighSchool] {
                        self.highSchools = highschools
                        self.searchedHighSchools = highschools
                        DispatchQueue.main.async {
                            self.highSchoolTableView.reloadData()
                        }
                    }
                }
            })
        }
    }
    
    // Function to call SAT api to get scores of selected highschool, then pushed to details view controller
    func showSATScores(_ highSchool:HighSchool){
        
        guard let dbn = highSchool.dbn else {return} // Can show message here
        
        // Call SAT score api
        SATScoreService.getSATScores(dbn) { serviceResponse in
            if let scores = serviceResponse.data as? [SATScores], scores.count != 0 {
                
                DispatchQueue.main.async {
                    // Push details view controller
                    let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                    detailsVC.highSchool = highSchool
                    detailsVC.scores = scores[0]
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            } else {
                // Handle error
                let alertController = UIAlertController(title: "Error", message: "We could not receive SAT scores from this high school.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    // Having the tableview's delegate and datasource in same file as the view controller follows common patterns, however, to avoid clutter I somtimes move these to their own tablesource class, and utilize delegates to pass messages from tablesource to controller
    // Tableview datasource and delegate methods ---------------------------------------------------------------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedHighSchools.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65 // Arbitrary
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "HighSchoolTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! HighSchoolTableViewCell
        cell.setCellData(searchedHighSchools[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Attempt to get SAT scores ** NOTE ** this could be done in view did load of details view controller, and if failure, pop from stack
        let highSchool = searchedHighSchools[indexPath.row]
        self.showSATScores(highSchool)
    }
   
    // -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

    // Searchbar delegate methods ---------------------------------------------------------------------------------------------------------------------------
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == ""){
            // Reset highschool list
            self.searchedHighSchools = self.highSchools
        } else {
            self.searchedHighSchools = SearchUtilities.getHighSchoolSubset(highSchools, searchText)
        }
        self.highSchoolTableView.reloadData()
    }
    
    // Hide keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    // -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
}

