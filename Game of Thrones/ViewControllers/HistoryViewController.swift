//
//  HistoryViewController.swift
//  Game of Thrones
//
//  Created by Macho Man on 7/3/18.
//  Copyright © 2018 siddharth. All rights reserved.
//

import UIKit
import CoreData

var MyIndex : Int = 0

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
@IBAction func DeleteHistory(_ sender: Any) {
Delete()
Alert(Title: "Done", Message: "History Deleted")
}
    
var Game = [NSManagedObject]()

    
@IBOutlet weak var TableView1: UITableView!
@IBOutlet weak var SearchBar: UISearchBar!
    
var SearchStatus = false
var FilteredSearch = [String]()
var SearchField = UITextField()

//Function to create Container
func GetContex()-> NSManagedObjectContext
{
let Delegate = UIApplication.shared.delegate as! AppDelegate
return Delegate.persistentContainer.viewContext
}
        
//Function to Fetch Data
func FetchData()
{
let Context = GetContex()
let FetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")

do
{
Game = try Context.fetch(FetchRequest) as! [NSManagedObject]

}
catch
{
print("Failed to Fetch Data")
}
}
    
// Function to Delete History
func Delete()
{
let Context = GetContex()
for I in 0...Game.count-1
{
Context.delete(Game[I])
}
do
{
try Context.save()
}
catch let error as NSError
{
print("Failed to Delete History")
}
let FetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
do
{
Game = try Context.fetch(FetchRequest) as! [Game]
}
catch let error as NSError
{
print("Successfully Fetched Data")
}
TableView1.reloadData()
}

// Function for TableView
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
if SearchStatus {
return FilteredSearch.count
}
if Game.count == 0
{
TableView1.isHidden = true
}
else
{
TableView1.isHidden = false
}
return Game.count
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! Custom1TableViewCell
if SearchStatus{
Cell.Label.text = FilteredSearch[indexPath.row]
for I in 0...Names.count-1
{
if ((Game[I].value(forKey: "name") as! String) == FilteredSearch[indexPath.row])
{
let Photo = Game[I].value(forKeyPath: "image") as! NSData
Cell.ImageView.image = UIImage(data: Photo as Data)
}
}
}
else
{
Cell.Label.text = (Game[indexPath.row].value(forKeyPath: "name") as! String)
let Photo = Game[indexPath.row].value(forKeyPath: "image") as! NSData
Cell.ImageView.image = UIImage(data: Photo as Data)
}


    
    

return Cell
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
return 120.0
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
if SearchStatus{
SearchField.text = FilteredSearch[indexPath.row]
for I in 0...Names.count-1
{
if ((Game[I].value(forKey: "name") as! String) == FilteredSearch[indexPath.row])
{
MyIndex = I
}
}
performSegue(withIdentifier: "Segue1", sender: self)
}
else
{
SearchField.text = (Game[indexPath.row].value(forKey: "name") as! String)
MyIndex = indexPath.row
performSegue(withIdentifier: "Segue1", sender: self)
}
}
    
// Function for SearchBar
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
self.TableView1.reloadData()
}
else{
FilteredSearch = Names.filter({ (text) -> Bool in
let Temp : NSString = text as NSString
let Range = Temp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
return Range.location != NSNotFound
}) as [String] as [String]
if(FilteredSearch.count == 0)
{
SearchStatus = false
}
else
{
SearchStatus = true
}
self.TableView1.reloadData()
}
}
    
// Function to Produce Alert Box
func Alert( Title: String, Message: String)
{
let Alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
}))
self.present(Alert,animated: true, completion: nil)
}
    

override func viewWillAppear(_ animated: Bool) {
FetchData()
}


override func viewDidLoad() {
// Connecting the TableView to the Delegate and the Datasource
TableView1.delegate = self
TableView1.dataSource = self
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
