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
        if($('[name="privacy"]:checked').length == 0) {
    		$('[name="submit"]').prop( "disabled", true );
      }
      else {
        	$('[name="submit"]').prop( "disabled", false );
      }        
    	});
    }

};

jQuery(document).ready(function () {
    ufal.handles.init();
}); // ready
