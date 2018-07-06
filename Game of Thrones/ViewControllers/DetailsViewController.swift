//
//  DetailsViewController.swift
//  Game of Thrones
//
//  Created by Macho Man on 7/1/18.
//  Copyright © 2018 siddharth. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
var Game = [NSManagedObject]()


@IBOutlet weak var ImageView: UIImageView!
@IBOutlet weak var PageRank: UILabel!
@IBOutlet weak var Name: UILabel!
@IBOutlet weak var Gender: UILabel!
@IBOutlet weak var Culture: UILabel!
@IBOutlet weak var House: UILabel!
@IBOutlet weak var Books: UITextView!
@IBOutlet weak var Titles: UITextView!
var Link = [String]()
var Name1 = [String]()
var PageRank1 = [NSNumber]()
var Gender1 = [Bool]()
var Culture1 = [String]()
var House1 = [String]()
var Books1 = [String]()
var Titles1 = [String]()
var Image1 = [String]()
var View = [UIImage]()
var DATA = [Data]()


// Function to create Container
func GetContext() ->NSManagedObjectContext
{
let Delegate = UIApplication.shared.delegate as! AppDelegate
return Delegate.persistentContainer.viewContext
}

// Function to Save Data
func SaveData()
{
let Context = GetContext()
let Entity = NSEntityDescription.entity(forEntityName: "Game", in: Context)
let NewEntry = NSManagedObject(entity: Entity!, insertInto: Context)
NewEntry.setValue(Name.text, forKey: "name")
NewEntry.setValue(Gender.text, forKey: "gender")
NewEntry.setValue(Culture.text, forKey: "culture")
NewEntry.setValue(House.text, forKey: "house")
NewEntry.setValue(Books.text, forKey: "books")
NewEntry.setValue(Titles.text, forKey: "titles")
NewEntry.setValue(PageRank.text, forKey: "pagerank")
let Image = UIImagePNGRepresentation(ImageView.image!)! as NSData
NewEntry.setValue(Image, forKey: "image")
Names.append(Name.text!)
do
{
try Context.save()
print("$$$$$$$$")
print(NewEntry)
}
catch
{
print("Failed to Save Data")
}
}

    
// Function to Fetch Data
func JSON2(Character : String)
{

let Link = "https://api.got.show/api/characters/"
let NewLink1 = Link + Character
let NewLink2 = NewLink1.replacingOccurrences(of: " ", with: "%20")
let TheURL = URL(string: NewLink2)
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
let Info = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
print(Info)
if let Content = Info["data"] as? NSDictionary
{
//For Name
self.Name1.append(Content["name"] as! String)
//For Gender
self.Gender1.append(Content["male"] as! Bool)
//For House
if let House = Content["house"]
{
self.House1.append(House as! String)
}
else
{
let Default = "No House"
self.House1.append(Default)
}
//For Culture
if let Culture = Content["culture"]
{
self.Culture1.append(Culture as! String)
}
else
{
let Default = "No Culture"
self.Culture1.append(Default)
}
// For Books
if let Books = Content["books"] as? NSArray
{
let Count1 = Books.count
if Count1 == 0
{
let Default = "No Books"
self.Books1.append(Default)
}
else
{
for I in 0...Count1-1
{
self.Books1.append(Books[I] as! String)
}
}
}
//For Titles
if let Titles = Content["titles"] as? NSArray
{
let Count1 = Titles.count
if Count1 == 0
{
let Default = "No Titles"
self.Titles1.append(Default)
}
else
{
for I in 0...Count1-1
{
self.Titles1.append(Titles[I] as! String)
}
}
}
//For Image
if let Image = Content["imageLink"]
{
self.Image1.append(Image as! String)
}
else
{
let Default = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
self.Image1.append(Default)
}
//For PageRank
if let PageRank = Content["pageRank"]
{
self.PageRank1.append(PageRank as! NSNumber)
}
else
{
self.PageRank1.append(404)
}
}
}
catch let error as NSError
{
print(error)
}
};DispatchQueue.main.async {
// To Display Name
self.Name.text = self.Name1[0]
NAME.append(self.Name.text!)
// To Display House
self.House.text = self.House1[0]
HOUSE.append(self.House.text!)
// To Display Culture
self.Culture.text = self.Culture1[0]
CULTURE.append(self.Culture.text!)
// To Display Books
if self.Books1[0] == "No Books"
{
self.Books.text = self.Books1[0]
BOOKS.append(self.Books.text)
}
else
{
var FinalText = " "
let Space = "    "
let Count = self.Books1.count
print(Count)
if(Count > 1)
{
for I in 0...Count-1
{
if I == 0
{
FinalText = FinalText + self.Books1[I]
}
FinalText = FinalText + Space + self.Books1[I]
}
self.Books.text = FinalText
BOOKS.append(self.Books.text)
}
else
{
self.Books.text = self.Books1[0]
BOOKS.append(self.Books.text)
}
}
// To Display Titles
if self.Titles1[0] == "No Titles"
{
self.Titles.text = self.Titles1[0]
TITLES.append(self.Titles.text!)
}
else
{
var FinalText = " "
let Space = "    "
let Count = self.Titles1.count
print(Count)
if(Count > 1)
{
for I in 0...Count-1
{
if I == 0
{
FinalText = FinalText + self.Titles1[I]
}
FinalText = FinalText + Space + self.Titles1[I]
}
self.Titles.text = FinalText
TITLES.append(self.Titles.text!)
}
else
{
self.Titles.text = self.Titles1[0]
TITLES.append(self.Titles.text!)
}
}

// To Display Gender
if(self.Gender1[0] == true)
{
self.Gender.text = "Male"
GENDER.append(self.Gender.text!)
}
else
{
self.Gender.text = "Female"
GENDER.append(self.Gender.text!)
}
//To Display Image
if self.Image1[0] != "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"
{
let Str1 = "https://api.got.show" + self.Image1[0]
let Str = URL(string: Str1)
let Data1 = try? Data(contentsOf: Str!)
self.ImageView.image = UIImage(data: Data1!)
IMAGE.append(self.ImageView.image!)
}
else
{
let Str1 =  self.Image1[0]
let Str = URL(string: Str1)
let Data1 = try? Data(contentsOf: Str!)
self.ImageView.image = UIImage(data: Data1!)
IMAGE.append(self.ImageView.image!)
}
//To Display PageRank
if self.PageRank1[0] == NSNumber(value: 404)
{
self.PageRank.text = "N/A"
PAGERANK.append(self.PageRank.text!)
}
else
{
self.PageRank.text = String(describing: self.PageRank1[0])
PAGERANK.append(self.PageRank.text!)
}
}
}.resume()
}

    
override func viewDidAppear(_ animated: Bool) {
SaveData()
}

override func viewWillAppear(_ animated: Bool) {
JSON2(Character: Link[0])
}


override func viewDidLoad() {    
// Design for UI Outlets
ImageView.layer.cornerRadius = 50.0
ImageView.layer.borderColor = UIColor.white.cgColor
ImageView.layer.borderWidth = 3.0
ImageView.clipsToBounds = false
ImageView.layer.masksToBounds = true
PageRank.layer.cornerRadius = 25.0
PageRank.layer.borderColor = UIColor.black.cgColor
PageRank.clipsToBounds = false
PageRank.layer.masksToBounds = true
PageRank.layer.borderWidth = 2.0
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
