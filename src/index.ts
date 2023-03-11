import { registerPlugin } from '@capacitor/core';

import type { spotifyCapPluginPlugin } from './definitions';

const spotifyCapPlugin = registerPlugin<spotifyCapPluginPlugin>('spotifyCapPlugin', {
  web: () => import('./web').then(m => new m.spotifyCapPluginWeb()),
});

export * from './definitions';
export { spotifyCapPlugin };
