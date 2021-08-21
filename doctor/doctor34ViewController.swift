// 光田 胸腔外科 禚靖 name,experience
import UIKit
import Alamofire
import Kanna

struct  data_struct34{
    var d_name:String = ""
    var d_experience:String = ""
    var d_skill:String = ""
    var d_license:String = ""
}
class doctor34ViewController: UIViewController {

    @IBOutlet weak var tableview_doctor: UITableView!
    var doctor34_array:[data_struct34] = Array()
    var check:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load_data34()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension doctor34ViewController{
    func load_data34() {

        Alamofire.request("http://www.ktgh.com.tw/HRE_VSDPT_Look.asp?CatID=120&ModuleType=Y&NewsID=21").responseString { response in
            if let html = response.result.value{
                self.parsehtml34(html)
            }
        }
    }
    func parsehtml34(_ html1:String)  {
        var gg:NSString = " "
        var  doc = try? Kanna.HTML(html: html1, encoding: String.Encoding.utf8)
        var s = data_struct34()
        for i in 1...1{
            for rate1 in doc!.xpath("//*[@id=\"Sizebox\"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[\(i)]/tbody/tr/td[1]/font/strong/text()"){
                //*[@id="Sizebox"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[1]/tbody/tr/td[1]/font/strong/text()
                
                gg = rate1.text! as NSString
                s.d_name = gg as String
            }
            for j in 1...1{
                for rate in doc!.xpath("//*[@id=\"Sizebox\"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[\(i)]/tbody/tr/td[1]/ul/text()[\(j)]"){

                    //*[@id="Sizebox"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[1]/tbody/tr/td[1]/ul/text()[1]

                    gg = rate.text! as NSString
                    s.d_experience = gg.replacingOccurrences(of: " ", with: "")
                    
                }
            }
            
            doctor34_array.append(s)

            for k in 32...32{
                for rate2 in doc!.xpath("//*[@id=\"Sizebox\"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[\(i)]/tbody/tr/td[1]/ul/text()[\(k)]"){

                    //*[@id="Sizebox"]/table/tbody/tr[1]/td/table/tbody/tr[3]/td/table/tbody/tr/td/table[1]/tbody/tr/td[1]/ul/text()[32]
                    gg = rate.text! as NSString
                    s.d_skill = gg.replacingOccurrences(of: " ", with: "")
                    
                }
            }
            
            doctor34_array.append(s)
            
        }
        tableview_doctor.reloadData()

    }
    
}

extension doctor34ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  doctor34_array.count > 0 {
            return doctor34_array.count
        }else{
               return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell1", for: indexPath) as! doctorTableViewCell

        cell.lab_name.adjustsFontSizeToFitWidth = true
        
        cell.name.text = "\(doctor1_array[indexPath.row].d_name)"
        cell.exper.text = "\(doctor1_array[indexPath.row].d_experience)"
        cell.skill.text = "\(doctor1_array[indexPath.row].d_skill)"
        cell.licen.text = "\(doctor1_array[indexPath.row].d_license)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell1") as! doctorTableViewCell
        cell.lab_name.text = "名字"
        cell.lab_experience.text = "經歷"
        cell.lab_skill.text = "專長"
        cell.lab_license.text = "證照"
        
        cell.backgroundColor = UIColor.white
                
        cell.lab_name.textColor = UIColor.blue
        cell.lab_experience.textColor = UIColor.gray
        cell.lab_skill.textColor = UIColor.gray
        cell.lab_license.textColor = UIColor.gray
        
                
        cell.lab_name.font = cell.lab_name.font.withSize(20)
        cell.lab_experience.font = cell.lab_experience.font.withSize(20)
        cell.lab_skill.font = cell.lab_skill.font.withSize(20)
        cell.lab_license.font = cell.lab_license.font.withSize(20)
        
        
        headerView.addSubview(cell)
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}


