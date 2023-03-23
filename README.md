# spotify-capacitor-plugin

Capacitor plugin to handle authentication for Spotify.

!!! WARNING: scopes are currently hardcoded !!!

## Install
Not on npm yet. Install from git repo:
```bash
npm install git+https://github.com/koodoslabs/spotify-capacitor-plugin.git
npx cap sync
```

## Prerequisites

Add these keys to Info.plist:
1. LSApplicationQueriesSchemes
```
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>spotify</string>
	</array>
```
2. Make change in CFBundleURLTypes according to your app needs. In our case:
```
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLName</key>
    <string>YOUR BUNDLE ID (com.app.hello)</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>YOUR QUERY SCHEME</string>
    </array>
  </dict>
</array>
```
3. Add the SpotifyiOS framework 'Package Dependency' to the project App and Pods. For Pods, make sure to select `SpotifyCapPlugin`
   '''
   URL: https://github.com/spotify/ios-sdk
   Exact version: 1.2.3
   '''
   ![Screenshot.png](https://user-images.githubusercontent.com/44687983/227304965-30dea88c-a43a-4ec7-9780-261561a448cc.png)
4. `npx cap sync` to sync the changes.
5. Insert the below line to AppDelegate.swift's delegate:
   ```
   import SpotifyCapacitorPlugin
   ...

   func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        ...
        spotifyCapPluginPlugin.shared?.handleOpenUrl(url: url, application: app, options: options)
        ...
   }
   ```
6. Build the app as usual.

## Sample Usage
```javascript
import {spotifyCapPlugin} from "spotify-capacitor-plugin";

let isInstalled = await spotifyCapPlugin.isInstalled()
console.log('IsInstalled: ' + JSON.stringify(isInstalled))

spotifyCapPlugin.userAuth({value: {
      spotifyClientID: "YOUR CLIENT ID",
      spotifyRedirectURL: "YOUR SPOTIFY REDIRECT URL",
      tokenSwapURL: "YOUR TOKEN SWAP URL",
      tokenRefreshURL: "YOUR TOKEN REFRESH URL",
   }}).then((response)=>{
     console.log('Spotify Auth Response: ' + JSON.stringify(response))
   }).catch((err) => {
      // can be ignored
      console.info('Spotify Auth Error: ' + JSON.stringify(err))
   })
```
See resources linked below on spotify SDK spec + endpoints.

## API

<docgen-index>

* [`isInstalled()`](#isinstalled)
* [`userAuth(...)`](#userauth)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### isInstalled()

```typescript
isInstalled() => Promise<boolean>
```

**Returns:** <code>Promise&lt;boolean&gt;</code>

--------------------


### userAuth(...)

```typescript
userAuth(options: { value: AuthParams; }) => Promise<SpotifyAuthSchema>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code>{ value: <a href="#authparams">AuthParams</a>; }</code> |

**Returns:** <code>Promise&lt;<a href="#spotifyauthschema">SpotifyAuthSchema</a>&gt;</code>

--------------------


### Interfaces


#### SpotifyAuthSchema

| Prop               | Type                  |
| ------------------ | --------------------- |
| **`accessToken`**  | <code>string</code>   |
| **`refreshToken`** | <code>string</code>   |
| **`scope`**        | <code>Scopes[]</code> |


#### AuthParams

| Prop                     | Type                |
| ------------------------ | ------------------- |
| **`spotifyClientID`**    | <code>string</code> |
| **`spotifyRedirectURL`** | <code>string</code> |
| **`tokenSwapURL`**       | <code>string</code> |
| **`tokenRefreshURL`**    | <code>string</code> |


#### Scopes

| Members                         |
| ------------------------------- |
| **`playlistReadPrivate`**       |
| **`playlistReadCollaborative`** |
| **`playlistModifyPublic`**      |
| **`playlistModifyPrivate`**     |
| **`userFollowRead`**            |
| **`userFollowModify`**          |
| **`userLibraryRead`**           |
| **`userLibraryModify`**         |
| **`userReadBirthDate`**         |
| **`userReadEmail`**             |
| **`userReadPrivate`**           |
| **`userTopRead`**               |
| **`ugcImageUpload`**            |
| **`streaming`**                 |
| **`appRemoteControl`**          |
| **`userReadPlaybackState`**     |
| **`userModifyPlaybackState`**   |
| **`userReadCurrentlyPlaying`**  |
| **`userReadRecentlyPlayed`**    |

</docgen-api>

## Resources
[Spotify Auth Doc ](https://github.com/spotify/ios-sdk/blob/master/docs/auth.md)
[Endpoint Spec](https://developer.spotify.com/documentation/ios/guides/token-swap-and-refresh/)
