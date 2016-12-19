/*
 * @copyright (c) 2016, Philipp Thuerwaechter & Pattrick Hueper
 * @license BSD-3-Clause (see LICENSE in the root directory of this source tree)
 */

import {expect} from 'chai';

import '../_init';

import {LocalDateTime} from '../../src/LocalDateTime';
import {Instant} from '../../src/Instant';
import {ZoneId} from '../../src/ZoneId';
import {ZoneOffset} from '../../src/ZoneOffset';


describe('zone/SystemDefaultZoneRulesTest.js', () => {

    it('should return an offset for an Instant', function () {
        var zone = ZoneId.systemDefault();
        var instant = Instant.parse('2016-03-16T00:00:00Z');
        var offset = zone.rules().offset(instant);

        expect(offset).to.be.instanceOf(ZoneOffset);
        expect(offset.totalSeconds()).to.be.a('number');
        expect(offset.toString()).to.be.a('string');
        expect(offset.id()).to.be.a('string');
    });

    it('should return an offset for a LocalDateTime', function () {
        var zone = ZoneId.systemDefault();
        var ldt = LocalDateTime.parse('2016-10-30T00:00:00');
        var offset = zone.rules().offset(ldt);

        expect(offset).to.be.instanceOf(ZoneOffset);
        expect(offset.totalSeconds()).to.be.a('number');
        expect(offset.toString()).to.be.a('string');
    });

    it('ZoneIdSystemDefault.toString', function () {
        var zone = ZoneId.systemDefault();
        expect(zone.toString()).to.be.a('string');
        expect(zone.toString()).to.contain('SYSTEM');
    });


    it('manual daylight savings scan', function () {
        var logResult = '';

        // CET transition
        scan(LocalDateTime.parse('2016-03-27T00:00:00'));
        scan(LocalDateTime.parse('2016-10-30T00:00:00'));

        // EDT transition
        scan(LocalDateTime.parse('2016-03-13T00:00:00'));
        scan(LocalDateTime.parse('2016-11-06T00:00:00'));

        // console.log(logResult);

        function scan(ldt) {
            log('------------------------');
            sample(ldt);
            sample(ldt.plusHours(1).plusMinutes(59));
            sample(ldt.plusHours(2));
            sample(ldt.plusHours(2).plusMinutes(1));
            sample(ldt.plusHours(2).plusMinutes(59));
            sample(ldt.plusHours(3));
            sample(ldt.plusHours(3).plusMinutes(1));
            log('------------------------');
        }

        function sample(ldt){
            var zone = ZoneId.systemDefault();
            log(ldt.toString() + '\t' + zone.rules().offset(ldt).toString());

        }

        function log(str){
            // console.log(str);
            logResult += str + '\n';
        }

    });

});