import Foundation
import Combine

protocol VidatecServiceType {
    func getRooms() -> AnyPublisher<[Room], VidatecService.Error>
    func getPeoples() -> AnyPublisher<[People], VidatecService.Error>
}

final public class VidatecService {
    
    // MARK: - Properties
    /// Session
    fileprivate let session: URLSession
    
    /// A shared JSON decoder to use in calls.
    private let decoder = JSONDecoder()
    
    /// Session Queue
    private let apiQueue = DispatchQueue(label: "VidatecService", qos: .default, attributes: .concurrent)
    private static let baseHost = "5cc736f4ae1431001472e333.mockapi.io/api/v1"
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /// MARK: Network Errors.
    public enum Error: LocalizedError, Identifiable {
        public var id: String { localizedDescription }
        
        case unknownNetwork
        case networkResponse(NSError)
        case addressUnreachable(URL)
        case invalidResponse
        case decoding
        
        public var errorDescription: String? {
            switch self {
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
            case .invalidResponse: return "The server responded with garbage."
            case .decoding: return "Some decoding error occured"
            case .networkResponse(let error): return error.localizedDescription
            case .unknownNetwork: return "Some unknown network error occured"
            }
        }
    }
    
    /// MARK: Network endpoints.
    private enum EndPoint {
        
        case getRooms
        case getPeoples
        
        var url: URL {
            switch self {
            case .getRooms:
                return getRoomsComponent.url!
            case .getPeoples:
                return getPeopleComponent.url!
            }
        }
        
        private var getRoomsComponent: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = VidatecService.baseHost
            components.path = "/rooms"
            return components
        }
        
        private var getPeopleComponent: URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = VidatecService.baseHost
            components.path = "/people"
            return components
        }
        
    }
}

extension VidatecService: VidatecServiceType {
    
    private func executeRequest<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, VidatecService.Error> {
        return session.dataTaskPublisher(for: urlRequest)
            .receive(on: apiQueue)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<399 ~= httpResponse.statusCode {
                    return data
                }
                else if let httpResponse = httpResponse {
                    let nserror = NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any])
                    throw VidatecService.Error.networkResponse(nserror)
                }     else {
                    throw VidatecService.Error.unknownNetwork
                }
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return VidatecService.Error.addressUnreachable(urlRequest.url!)
                case is DecodingError:
                    return VidatecService.Error.decoding
                default:
                    if let error = error as? VidatecService.Error {
                        return error
                    }
                    return VidatecService.Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func executeRequest<T: Decodable>(url: URL) -> AnyPublisher<T, VidatecService.Error> {
        return session.dataTaskPublisher(for: url)
            .receive(on: apiQueue)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
                if let httpResponse = httpResponse, 200..<399 ~= httpResponse.statusCode {
                    return data
                }
                else if let httpResponse = httpResponse {
                    let nserror = NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any])
                    throw VidatecService.Error.networkResponse(nserror)
                }     else {
                    throw VidatecService.Error.unknownNetwork
                }
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(url)
                case is DecodingError:
                    return Error.decoding
                default:
                    return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getRooms() -> AnyPublisher<[Room], VidatecService.Error> {
        executeRequest(url: VidatecService.EndPoint.getRooms.url)
    }
    
    func getPeoples() -> AnyPublisher<[People], VidatecService.Error> {
        executeRequest(url: VidatecService.EndPoint.getPeoples.url)
    }
}

extension Publisher {
    func unwrap<T>() -> Publishers.CompactMap<Self, T> where Output == Optional<T> {
        compactMap { $0 }
    }
}

fileprivate extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
