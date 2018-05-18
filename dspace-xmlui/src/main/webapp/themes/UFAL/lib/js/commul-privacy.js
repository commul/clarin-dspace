/*global jQuery */
/*jshint globalstrict: true*/
'use strict';
var commul = commul || {};

commul.privacy = {

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
    commul.privacy.init();
}); // ready
