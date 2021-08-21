// 童綜合 家庭醫學科 黃素雲
import UIKit
import Alamofire
import Kanna

struct  data_struct13{
    var d_name:String = ""
    var d_experience:String = ""
    var d_skill:String = ""
    var d_license:String = ""
}
class doctor13ViewController: UIViewController {

    @IBOutlet weak var tableview_doctor: UITableView!
    var doctor13_array:[data_struct13] = Array()
    var check:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load_data13()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension doctor13ViewController{
    func load_data13() {

        Alamofire.request("https://zh-tw.sltung.com.tw/tung/Salu/department.php?d_id=9").responseString { response in
            if let html = response.result.value{
                self.parsehtml13(html)
            }
        }
    }
    func parsehtml13(_ html1:String)  {
        var gg:NSString = " "
        var  doc = try? Kanna.HTML(html: html1, encoding: String.Encoding.utf8)
        var s = data_struct13()
        for i in 3...3{
            for rate1 in doc!.xpath("//*[@id=\"top\"]/div[3]/div/div[1]/div/div[\(i)]/div[2]/table/thead/tr/td"){
                
                gg = rate1.text! as NSString
                s.d_name = gg as String
            }
            for j in 1...3{
                for rate in doc!.xpath("//*[@id=\"top\"]/div[3]/div/div[1]/div/div[\(i)]/div[2]/table/tbody/tr[\(j)]/td[2]"){
                    

                    if (j == 1){

                        gg = rate.text! as NSString
                        s.d_experience = gg.replacingOccurrences(of: " ", with: "")
                    }
                    if (j == 2){
                        gg = rate.text! as NSString
                        s.d_skill = gg as String
                    }
                    if (j == 3){
                        gg = rate.text! as NSString
                        s.d_license = gg.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                    
                }
            }
            doctor13_array.append(s)

        }
        tableview_doctor.reloadData()

    }
    
}

extension doctor13ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  doctor13_array.count > 0 {
            return doctor13_array.count
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

