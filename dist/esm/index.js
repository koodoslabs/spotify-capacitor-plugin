import { registerPlugin } from '@capacitor/core';
const spotifyCapPlugin = registerPlugin('spotifyCapPlugin', {
    web: () => import('./web').then(m => new m.spotifyCapPluginWeb()),
});
export * from './definitions';
export { spotifyCapPlugin };
//# sourceMappingURL=index.js.map