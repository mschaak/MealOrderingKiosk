DP = {
  setup: function() {
    $('<div id="mealInfo"></div>').
      hide().
      appendTo($('body'));
    $('.detailsLink').on('click', DP.getMealInfo);
  },

  getMealInfo: function() {
    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: $(this).attr('href'),
      timeout: 5000,
      success: DP.showMealInfo,
      error: function(xhrObj, textStatus, exception) { alert('Error!'); }
    });
    $('.detailsLink').off('click', DP.getMealInfo);
    return(false);
  },

  showMealInfo: function(jsonData, requestStatus, xhrObject) {
    var dietHash3 = jsonData.dietary_restrictions;
    var diethash2 = dietHash3.replace(/:/gi, "").replace(/=>/gi, ":" ).
      replace('VGN', '"VGN"').
      replace('VGT', '"VGT"').
      replace('GF', '"GF"').
      replace('NF', '"NF"').
      replace('DF', '"DF"');
    var dietHash = JSON.parse(diethash2);
    console.log(dietHash)
    var dietToView = '';
    if (!dietHash.VGN && !dietHash.VGT && !dietHash.GF && !dietHash.NF && !dietHash.DF) {
      dietToView = dietToView.concat(dietToView,'N/A');
    }
    else{
      if (dietHash.VGN){dietToView = dietToView.concat('Vegan');}
      if (dietHash.VGT){
        if (dietHash.VGN){
          dietToView = dietToView.concat(', Vegetarian');}
        else {dietToView = dietToView.concat('Vegetarian');}}
      if (dietHash.GF){
        if (dietHash.VGN || dietHash.VGT ){dietToView = dietToView.concat(', Gluten Free');}
        else {dietToView = dietToView.concat('Gluten Free');}}
      if (dietHash.NF){
        if (dietHash.VGN || dietHash.VGT || dietHash.GF){dietToView = dietToView.concat(', Nut Free');}
        else {dietToView = dietToView.concat('Nut Free');}}
      if (dietHash.DF){
        if (dietHash.VGN || dietHash.VGT || dietHash.GF ||dietHash.NF){dietToView = dietToView.concat(', and Dairy Free');}
        else {dietToView = dietToView.concat('Dairy Free');}}
    }
    console.log(dietToView)
    // center a floater 1/2 as wide and 1/4 as tall as screen;
    var oneFourth = Math.ceil($(window).width() / 4);
    $('#mealInfo').css({'left': oneFourth,  'width': 2*oneFourth, 'top': 250}).
      append($('<p>' + jsonData.meal_name.fontsize(5).bold() + '</p>')).
      append($('<p>'+ 'Calories: '.bold() + jsonData.meal_calories + '</p>')).
      append($('<p>'+ 'Dietary Restrictions: '.bold() + dietToView+'</p>')).
      append($('<p>'+ 'Description: '.bold() + jsonData.description + '</p>')).
      append($('<a id="closeLink" href="#">CLOSE</a>')).show();
    // make the Close link in the hidden element work

    $('#closeLink').click(DP.hideMealInfo);
    return(false);  // prevent default link action
  },

  hideMealInfo: function() {
    $('#mealInfo').html('')
    $('#mealInfo').hide();
    $('.detailsLink').on('click', DP.getMealInfo);
    return(false);
  }
}
window.onload = DP.setup;

