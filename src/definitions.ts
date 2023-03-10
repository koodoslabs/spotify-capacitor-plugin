export interface spotifyCapPluginPlugin {
  isInstalled(): Promise<boolean>;
  userAuth(options: {value: AuthParams}): Promise<SpotifyAuthSchema>;
}

export interface SpotifyAuthSchema {
  accessToken:string
  refreshToken: string
  scope: string
}

export interface AuthParams {
  spotifyClientID: string,
  spotifyRedirectURL: string,
  tokenSwapURL: string,
	tokenRefreshURL: string
}