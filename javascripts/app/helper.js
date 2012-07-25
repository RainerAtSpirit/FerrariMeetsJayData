/**
 * User: RainerAtSpirit
 * Date: 24.07.12
 * Time: 15:20
 */
define(function () {
    var fn = {
        cleanup : function (string) {
            var replacements = [
                    [/</g, ""],
                    [/>/g, ""],
                    [/\s/g, ""]
                ],
                str = string, i;
            for ( i = 0; i < replacements.length; i++ ) {
                str = str.replace(replacements[i][0], replacements[i][1]);
            }
            str = str.slice(0, 1).toUpperCase() + str.slice(1);
            return str;
        },

        dateRegExp : /^\/Date\((.*?)\)\/$/,

        toDate : function (value) {
            var date = this.dateRegExp.exec(value);
            return new Date(parseInt(date[1]));
        },

        toLink : function (value) {
            var href = value.split(',')[0];
            var text = value.substring(href.length + 2);
            return '<a href="' + href + '">' + text + '</a>';
        }
    };

    return {
        cleanup : fn.cleanup,
        toDate : fn.toDate,
        toLink : fn.toLink
    }
});
