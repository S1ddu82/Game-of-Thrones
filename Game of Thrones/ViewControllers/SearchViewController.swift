//
//  SearchViewController.swift
//  Game of Thrones
//
//  Created by Macho Man on 7/1/18.
//  Copyright © 2018 siddharth. All rights reserved.
//

import UIKit

var NAME = [String]()
var IMAGE = [UIImage]()
var GENDER = [String]()
var CULTURE = [String]()
var PAGERANK = [String]()
var TITLES = [String]()
var HOUSE = [String]()
var BOOKS = [String]()
var Names = [String]()

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
@IBOutlet weak var TableView: UITableView!
@IBOutlet weak var SearchBar: UISearchBar!
var Character = [String]()
var Name = [String]()
var Name2 = [String]()
var Gender = [Bool]()
var PageRank = [Int]()
var Image = [String]()
var Books = [String]()
var SearchStatus = false
var FilteredSearch = [String]()
var SearchField = UITextField()
var ImageView = [UIImage]()

// Functions for TableView
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
if SearchStatus {
return FilteredSearch.count
}
return Character.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
if SearchStatus{
Cell.Label.text = FilteredSearch[indexPath.row]
Cell.ImageView.image = #imageLiteral(resourceName: "GOT")
}
else
{
Cell.Label.text = Character[indexPath.row]
Cell.ImageView.image = #imageLiteral(resourceName: "GOT")
}
return Cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
return 120.0
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
if SearchStatus{
SearchField.text = FilteredSearch[indexPath.row]
let Delimiter = "("
let  Token = SearchField.text?.components(separatedBy: Delimiter)
print(Token![0] as Any)
Name2 = [Token![0]]
performSegue(withIdentifier: "Segue", sender: self)

}
else
{
SearchField.text = Character[indexPath.row]
let Delimiter = "("
let Token = SearchField.text?.components(separatedBy: Delimiter)
print(Token![0] as Any)
Name2 = [Token![0]]
performSegue(withIdentifier: "Segue", sender: self)
}
}
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
if let NAME = segue.destination as? DetailsViewController
{
print("$$$$$$")
print(Name2)
NAME.Link = Name2
    }
}
    
    
    
    
func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
SearchStatus = true
}

func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
SearchStatus = false
searchBar.resignFirstResponder()
}

func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
SearchStatus = false
searchBar.resignFirstResponder()
}

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
SearchStatus = false
searchBar.resignFirstResponder()
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
if searchText.count == 0{
SearchStatus = false
self.TableView.reloadData()
}
else{
FilteredSearch = Character.filter({ (text) -> Bool in
let Temp : NSString = text as NSString
let Range = Temp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
return Range.location != NSNotFound
})
if(FilteredSearch.count == 0)
{
SearchStatus = false
}
else
{
SearchStatus = true
}
self.TableView.reloadData()
}
}
    
    
func JSON1()
{
let Link = "https://api.got.show/api/characters/"
let TheURL = URL(string: Link)
URLSession.shared.dataTask(with: TheURL!) { (data, response, error) in
if error != nil
{
print(error as Any)
}
else
{
print(response as Any)
do
{
let Info = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]

let Count = Info.count
for I in 1...Count-1
{
if let Content = Info[I] as? NSDictionary
{
self.Character.append(Content["name"] as! String)
}
}
}catch let error as NSError
{
print(error)
}
};DispatchQueue.main.async
{
self.TableView.reloadData()
}
}.resume()
}
    

    

override func viewDidLoad() {
JSON1()
TableView.delegate = self
TableView.dataSource = self
SearchBar.delegate = self
SearchBar.returnKeyType = UIReturnKeyType.done
super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
