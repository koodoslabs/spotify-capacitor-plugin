import Foundation
import UIKit
import SpotifyiOS
import Capacitor

@objc public class spotifyCapPlugin: NSObject, SPTSessionManagerDelegate, SPTAppRemoteDelegate {
    private var sessionManager: SPTSessionManager?
    private var appRemote: SPTAppRemote?
    private var accessToken: String? = nil
    private var authCall: CAPPluginCall? = nil
    private var authTimer: Timer?
    
    // SPTSessionManagerDelegate functions
    public func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        NSLog("didInitiate...")
        let accessToken = session.accessToken
        NSLog("The accessToken: \(accessToken)")
        if authCall != nil {
            authCall?.resolve([
                "accessToken": accessToken,
                "refreshToken": session.refreshToken,
                "scope": session.scope
            ])
            authCall = nil
            authTimer = nil
        }
    }
    
    public func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        NSLog("didFailWithError...\(error)")
        if authCall != nil {
            authCall?.reject(error.localizedDescription)
            authCall = nil
            authTimer = nil
        }
    }
    
    // SPTAppRemoteDelegate functions
    public func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        NSLog("appRemoteDidEstablishConnection...")
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        NSLog("didDisconnectWithError...")
    }
    
    public func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        NSLog("didDisconnectWithError...")
    }
    
    func setAccessToken(from url: URL?) {
        NSLog("init...")
        if url == nil {
            NSLog("No URL passed...")
            return
        }
        
        NSLog("Getting authorizationParameters...")
        let parameters = appRemote?.authorizationParameters(from: url!)
        NSLog("Getting authorizationParameters...END...")
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            NSLog("The accessToken: \(accessToken)")
            appRemote?.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            NSLog("The accessToken error: \(errorDescription)")
            print(errorDescription)
        } else {
            NSLog("The accessToken, no success...")
        }
    }
    
    @objc public func isInstalled() -> Bool {
        let spotifyUrl = URL(string: "spotify:")
        let installed = UIApplication.shared.canOpenURL(spotifyUrl!)
        
        return installed
    }
    
    func killTimer() {
        if authTimer != nil {
            authTimer?.invalidate()
            authTimer = nil
        }
    }
    
    @objc func userAuth(initParams: InitParams, _ call: CAPPluginCall) {
        NSLog("userAuth...")
        killTimer()
        authCall = call
        
        lazy var configuration = SPTConfiguration(
          clientID: initParams.spotifyClientID,
          redirectURL: initParams.spotifyRedirectURL
        )

        configuration.tokenSwapURL = initParams.tokenSwapURL
        configuration.tokenRefreshURL = initParams.tokenRefreshURL
        
        sessionManager = SPTSessionManager(configuration: configuration, delegate: self)
        let scope: SPTScope = [.userFollowRead, .appRemoteControl]
        
        lazy var appRemote: SPTAppRemote = {
            let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
            appRemote.connectionParameters.accessToken = self.accessToken
            appRemote.delegate = self
            return appRemote
        }()

//        NSLog("starting auth timer...")
//        DispatchQueue.main.async {
//            self.authTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
//                // This block of code will execute every second
//                NSLog("Auth timer fired...\(self.authCall != nil)")
//                self.authCall?.reject("Timed out")
////                self.authCall?.resolve([
////                    "accessToken": "dummyAccessToken",
////                    "refreshToken": "dummyAccessToken",
////                    "scope": "dummyScope"
////                ])
//            }
//        }
        
        NSLog("initiateSession...")
        if #available(iOS 11, *) {
            DispatchQueue.main.async {
                self.sessionManager?.initiateSession(with: scope, options: .default)
            }
        }
    }
}
