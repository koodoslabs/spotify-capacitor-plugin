export interface spotifyCapPluginPlugin {
    isInstalled(): Promise<boolean>;
    userAuth(options: {
        value: AuthParams;
    }): Promise<SpotifyAuthSchema>;
}
export interface SpotifyAuthSchema {
    accessToken: string;
    refreshToken: string;
    scope: Scopes[];
}
export interface AuthParams {
    spotifyClientID: string;
    spotifyRedirectURL: string;
    tokenSwapURL: string;
    tokenRefreshURL: string;
}
export declare enum Scopes {
    playlistReadPrivate = 0,
    playlistReadCollaborative = 1,
    playlistModifyPublic = 2,
    playlistModifyPrivate = 3,
    userFollowRead = 4,
    userFollowModify = 5,
    userLibraryRead = 6,
    userLibraryModify = 7,
    userReadBirthDate = 8,
    userReadEmail = 9,
    userReadPrivate = 10,
    userTopRead = 11,
    ugcImageUpload = 12,
    streaming = 13,
    appRemoteControl = 14,
    userReadPlaybackState = 15,
    userModifyPlaybackState = 16,
    userReadCurrentlyPlaying = 17,
    userReadRecentlyPlayed = 18
}
