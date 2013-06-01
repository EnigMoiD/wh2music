`
window.sendAndConfirm = function(where){
    var data = new FormData($('.post-song')[0]);
    initializeSlider();
    $.ajax({
	type: 'POST',
	url: where,
	data: data,
	xhr: function(){
	    progressXhr = $.ajaxSettings.xhr();
	    if (progressXhr.upload){
		progressXhr.upload.addEventListener('progress',function(e){
		    updateProgress(e.loaded / e.total * 100);
		});
	    }
	    return progressXhr
	},
        error: function(xhr, type, e){console.log(e);e.preventDefault();return false;},
	success: function(data){
	    $('#upload').remove()
	    $('#uploads').removeClass('hide');
	    $('#playlist').addClass('hide');
	    $('.well').append(data);
	},
	cache: false,
	contentType: false,
	processData: false
    });
}

function initializeSlider(){
    $('#uploads').addClass('hide').after('<div id="upload"><div id="slider"></div></div>');
}

function updateProgress(complete){
    if (complete == 100)
	$('#upload').append('<p>Processing...</p>');
    $('#upload > #slider').css('width', complete + '%');
}

window.sendConfirmData = function(where){
    var data = new FormData($('.post-song')[0]);
    $.ajax({
	type: 'POST',
	url: where,
	data: data,
	complete: function(){},
	success: function(data){
	    $('#playlist').removeClass('hide');
	    $('#uploadbox').remove();
	},
	cache: false,
	contentType: false,
	processData: false
    });
}    
`