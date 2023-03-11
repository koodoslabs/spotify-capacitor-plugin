# spotify-capacitor-plugin

Capacitor plugin to handle authentication for Spotify.

## Install

```bash
npm install spotify-capacitor-plugin
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
    <string>com.shelf.app</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>shelf</string>
    </array>
  </dict>
</array>
```
3. Insert the below line to AppDelegate.swift's delegate:

   ```
   import SpotifyCapacitorPlugin
   ...

   func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {

        ...
        spotifyCapPluginPlugin.shared?.handleOpenUrl(url: url, application: app, options: options)
        ...

   }
    
   ```
4. Add the SpotifyiOS framework 'Package Dependency' to the project App and Pods:
   '''
   URL: https://github.com/spotify/ios-sdk
   Exact version: 1.2.3
   '''

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


### Enums


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
