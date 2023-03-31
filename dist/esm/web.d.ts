import { WebPlugin } from '@capacitor/core';
import type { spotifyCapPluginPlugin, AuthParams, SpotifyAuthSchema } from './definitions';
export declare class spotifyCapPluginWeb extends WebPlugin implements spotifyCapPluginPlugin {
    isInstalled(): Promise<boolean>;
    userAuth(options: {
        value: AuthParams;
    }): Promise<SpotifyAuthSchema>;
}
