/**
 * @copyright (c) 2016, Philipp Thuerwaechter & Pattrick Hueper
 * @license BSD-3-Clause (see LICENSE in the root directory of this source tree)
 */

function createErrorType(name, init, superErrorClass = Error) {
    function E(message) {
        if (!Error.captureStackTrace){
            this.stack = (new Error()).stack;
        } else {
            Error.captureStackTrace(this, this.constructor);
        }
        this.message = message;
        init && init.apply(this, arguments);

    }
    E.prototype = new superErrorClass();
    E.prototype.name = name;
    E.prototype.constructor = E;
    return E;
}

export var DateTimeException = createErrorType('DateTimeException', messageWithCause);
export var DateTimeParseException = createErrorType('DateTimeParseException', messageForDateTimeParseException);
export var UnsupportedTemporalTypeException = createErrorType('UnsupportedTemporalTypeException', null, DateTimeException);
export var ArithmeticException = createErrorType('ArithmeticException');
export var IllegalArgumentException = createErrorType('IllegalArgumentException');
export var IllegalStateException = createErrorType('IllegalStateException');
export var NullPointerException = createErrorType('NullPointerException');

function messageWithCause(message, cause = null) {
    let msg = message || this.name;
    if (cause !== null && cause instanceof Error) {
        msg += '\n-------\nCaused by: ' + cause.stack + '\n-------\n';
    }
    this.message = msg;
}

function messageForDateTimeParseException(message, text = '', index = 0, cause = null) {
    let msg = message || this.name;
    msg += ': ' + text + ', at index: ' + index;
    if (cause !== null && cause instanceof Error) {
        msg += '\n-------\nCaused by: ' + cause.stack + '\n-------\n';
    }
    this.message = msg;
    this.parsedString = () => {
        return text;
    };
    this.errorIndex = () => {
        return index;
    };
}
