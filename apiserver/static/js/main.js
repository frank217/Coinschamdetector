/*
  `app` is initialized in index.html by the server.
  `app.sprites` and `app.coins` are already populated
*/

// app can trigger events
riot.observable(app);


// application state
app.selected = null;
app.search = "";
app.issues_min = 85;
app.pr_min = 85;
app.available = app.coins;
app.saved = [];
app.shelved = [];


// set the list of available IDs based on current app state
app.updateAvailableList = function() {
  app.available = app.coins.filter(function(coin) {
      if (coin.issues_score < app.issues_min) {
        return false;
      } else if (coin.pr_score < app.pr_min) {
        return false;
      } else if (app.saved.indexOf(coin.id) != -1) {
        return false;
      } else if (app.shelved.indexOf(coin.id) != -1) {
        return false;
      } else if (app.search && coin.title.toLowerCase().indexOf(app.search) == -1) {
        return false;
      }
      return true;
    })
    .map(function(coin) {
      return coin.id;
    });
};


// check if an ID is available
app.isAvailable = function(id) {
  return app.available.indexOf(id) != -1;
};


// check if an ID is saved
app.isSaved = function(id) {
  return app.saved.indexOf(id) != -1;
};


// check if an ID is shelved
app.isShelved = function(id) {
  return app.shelved.indexOf(id) != -1;
};


// globally update views when the model changes
app.on('update', function() {
  app.rootTag.update();
});


// app initialization
$(function() {
  // remove entries that don't have both ratings
  app.coins = app.coins.filter(function(m) {
    return m.pr_score >= 0 && m.issues_score >= 0;
  });
  // make a map for efficient look-up
  // also, add an 'average' rating for sorting
  app.coin_map = {};
  app.coins.forEach(function(m) {
    app.coin_map[m.id] = m;
    m.avg_score = (m.pr_score + m.issues_score) / 2;
  });

  // sort coins by average rating
  app.coins.sort(function(a, b) {
    if (a.avg_score < b.avg_score) {
      return 1;
    } else if (a.avg_score > b.avg_score) {
      return -1;
    }
    return 0;
  });

  app.updateAvailableList();

  // compile tags
  riot.compile(function() {
    // get a reference to the main view
    app.rootTag = riot.mount('main')[0];
  });
});
