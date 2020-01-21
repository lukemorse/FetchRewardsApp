//
//  RetrieveItemsViewController.swift
//  FetchTestApp
//
//  Created by Luke Morse on 1/17/20.
//  Copyright © 2020 Luke Morse. All rights reserved.
//

import UIKit

class RetrieveItemsViewController: UIViewController {
    private var items = [Item]()
    var indicator = UIActivityIndicatorView()
    
    private func getItems() {
        //Show loading animation
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = .white
        
        if let url = URL(string: Constants.apiURL) {
            var request = URLRequest(url: url)
            request.setValue(Constants.secretKey, forHTTPHeaderField: Constants.secretKeyName);
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    self.handleClientError(error: error)
                    return
                }
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        guard let jsonArray = jsonResponse as? [[String: Any]] else {
                            return
                        }
                        //Convert json to Item model and add to "items"
                        for dic in jsonArray {
                            if let thisItem = Item(dic) {
                                self.items.append(thisItem)
                            }
                        }
                        //Sort Items by listId, then name
                        self.items = self.items.sorted(by: {
                            if $0.listId != $1.listId {
                                return $0.listId < $1.listId
                            } else {
                                let nameOne = $0.name.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                                    let nameTwo = $0.name.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                                    return nameOne < nameTwo
                            }
                        })
                        //Stop loading animation and Segue to ItemTableViewController after data is downloaded
                        DispatchQueue.main.async {
                            self.indicator.stopAnimating()
                            self.indicator.hidesWhenStopped = true
                            self.performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
                        }
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                }
            }
            task.resume()
        }
    }
    
    

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func handleClientError(error: Error) {
        //handle error
        print(error.localizedDescription)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            let itemTableVC = segue.destination as! ItemTableViewController
            itemTableVC.items = items;
        }
    }
    
    @IBAction func retrieveDatabuttonTapped(_ sender: Any) {
        getItems()
    }
    

}

