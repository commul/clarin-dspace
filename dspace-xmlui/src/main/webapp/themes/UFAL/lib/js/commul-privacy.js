/*global jQuery */
/*jshint globalstrict: true*/
'use strict';
var ufal = ufal || {};

ufal.handles = {

    init : function () {
    	if($('[name="privacy"]:checked').length == 0) {
    		$('[name="submit"]').prop( "disabled", true );
    	}
    	$('[name="privacy"]').one('change', function (e) {

    		$('[name="submit"]').prop( "disabled", !($('[name="privacy"]:checked')));

    	});
    }

};

jQuery(document).ready(function () {
    ufal.handles.init();
}); // ready
