/**
 * @copyright (c) 2016, Philipp Thuerwaechter & Pattrick Hueper
 * @copyright (c) 2007-present, Stephen Colebourne & Michael Nascimento Santos
 * @license BSD-3-Clause (see LICENSE in the root directory of this source tree)
 */

import {DateTimeException} from '../../../src/errors';
import {ChronoUnit} from '../../../src/temporal/ChronoUnit';
import {ValueRange} from '../../../src/temporal/ValueRange';
import {TemporalField} from '../../../src/temporal/TemporalField';

/**
 * Mock DateTimeField that returns null.
 */
export class MockFieldNoValue extends TemporalField {
    toString() {
        return null;
    }

    getBaseUnit() {
        return ChronoUnit.WEEKS;
    }

    getRangeUnit() {
        return ChronoUnit.MONTHS;
    }

    range() {
        return ValueRange.of(1, 20);
    }

    isDateBased() {
        return true;
    }

    isTimeBased() {
        return false;
    }

    isSupportedBy() {
        return true;
    }

    rangeRefinedBy() {
        return ValueRange.of(1, 20);
    }

    getFrom() {
        throw new DateTimeException('Mock');
    }

    adjustInto() {
        throw new DateTimeException('Mock');
    }

    getDisplayName() {
        return 'Mock';
    }

}

MockFieldNoValue.INSTANCE = new MockFieldNoValue();