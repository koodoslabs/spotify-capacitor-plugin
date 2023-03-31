'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

exports.Scopes = void 0;
(function (Scopes) {
    Scopes[Scopes["playlistReadPrivate"] = 0] = "playlistReadPrivate";
    Scopes[Scopes["playlistReadCollaborative"] = 1] = "playlistReadCollaborative";
    Scopes[Scopes["playlistModifyPublic"] = 2] = "playlistModifyPublic";
    Scopes[Scopes["playlistModifyPrivate"] = 3] = "playlistModifyPrivate";
    Scopes[Scopes["userFollowRead"] = 4] = "userFollowRead";
    Scopes[Scopes["userFollowModify"] = 5] = "userFollowModify";
    Scopes[Scopes["userLibraryRead"] = 6] = "userLibraryRead";
    Scopes[Scopes["userLibraryModify"] = 7] = "userLibraryModify";
    Scopes[Scopes["userReadBirthDate"] = 8] = "userReadBirthDate";
    Scopes[Scopes["userReadEmail"] = 9] = "userReadEmail";
    Scopes[Scopes["userReadPrivate"] = 10] = "userReadPrivate";
    Scopes[Scopes["userTopRead"] = 11] = "userTopRead";
    Scopes[Scopes["ugcImageUpload"] = 12] = "ugcImageUpload";
    Scopes[Scopes["streaming"] = 13] = "streaming";
    Scopes[Scopes["appRemoteControl"] = 14] = "appRemoteControl";
    Scopes[Scopes["userReadPlaybackState"] = 15] = "userReadPlaybackState";
    Scopes[Scopes["userModifyPlaybackState"] = 16] = "userModifyPlaybackState";
    Scopes[Scopes["userReadCurrentlyPlaying"] = 17] = "userReadCurrentlyPlaying";
    Scopes[Scopes["userReadRecentlyPlayed"] = 18] = "userReadRecentlyPlayed";
})(exports.Scopes || (exports.Scopes = {}));

const spotifyCapPlugin = core.registerPlugin('spotifyCapPlugin', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.spotifyCapPluginWeb()),
});

class spotifyCapPluginWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    spotifyCapPluginWeb: spotifyCapPluginWeb
});

exports.spotifyCapPlugin = spotifyCapPlugin;
//# sourceMappingURL=plugin.cjs.js.map
