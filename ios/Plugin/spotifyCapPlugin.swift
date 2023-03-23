import Foundation
import UIKit
import SpotifyiOS
import Capacitor

@objc public class spotifyCapPlugin: NSObject, SPTSessionManagerDelegate, SPTAppRemoteDelegate {
    private var sessionManager: SPTSessionManager?
    private var appRemote: SPTAppRemote?
    private var accessToken: String? = nil
    private var authCall: CAPPluginCall? = nil
    
    // SPTSessionManagerDelegate functions
    public func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        NSLog("didInitiate...")
        let accessToken = session.accessToken
        appRemote?.connectionParameters.accessToken = accessToken
        self.accessToken = accessToken
        
        if authCall != nil {
            authCall?.resolve([
                "accessToken": accessToken,
                "refreshToken": session.refreshToken,
                "scope": getScopes(scopeMask: session.scope.rawValue)
            ])
            authCall = nil
        }
    }
    
    public func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        NSLog("didFailWithError...\(error)")
        if authCall != nil {
            authCall?.reject(error.localizedDescription)
            authCall = nil
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
    
    func setAccessToken(from url: URL?, application: UIApplication, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        NSLog("init...")
        if url == nil {
            NSLog("No URL passed...")
            return
        }
        
        self.sessionManager?.application(application, open: url!, options: options)
    }
    
    @objc public func isInstalled() -> Bool {
        let spotifyUrl = URL(string: "spotify:")
        let installed = UIApplication.shared.canOpenURL(spotifyUrl!)
        
        return installed
    }
    
    @objc func userAuth(initParams: InitParams, _ call: CAPPluginCall) {
        NSLog("userAuth...")
        authCall = call
        
        lazy var configuration = SPTConfiguration(
          clientID: initParams.spotifyClientID,
          redirectURL: initParams.spotifyRedirectURL
        )

        configuration.tokenSwapURL = initParams.tokenSwapURL
        configuration.tokenRefreshURL = initParams.tokenRefreshURL

        sessionManager = SPTSessionManager(configuration: configuration, delegate: self)
        self.sessionManager?.delegate = self
        let scope: SPTScope = [
            .ugcImageUpload,
            .userReadRecentlyPlayed,
            .userTopRead,
            .playlistReadPrivate,
            .playlistReadCollaborative,
            .userLibraryRead,
            .userReadEmail
        ]
        
        let stpDel = self
        
        self.appRemote = {
            let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
            appRemote.connectionParameters.accessToken = self.accessToken
            appRemote.delegate = stpDel
            return appRemote
        }()
        
        NSLog("initiateSession...")
        if #available(iOS 11, *) {
            DispatchQueue.main.async {
                self.sessionManager?.initiateSession(with: scope, options: .default)
            }
        }
    }
    
    func getScopes(scopeMask: UInt) -> [String] {
        let masks = ["playlistReadPrivate",
                     "playlistReadCollaborative",
                     "playlistModifyPublic",
                     "playlistModifyPrivate",
                     "userFollowRead",
                     "userFollowModify",
                     "userLibraryRead",
                     "userLibraryModify",
                     "userReadBirthDate",
                     "userReadEmail",
                     "userReadPrivate",
                     "userTopRead",
                     "ugcImageUpload",
                     "streaming",
                     "appRemoteControl",
                     "userReadPlaybackState",
                     "userModifyPlaybackState",
                     "userReadCurrentlyPlaying",
                     "userReadRecentlyPlayed"]
        
        var result: [String] = []
        for (index, mask) in masks.enumerated() {
            if scopeMask & (1 << UInt64(index)) != 0 {
                result.append(mask)
            }
        }
        
        return result
    }
}
