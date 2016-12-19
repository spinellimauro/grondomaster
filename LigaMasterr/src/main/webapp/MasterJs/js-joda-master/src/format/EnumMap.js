/*
 * @copyright (c) 2016, Philipp Thuerwaechter & Pattrick Hueper
 * @license BSD-3-Clause (see LICENSE in the root directory of this source tree)
 */

export class EnumMap {
    constructor(){
        this._map = {};
    }

    putAll(otherMap){
        for(let key in otherMap._map){
            this._map[key] = otherMap._map[key];
        }
        return this;
    }

    containsKey(key){
        return this._map.hasOwnProperty(key.name());
    }

    get(key) {
        return this._map[key.name()];
    }

    put(key, val) {
        return this.set(key, val);
    }

    set(key, val) {
        this._map[key.name()] = val;
        return this;
    }

    retainAll(keyList){
        var map = {};
        for(let i=0; i<keyList.length; i++){
            let key = keyList[i].name();
            map[key] = this._map[key];
        }
        this._map = map;
        return this;
    }

    /**
     * due to the bad performance of delete we just set the key entry to undefined.
     *
     * this might lead to issues with "null" entries. Calling clear in the end might solve the issue
     * @param key
     * @returns {*}
     */
    remove(key){
        var keyName = key.name();
        var val = this._map[keyName];
        this._map[keyName] = undefined;
        return val;
    }

    keySet(){
        return this._map;
    }

    clear(){
        this._map = {};
    }
}
