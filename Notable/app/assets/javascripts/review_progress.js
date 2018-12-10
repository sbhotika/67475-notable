$(document).on("click", ".delete-item", function() {
    $(this).parent().remove();
});

$(document).on("click", ".complete-item", function() {
    if ($(this).is(':checked')) { // true if the input checkbox is checked
        $(this).parent().css('text-decoration', 'line-through');
    } else {
        $(this).parent().css('text-decoration', 'none');
    }
});

$(document).on("click", "#add-item", function() {
    var list = $("#review-list");
    var itemInput = $("#new-list-item");
    list.append("<li><input type='checkbox' class='complete-item'>" + itemInput.val() + " <button class='delete-item'>X</button></li>");
});



