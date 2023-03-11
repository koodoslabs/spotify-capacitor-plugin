import { WebPlugin } from '@capacitor/core';

import type { spotifyCapPluginPlugin, AuthParams, SpotifyAuthSchema } from './definitions';

export class spotifyCapPluginWeb extends WebPlugin implements spotifyCapPluginPlugin {
  async isInstalled(): Promise<boolean> {
    console.log('isInstalled...');
    return true;
  }

  // @ts-ignore
  async userAuth(options: {value: AuthParams}): Promise<SpotifyAuthSchema> {
    console.log('userAuth...');
    return {
      accessToken: "",
      refreshToken: "",
      scope: []
    };
  }
}
