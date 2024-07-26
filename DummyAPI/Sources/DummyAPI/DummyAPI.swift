
import Foundation

enum DummyAPI: URLRequestConvertible {
    case addUser(AddUserDTO)
    case login(LoginDTO)
    case products
    
    var baseURL: URL {
        .init(string: "https://dummyjson.com")!
    }
    
    var path: String {
        switch self {
        case .addUser:
            "users/add"
        case .login:
            "auth/login"
        case .products:
            "products"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .addUser:
            .post
        case .login:
            .post
        case .products:
            .get
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .addUser(let userData):
            userData.convertToDictionary()
        case .login(let loginData):
            loginData.convertToDictionary()
        case .products:
            nil
        }
    }
}
