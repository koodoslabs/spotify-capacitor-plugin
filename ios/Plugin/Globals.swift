import Foundation

@objc class InitParams: NSObject, Codable {
    public var spotifyClientID: String
    public var spotifyRedirectURL: URL
    public var tokenSwapURL: URL
    public var tokenRefreshURL: URL
}
