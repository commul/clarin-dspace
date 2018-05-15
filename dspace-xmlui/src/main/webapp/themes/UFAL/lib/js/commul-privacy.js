/*global jQuery */
/*jshint globalstrict: true*/
'use strict';
var ufal = ufal || {};

ufal.handles = {

    init : function () {
    	if($('[name="privacy"]:checked').length == 0) {
    		$('[name="submit"]').prop( "disabled", true );
    	}
    	$('[name="privacy"]').on('change', function (e) {
        var chkBox = document.getElementsByName("privacy")[0];
    		$('[name="submit"]').prop( "disabled", !(chkBox.checked));

    	});
    }

};

jQuery(document).ready(function () {
    ufal.handles.init();
}); // ready
