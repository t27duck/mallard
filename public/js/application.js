$(document).ready(function() {
  $.ajaxSetup({
    cache: false
  });

  $(document).bind("keyup", "j", function() {
    $("#next-entry").trigger("click");
  });

  $(document).bind("keyup", "k", function() {
    $("#prev-entry").trigger("click");
  });

  $("#next-entry").on("click", function() {
    var $current = $(".panel-collapse.in");
    var $next;
    if ($current.size() > 0) {
      $next = $current.parent().next();
      if ($next.size() > 0) {
        $next.children(".panel-heading").trigger("click");
      }
    } else {
      $(".panel-heading:first").trigger("click");
    }
  });

  $("#prev-entry").on("click", function() {
    var $current = $(".panel-collapse.in");
    var $prev;
    if ($current.size() > 0) {
      $prev = $current.parent().prev();
      if ($prev.size() > 0) {
        $prev.children(".panel-heading").trigger("click");
      }
    } else {
      $(".panel-heading:last").trigger("click");
    }
  });

  $(".panel-heading").on("click", function() {
    $(".panel-collapse.in").each(function() {
      $(this).removeClass("in");
      $(this).children(".panel-body").html("");
      $(this).parent().children(".panel-heading").removeClass("selected");
    });

    var $this = $(this);
    var $body = $this.parent().children(".panel-collapse");
    var $body_inner = $body.children(".panel-body");
    var entry_id = $body.data("entry-id");
    var read_state = $body.data("read-state");
    var new_state = true;

    if (read_state.toString() === "true") {
      new_state = false;
    }

    $.ajax({
      url: "/entries/"+entry_id,
      type: "GET"
    }).done(function(data) {
      $body_inner.html(data);
      if ($("body").data("mobile-browser") === true) {
        $body_inner.fitVids();
      }
      $body.addClass("in");
      $this.addClass("selected");
      $this[0].scrollIntoView(true);
      if (new_state === true) {
        update_counter("unread", -1);
        $body.data("read-state", new_state);
      }
    });
  });

  $("#entry-list").on("click", ".star-entry", function() {
    event.preventDefault();
    var new_state, new_label, change_value;
    var entry_id = $(this).data("entry-id");
    var current = $(this).data("starred-state");
    if (current === true) {
      new_state = false;
      change_value = -1;
      new_label = i18n.star;
    } else {
      new_state = true;
      change_value = 1;
      new_label = i18n.unstar;
    }
    update_entry(entry_id, {"starred": new_state});
    update_counter("starred", change_value);
    $(this).html(new_label).data("starred-state", new_state);
  });

  $("#entry-list").on("click", ".read-entry", function() {
    var new_state, new_label, change_value;
    var entry_id = $(this).data("entry-id");
    var current = $(this).data("read-state");
    if (current === true) {
      new_state = false;
      change_value = 1;
      new_label = i18n.mark + " " + i18n.read;
    } else {
      new_state = true;
      change_value = -1;
      new_label = i18n.mark + " " + i18n.unread;
    }
    update_entry(entry_id, {"read": new_state});
    update_counter("unread", change_value);
    $(this).html(new_label).data("read-state", new_state);
    $(this).parent().parent().data("read-state", new_state);
  });

  $(window).resize(function() {
    if ($("#entry-list").size() > 0) {
      $("#entry-list").height($(window).height() - $("#entry-list").offset().top - 15);
    }
  });

  $(window).trigger("resize");
});

function update_entry(entry_id, data) {
  $.ajax({
    url: "/entries/"+entry_id,
    type: "POST",
    data: {"_method": "put", "entry": data},
    async: false
  });
}

function update_counter(which, changed_value) {
  var $counter = $("span."+which+"-count");
  $counter.html(parseInt($counter.html()) + changed_value);
}
