
import Foundation

enum DummyAPI: URLRequestConvertible {
    case addUser(AddUserDTO)
    case login(LoginDTO)
    case products
    case searchProduct(_ query: String)
    case categories
    case getCategoryProducts(_ category: String)
    
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
        case .searchProduct:
            "/products/search"
        case .categories:
            "products/category-list"
        case .getCategoryProducts(let category):
            "products/category/\(category)"
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
        case .searchProduct:
            .get
        case .categories:
            .get
        case .getCategoryProducts:
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
        case .products, .categories, .getCategoryProducts:
            nil
        case .searchProduct(let query):
            ["q": query]
        }
    }
}
