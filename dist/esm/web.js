import { WebPlugin } from '@capacitor/core';
export class spotifyCapPluginWeb extends WebPlugin {
    async isInstalled() {
        console.log('isInstalled...');
        return true;
    }
    // @ts-ignore
    async userAuth(options) {
        console.log('userAuth...');
        return {
            accessToken: "",
            refreshToken: "",
            scope: []
        };
    }
}
//# sourceMappingURL=web.js.map