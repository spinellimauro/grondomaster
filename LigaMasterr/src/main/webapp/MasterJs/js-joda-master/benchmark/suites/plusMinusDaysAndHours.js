if(typeof require === 'function') { require('../node-init'); }

(function() {
    var dateStr = '2015-12-24T12:00';
    var dt = JSJoda.LocalDateTime.parse(dateStr);
    var m = moment(dateStr);

    addSuite(
        new Benchmark.Suite('plusMinusDaysAndHours')
            .add('js-joda', function () {
                dt.plusDays(1).minusDays(2).plusHours(24);
            })
            .add('moment', function () {
                m.add(1, 'days').subtract(2, 'days').add(24, 'hours');
            })
    );
})();