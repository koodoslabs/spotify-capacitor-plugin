export interface spotifyCapPluginPlugin {
  isInstalled(): Promise<boolean>;
  userAuth(options: {value: AuthParams}): Promise<SpotifyAuthSchema>;
}

export interface SpotifyAuthSchema {
  accessToken:string
  refreshToken: string
  scope: Scopes[]
}

export interface AuthParams {
  spotifyClientID: string,
  spotifyRedirectURL: string,
  tokenSwapURL: string,
	tokenRefreshURL: string
}

export enum Scopes {
  playlistReadPrivate,
  playlistReadCollaborative,
  playlistModifyPublic,
  playlistModifyPrivate,
  userFollowRead,
  userFollowModify,
  userLibraryRead,
  userLibraryModify,
  userReadBirthDate,
  userReadEmail,
  userReadPrivate,
  userTopRead,
  ugcImageUpload,
  streaming,
  appRemoteControl,
  userReadPlaybackState,
  userModifyPlaybackState,
  userReadCurrentlyPlaying,
  userReadRecentlyPlayed,
}




["playlistReadPrivate",
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