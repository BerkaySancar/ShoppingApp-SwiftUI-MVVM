
import Foundation

enum DummyAPI: URLRequestConvertible {
    case addUser(AddUserDTO)
    case login(LoginRequestDTO)
    case authUser(_ token: String)
    case refreshToken(RefreshTokenRequestDTO)
    case products(_ limit: Int)
    case searchProduct(_ query: String)
    case categories
    case getCategoryProducts(_ category: String)
    case getProduct(_ id: Int)
    
    var baseURL: URL {
        .init(string: "https://dummyjson.com")!
    }
    
    var path: String {
        switch self {
        case .addUser:
            "users/add"
        case .login:
            "auth/login"
        case .authUser:
            "auth/me"
        case .refreshToken:
            "auth/refresh"
        case .products:
            "products"
        case .searchProduct:
            "/products/search"
        case .categories:
            "products/category-list"
        case .getCategoryProducts(let category):
            "products/category/\(category)"
        case .getProduct(let id):
            "products/\(id)"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .addUser:
            .post
        case .login:
            .post
        case .authUser:
            .get
        case .refreshToken:
            .post
        case .products:
            .get
        case .searchProduct:
            .get
        case .categories:
            .get
        case .getCategoryProducts:
            .get
        case .getProduct:
            .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .refreshToken:
            ["Content-Type": "application/json"]
        case .authUser(let token):
            ["Authorization": "Bearer \(token)"]
        case .categories, .products, .searchProduct, .getCategoryProducts, .addUser, .getProduct:
            nil
            
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .addUser(let userData):
            userData.convertToDictionary()
        case .login(let loginData):
            loginData.convertToDictionary()
        case .refreshToken(let tokenData):
            tokenData.convertToDictionary()
        case .authUser:
            nil
        case .products(let limit):
            ["limit": limit]
        case .categories, .getCategoryProducts:
            nil
        case .searchProduct(let query):
            ["q": query]
        case .getProduct: nil
        }
    }
}
