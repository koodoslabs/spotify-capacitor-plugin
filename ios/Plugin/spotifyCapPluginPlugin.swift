import Foundation
import Capacitor
import MobileCoreServices

@objc(spotifyCapPluginPlugin)
public class spotifyCapPluginPlugin: CAPPlugin {
    public static var shared: spotifyCapPluginPlugin?
    private let implementation = spotifyCapPlugin()
    
    override public func load() {
        NSLog("Capacitor, load()...")
        spotifyCapPluginPlugin.shared = self
    }
    
    public func handleOpenUrl(url: URL, application: UIApplication, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) {
        NSLog("Processing URL \(url) in plugin...")
        implementation.setAccessToken(from: url, application: application, options: options)
    }

    @objc func isInstalled(_ call: CAPPluginCall) {
        call.resolve([
            "value": implementation.isInstalled()
        ])
    }
    
    @objc func userAuth(_ call: CAPPluginCall) {
        if let jsonValue = call.getObject("value"),
           let jsonData = try? JSONSerialization.data(withJSONObject: jsonValue, options: []),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
            let encoder = JSONEncoder()
            do {
                let jsonData = try encoder.encode(jsonObject)
                let decoder = JSONDecoder()
                let initParams = try decoder.decode(InitParams.self, from: jsonData)
                // Use the initParams object here
                implementation.userAuth(initParams: initParams, call)
            } catch {
                print(error.localizedDescription)
                call.reject(error.localizedDescription)
            }
        } else {
            call.reject("Error: JSON object not found")
        }
    }
}
