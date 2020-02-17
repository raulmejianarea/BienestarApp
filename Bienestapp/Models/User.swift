
import Foundation

class User: Codable {
    var id: Int?
    
    var name: String = ""
    
    var email: String = ""
    
    var password: String = ""

    var token: String = ""
    
    init(email:String, password:String) {
           
           self.email = email
           self.password = password
        /*   self.userName=userName
           self.token = nil
           self.location=nil
           self.picture = nil
           self.id = nil
           */
       }
    
}

class RegisterUserResponse: Codable{
    var error_code : Int?
     var error_msg : String?
    
    
}
    
   
