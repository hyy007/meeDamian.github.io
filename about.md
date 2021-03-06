---
layout: text-page
title: About
permalink: /about/
---

### I am a mobile<sup><small><i id="i-mobile" class="info mdi mdi-information-outline"></i></small></sup> developer building **native apps** for **Android** and **servers** in **Node.js** and **Go**; currently freelancing from **<a target="_blank" id="location" href="https://goo.gl/maps/NamBYKMgKU12">Taiwan</a>**<sup><small><i id="i-geo" class="info mdi mdi-information-outline"></i></small></sup>.

I am a minimalist, perfectionist and relativist. Always reliable internet tests diagnosed me as [INTJ-A][intj] and after solving enough logic charades I was invited to join [Mensa][mensa]. I am passionate about Futurism and all the technologies it will bring along. Being fascinated by the potential of [Artificial **Super** Intelligence][asi], I am curiously looking forward to witnessing the outcomes of [A.I.][agi] and [machine learning][machine] marriage. I am very drawn to decentralized technologies like [Blockchain][bc] or [Mesh Networks][mesh] and I am currently diving deeper into [R][r], [Go][go] and Machine Learning to teach my pet computer (and&nbsp;<span id="i-iot" class="info">_[internetted thingies][iot]_</span>) to play fetch.

<div class="mdl-tooltip" for="i-mobile">In the meaning of mobile apps,<br>as well as working remotely.</div>
<div class="mdl-tooltip" for="i-geo">Updated <span id="locUpdated">1 day ago</span></div>
<div class="mdl-tooltip" for="i-iot">Internet of Things</div>


#### Frequent guests at **my stack** party:

Android Studio, AngularJS, [Angular Material][material]¹, [Atom][atom]¹, [Bitcoin Core][bitcoin], [Go][go], [CloudFlare][cloudflare]¹, [ES6][es6]¹, [Coffee Script][coffee], [Iced Coffee Script][iced], Docker, Facebook API/SDKs, [Firebase][firebase], [GenyMotion][geny], Git¹, Github¹, Gist¹, [Github Pages][gh-pages]¹, Google APIs, [Google App Engine][gae], Google Chrome, Gradle, Grunt, [Gulp][gulp], Heroku¹, [Jade][jade], Android Java, JavaScript, Material Design¹, [Material Design Lite][mdl]¹, [Meteor][meteor], MongoDB, [Mongoose][mongoose], Node.js, [npm][npm], OSX, [Heroku][heroku]¹, Polymer, Postgres/PSQL¹, Socket.IO, [Travis CI][travis], Ubuntu, [yeoman][yo], [Goose][goose].

<small>¹ - Hidden behind pixels on this very website.</small>


### Contact:
* Call me: <a id="phone" href="tel:{{site.author.phone}}" target="_blank">{{site.author.phone}}</a>
* Email me: <a href="mailto:hello@meeDamian.com" target="_blank">hello@meeDamian.com</a>

<script>
  function prettyDate(date) {
   // JavaScript Pretty Date
   // Copyright (c) 2011 John Resig (ejohn.org)
   // Licensed under the MIT and GPL licenses.

    var diff = (((new Date()).getTime() - date.getTime()) / 1000),
      day_diff = Math.floor(diff / 86400);

    if (isNaN(day_diff) || day_diff < 0) {
      return;
    }

    return day_diff == 0 && (
        diff < 60 && "just now" ||
        diff < 120 && "1 minute ago" ||
        diff < 3600 && Math.floor(diff / 60) + " minutes ago" ||
        diff < 7200 && "1 hour ago" ||
        diff < 86400 && Math.floor(diff / 3600) + " hours ago"
      ) ||
      day_diff == 1 && "Yesterday" ||
      day_diff < 7 && day_diff + " days ago" ||
      day_diff < 42 && Math.ceil(day_diff / 7) + " weeks ago" ||
      day_diff < 365 && Math.round(day_diff / 30) + " months ago";
  }
  function updateLink(id, href, text, repWith) {
    repWith = repWith || '';
    var a = document.getElementById(id);
    a.href = href.replace(/ /g, repWith);
    a.textContent = text;
  }
  window.setCurrentData = function(json) {
    // PHONE
    if (json.phone) {
      var phoneHref = 'tel:' + json.phone.replace(/ /g, '');
      updateLink('phone', phoneHref, json.phone);
    }

    // LOCATION
    var mapsLink = 'https://maps.google.com/?q=';
    var query = [json.country, json.city]
      .filter(function(v){return !!v;})
      .join(', ')
      .replace(/ /g, '+');

    updateLink('location', mapsLink + query, json.country);

    // LOCATION UPDATED
    document.getElementById('locUpdated').textContent = prettyDate(new Date(json.relocated_at));
  };
  window.processGist = function(json) {
    var gist = json.data;
    var data = JSON.parse(gist.files['location.json'].content);
    data.relocated_at = gist.updated_at;
    setCurrentData(data);
  };
</script>
<script src="https://api.github.com/gists/{{site.author.gist}}?callback=processGist"></script>

<!-- Description -->
[intj]: https://www.linkedin.com/pulse/5-reasons-intjs-best-employees-penelope-trunk
[mensa]: https://www.mensa.org/
[agi]: https://en.wikipedia.org/wiki/Artificial_general_intelligence
[asi]: https://waitbutwhy.com/2015/01/artificial-intelligence-revolution-1.html
[bc]: https://en.bitcoin.it/wiki/Block_chain
[mesh]: https://en.wikipedia.org/wiki/Mesh_networking
[r]: https://en.wikipedia.org/wiki/R_(programming_language)
[go]: https://golang.org/
[machine]: https://en.wikipedia.org/wiki/Machine_learning
[iot]: https://en.wikipedia.org/wiki/Internet_of_Things

<!-- Stack -->
[material]: https://material.angularjs.org/latest/
[atom]: https://atom.io/
[bitcoin]: https://github.com/bitcoin/bitcoin
[cloudflare]: https://www.cloudflare.com/
[coffee]: https://goo.gl/9243VU
[iced]: https://maxtaco.github.io/coffee-script/
[firebase]: https://www.firebase.com/
[geny]: https://www.genymotion.com/#!/
[gh-pages]: https://pages.github.com/
[gae]: https://cloud.google.com/appengine/
[gulp]: https://goo.gl/YOmd3s
[jade]: https://goo.gl/7Tp9z0
[es6]: https://goo.gl/9MOQ28
[mdl]: https://www.getmdl.io/
[meteor]: https://www.meteor.com/
[mongoose]: https://goo.gl/hCne1O
[npm]: https://www.npmjs.com/~meedamian
[heroku]: https://www.heroku.com/
[travis]: https://travis-ci.org/
[yo]: https://goo.gl/505aDq
[goose]: https://bitbucket.org/liamstask/goose/
