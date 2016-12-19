/*
 * @copyright (c) 2016, Philipp Thuerwaechter & Pattrick Hueper
 * @copyright (c) 2007-present, Stephen Colebourne & Michael Nascimento Santos
 * @license BSD-3-Clause (see LICENSE in the root directory of this source tree)
 */

import {abstractMethodFail} from './assert';
import {StringUtil} from './StringUtil';

import {Instant} from './Instant';

export class ZoneId {
    //-----------------------------------------------------------------------
    /**
     * Gets the time-zone rules for this ID allowing calculations to be performed.
     * <p>
     * The rules provide the functionality associated with a time-zone,
     * such as finding the offset for a given instant or local date-time.
     * <p>
     * A time-zone can be invalid if it is deserialized in a Java Runtime which
     * does not have the same rules loaded as the Java Runtime that stored it.
     * In this case, calling this method will throw a {@code ZoneRulesException}.
     * <p>
     * The rules are supplied by {@link ZoneRulesProvider}. An advanced provider may
     * support dynamic updates to the rules without restarting the Java Runtime.
     * If so, then the result of this method may change over time.
     * Each individual call will be still remain thread-safe.
     * <p>
     * {@link ZoneOffset} will always return a set of rules where the offset never changes.
     *
     * @return {!ZoneRules} the rules, not null
     * @throws ZoneRulesException if no rules are available for this ID
     */
    rules(){
        abstractMethodFail('ZoneId.rules');
    }

    /**
      * Normalizes the time-zone ID, returning a {@code ZoneOffset} where possible.
      * <p>
      * The returns a normalized {@code ZoneId} that can be used in place of this ID.
      * The result will have {@code ZoneRules} equivalent to those returned by this object,
      * however the ID returned by {@code getId()} may be different.
      * <p>
      * The normalization checks if the rules of this {@code ZoneId} have a fixed offset.
      * If they do, then the {@code ZoneOffset} equal to that offset is returned.
      * Otherwise {@code this} is returned.
      *
      * @return {ZoneId} the time-zone unique ID, not null
      */
    normalized() {
        var rules = this.rules();
        if (rules.isFixedOffset()) {
            return rules.offset(Instant.EPOCH);
        }
        //try {
        //} catch (ZoneRulesException ex) {
        //    // ignore invalid objects
        //}
        return this;
    }

     //-----------------------------------------------------------------------
     /**
      * Checks if this time-zone ID is equal to another time-zone ID.
      * <p>
      * The comparison is based on the ID.
      *
      * @param {*} other  the object to check, null returns false
      * @return {boolean} true if this is equal to the other time-zone ID
      */
     equals(other) {
         if (this === other) {
             return true;
         }
         if (other instanceof ZoneId) {
             return this.id() === other.id();
         }
         return false;
     }

     /**
      * A hash code for this time-zone ID.
      *
      * @return {number} a suitable hash code
      */
     hashCode() {
         return StringUtil.hashCode(this.id());
     }

     //-----------------------------------------------------------------------
     /**
      * Outputs this zone as a {@code String}, using the ID.
      *
      * @return {string} a string representation of this time-zone ID, not null
      */
     toString() {
         return this.id();
     }

}
